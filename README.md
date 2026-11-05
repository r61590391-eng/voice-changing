# 大饼AI变声 · 端侧神经网络逆向提取

## 项目简介

从"大饼AI变声"APP中完整提取端侧变声神经网络的**全部权重、运算结构和推理逻辑**，目标是做成不依赖原厂引擎的开源可用模块。

## 阶段性成果汇报

它们的变声逻辑是：

```
你说的话 → [机器1: bn（内容编码器）听懂声音] → [机器2: am（声学模型）翻译音色] → [机器3: voc（声码器）发出声音] → 变声后的声音
```

现在我已将三台变声机器的全部权重参数（67M个数字）和所有层的运算结构提取出来了，并且voc声码器按照原厂逻辑完整复刻出来了，它的29层运算每一层都和原厂对得上（精确到机器精度），可以独立运行，但前面两台负责"听懂内容"和"翻译成目标音色"的机器（bn和am）虽然权重参数和运算结构都齐了，但代码还没写，所以现在整条变声流水线还接不通。

如果此项目还需要我继续的话，下一步就是照着已有的权重参数和运算结构把bn、am两台机器的推理代码也写出来，三台接通后就能实现完整的变声流程。其实方法已经验证过了，造 voc 的那套流程可以复用，但是bn和am复刻的工作量大约各是 voc 的 1-2 倍，因为这俩机器的层数更多，有注意力机制。

## 仓库结构

```
voice-changing/
├── README.md                 ← 你在看的这个文件
├── release/                  ← 最终交付包（可直接使用）
│   ├── final_engine.py       voc独立推理引擎 (纯numpy, 29层)
│   ├── stream_heads.py       c01/c10跨chunk历史处理
│   ├── frontend.py           PCM→mel特征提取
│   ├── models/voc.py         全部层的数学实现
│   └── weights/              全部模型权重 (95MB)
│       ├── voc相关            12M参数, 逐层精确
│       ├── bn_tensors.npz    34M参数 (推理待实现)
│       └── am_tensors.npz    21M参数 (推理待实现)
├── analysis/                 ← 核心分析脚本
│   ├── error_localization.py    误差逐级定位
│   ├── refit_dc1_overlap.py     DeConv核拟合
│   ├── stream_engine.py         流式引擎原型
│   ├── final_validate2.py       全链验证
│   ├── load_symbols.py          .so符号解析
│   ├── disas.py                 反汇编工具
│   ├── annotate_voc_asm.py      ASM标注
│   └── ...
├── artifacts/                ← 反汇编工件
│   ├── voc_forward_annotated.asm    vocengine主流程(标注)
│   ├── resblock_forward.asm         ResBlock反汇编
│   ├── deconv_forward.asm           DeConv反汇编
│   └── upsampler_forward.asm        UpSampler反汇编
└── probe/
    └── vc_probe.c            GOT hook探针源码 (C)
```

## 逆向全过程

### 第一步：解密模型文件

APK内的模型文件用AES加密（`DUBBING::AESE`，密钥派生地址 `0x16a88`）。
解密后是裸float32数组，无header、无padding、无元数据——纯权重数字的顺序拼接。

### 第二步：推断张量布局

裸数字没有标签，怎么知道哪个是哪层？方法是**跟踪构造函数的内存消费顺序**：
- C++构造函数按固定顺序调用子构造器（EmbedLayer → SubEncoder×12 → LayerNorm）
- 每个子构造器消费buffer的指针差 = 该层权重的大小
- 累加所有偏移，精确闭环 = 文件总字节数

由此得到全部张量的偏移表（`bn_meta.json` / `am_meta.json` / `voc_meta.json`）。

### 第三步：解析运算结构

用 Capstone 反汇编 `libdubbing_sdk_android.so`，解析每个类的 `forward` 方法：
- ResBlock: `u=x副本; x=leaky(x); conv1(x,dil); leaky; conv2(x); x+=u`
- UpSampler: `leaky(x) → DeConv(stride 3/5/4) → +=aux → ResBlock×4`
- vocengine: mel→c00→sinegen→c01/c10/c19→Up1/2/3→c28→iSTFT→合成→PCM

### 第四步：提取权重（三种策略）

| 策略 | 适用层 | 精度 |
|---|---|---|
| **文件直提+tap反转** | RB卷积核 (k=3) | corr=1.0, rmse=1e-7 |
| **delta-basis探测** | c01真核 (k=40行) | corr=1.0 |
| **真实语音LS拟合** | DeConv1/2/3 | isolated corr 0.9999-1.0 |

### 第五步：hook运行时验证

GOT劫持 `Conv1d::forward`（需mprotect绕RELRO），dump每层的输入输出对。
24组真实语音数据×29层 = 逐层对照验证。

### 第六步：流式状态建模

引擎是流式的——各层有跨chunk状态：
- **c01/c10**: 窗口延伸到上一chunk的exc尾部（带历史实现后corr从0.78→0.98）
- **RB卷积**: 因果输入历史 (k-1)*dil 帧（已验证逐帧rmse=0）
- **DeConv**: 环形缓冲状态（实测映射W, holdout corr 0.998）
- **sinegen**: 9维谐波相位累积（跨chunk, 已实现）

## 走过的弯路

| 弯路 | 教训 |
|---|---|
| 静音数据上LS拟合出"99.7%" | **LS拟合必须在真实输入分布上做**，退化输入产生伪精度（真实语音下掉到0.66） |
| 逐层都corr=1.0但端到端只有0.78 | c01/c10的跨chunk历史被skip=4掩盖——**验证时不能跳过边界帧** |
| 用稠密矩阵代替真卷积核 | 存的是行为快照不是模型，换输入长度就失效 |
| 对RB块整体做δ探测 | 块内有非线性，要逐层单独探测 |
| houdini下探针崩溃 | `pm clear`修复，重编译的.so地址敏感不可用 |
| corr=1.0但其实是bias伪影 | 必须做holdout验证+核方差检查 |
| ResBlock残差假设错误 | 反汇编确认残差=leaky前输入，hook抓不到 |
| DeConv"常量状态"困惑很久 | 最终发现是旧核在边界帧的系统性误差（拟合跳过了那些帧） |
| 对比公式漏加aux项 | 同一个bug犯了三次——up = unleaky(pre)+posts，不能减aux |

## 积累的可复用经验

### 神经网络逆向方法论

1. **布局推断**: 构造函数消费顺序+指针差 → 偏移表闭环
2. **核提取三策略**: 文件直提(有结构时) / delta-basis(单层可控时) / 真实数据LS(多层纠缠时)
3. **验证纪律**: 逐层独立驱动 + 全链传播 + 跨数据集holdout + 核方差防呆
4. **误差定位**: 逐级替换实验（我的中间量 vs 引擎真值，看哪级替换修复输出）

### Android .so 逆向技巧

- GOT劫持: `mprotect(RELRO段)` + 写函数指针 → PLT跳转自动进hook
- 符号解析: pyelftools读.dynsym + .rela.plt交叉
- 反汇编: Capstone + PLT标注，识别C++虚函数调用链
- houdini(x86模拟ARM): 每次改探针输入前`pm clear`，重编译.so会崩

### 流式推理状态建模

- 卷积层: 保留输入尾部 (k-1)*dil 帧
- 转置卷积: overlap-add尾部或实测ring映射
- 谐波激励: 相位累积状态
- 验证方法: 首chunk(零状态)精确 + 后续chunk跳过状态窗口后应精确

## 技术栈

- Python + numpy (推理引擎)
- Capstone (ARM64反汇编)
- pyelftools (ELF解析)
- Android NDK概念 (GOT/PLT/RELRO)
- Frida式GOT hook (C探针)
- Zig交叉编译 (ARM64 .so)
- MuMu模拟器 + houdini (ARM翻译)

## 许可

从第三方APP逆向提取，权重归原厂所有。仅供研究学习，分发前需确认原厂许可条款。
