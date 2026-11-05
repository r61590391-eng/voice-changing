# 大饼AI变声 · 端侧模型逆向提取

## 这个包是什么

大饼APP 的变声功能由三个端侧模型接力完成：

```
你的声音 → [bn 听懂内容] → [am 翻译成目标音色] → [voc 生成声音波形] → 变声结果
```

本包包含从 APK 中逆向提取的全部成果。

## 做到了哪一步

| | 权重（大脑） | 结构（图纸） | 推理代码（造出来能跑） |
|---|---|---|---|
| **bn** 内容编码器 | ✅ 34M参数 | ✅ 305层布局闭环 | ❌ 待实现 |
| **am** 声学模型 | ✅ 21M参数 | ✅ 371层布局闭环 | ❌ 待实现 |
| **voc** 声码器 | ✅ 12M参数 | ✅ 29层全部确认 | ✅ **完整实现，逐层精确** |

**简单说：三台机器的大脑和图纸都拿到了，最后一台（voc）已经造出来能独立跑了。**

## 怎么用（voc 部分）

```python
from final_engine import VocoderEngine, synth_pcm
import numpy as np

eng = VocoderEngine()
mel = ...    # [16, 100] mel特征（需要bn/am产出，目前无法从真实语音直接获得）
f0  = ...    # [16, 2] 基频Hz
out = eng.fwd(mel, f0)
pcm = synth_pcm(out["spec"])  # int16[3840] @24kHz
```

voc 接受 mel+f0 输入，输出声码器特征（spec）和 PCM。
逐层验证精度 corr=1.0（机器精度），连续流式 corr>0.99。

## 为什么现在听不到变声音频

bn 和 am 还没实现，真实语音无法转换成 voc 需要的输入格式。
工作量大约各是 voc 的 1-2 倍（层数更多、有注意力机制）

## 文件说明

```
final_engine.py        voc独立推理引擎（纯numpy，29层）
stream_heads.py        c01/c10跨chunk历史处理
frontend.py            PCM→mel特征提取
models/voc.py          全部层的数学实现
weights/
  voc 相关:
    voc_tensors.npz      模型文件直提张量 (26MB)
    all_voc_kernels.npz  24个RB卷积核 (12MB)
    dc1/dc2/dc3_*.npz    DeConv卷积核 (9MB)
    c1/c10/c19_*.npz     头部卷积核
    tail_wide_fit.npz    尾部合成系数
  bn 相关:
    bn_tensors.npz       全部权重 (25MB)
    bn_meta.json         层布局（偏移/维度/参数）
  am 相关:
    am_tensors.npz       全部权重 (16MB)
    am_meta.json         层布局
```

## 逆向方法概要

1. APK 内 AES 加密模型 → 解密为裸 float32
2. 构造函数消费顺序 + 对象指针差 → 全张量偏移表闭环
3. RB 卷积核从文件直提（tap反转即位精确）
4. DeConv 核从真实语音数据最小二乘拟合
5. GOT 劫持 Conv1d::forward 采集运行时输入输出对
6. ResBlock 残差 = leaky 前的输入（反汇编确认，hook 抓不到）

## 已知限制

1. voc 的 DeConv 环形缓冲状态在跨数据集时有过拟合风险
2. 尾部 PCM 合成为经验近似（corr~0.23），精确索引待校准
3. bn/am 推理未实现，权重和布局已备好
4. FeatureExtract（PCM→mel）RMSE 0.37


