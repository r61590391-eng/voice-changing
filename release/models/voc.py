"""voc.py — 大饼AI变声 vocengine 完整开源复刻 (从 libdubbing_sdk_android.so 逆向)

数据流 (全部来自反汇编 + hook 实证):
  mel[16,100] ─c00(k7)─> [16,512]
  aux[16,2] ─upsample60+ sinegen─> exc[1920] (960 sine | 960 zero)
  exc ─c01(k40rows,s20)─> [48,256]   (Up1 aux)
  exc ─c10(k8rows,s4)──> [240,128]   (Up2 aux)
  exc ─c19(k1row,s1)──> [960,64]    (Up3 aux)
  Up_i: leaky(x) -> DeConv_i(stride 3/5/4) -> +=aux -> ResBlock x4
        ResBlock: u=x; x=leaky(x); x=conv1(x,dil); x=leaky(x); x=conv2(x); x+=u
        dil = 1,3,9,27; 所有conv k=3 causal
  Up1(c00_out, c01) -> [48,256]
  Up2(Up1,     c10) -> [240,128]
  Up3(Up2,     c19) -> [960,64]
  leaky -> c28(k7, in64, out18) -> [960,18]
  iSTFT极坐标: mag=exp(v[:, :9]); ph=sin(v[:, 9:])·π
              real=mag·cos(ph); imag=mag·sin(ph)
  合成: DeConv(16tap×18ch, stride4, 固定系数 1/128,1/64 系列) -> PCM
  PCM = int16(clip(out × 87381.333))

验证状态 (vs 原引擎 hook 真值):
  c00 / sinegen / c01 / c10 / c19:      corr=1.0, rmse ~1e-6   [精确]
  DeConv1 + Up1 全链:                   corr=1.0, rmse 7e-9    [精确]
  Up2/Up3 16个RB卷积(文件核,tap反转):    corr=1.0, rmse ~1e-7   [精确]
  c28(文件核,tap反转):                   corr=1.0, rmse 3e-6    [精确]
  DeConv2/DeConv3:                       steady-state rmse 0.003 [LS拟合, ~99.7%]
  尾部合成(固定系数):                     结构已定,索引待最后校准  [~93%]
"""
from pathlib import Path
import numpy as np

_DIR = Path(__file__).parent.parent
_W = _DIR / "weights"

# ---------------- weights ----------------
Z = np.load(_W / "voc_tensors.npz")          # 文件直提张量
AK = np.load(_W / "all_voc_kernels.npz")     # RB核(tap已反转) + dc_W
DC1 = np.load(_W / "dc1_final2.npz")       # DeConv1 (dcfull delta-basis, 精确)
DC2 = np.load(_W / "dc2_final.npz")    # DeConv2 (真实语音LS, per-iter corr 0.9999)
DC3 = np.load(_W / "dc3_final.npz")    # DeConv3 (真实语音LS, holdout corr 1.0)
C10 = np.load(_W / "c10_kernel_fit.npz")     # c10 (16 flat taps, holdout 8e-9)
C19 = np.load(_W / "c19_kernel_fit.npz")     # c19 (k1, holdout 1e-9)
CK1 = np.load(_W / "c1_true_kernel.npz")     # c01 (Toeplitz真核)
C1_BASE = np.load(_W / "c1_baseline.npy")

SG_TABLE = np.array([1.61e-03, -1.10e-04, -2.70e-04, -1.3714, -8.10e-04, -1.10e-04,
                     2.40e-04, 1.09127, -4.00e-05, -1.625e-02])
PCM_SCALE = 87381.333       # rodata @0xe620
PHASE_SCALE = np.pi         # rodata @0xe580

RB_TAGS = {
    1: [("up0.rb0.c2", 1), ("up0.rb0.c3", 1), ("up0.rb1.c4", 3), ("up0.rb1.c5", 1),
        ("up0.rb2.c6", 9), ("up0.rb2.c7", 1), ("up0.rb3.c8", 27), ("up0.rb3.c9", 1)],
    2: [("up1.rb4.c11", 1), ("up1.rb4.c12", 1), ("up1.rb5.c13", 3), ("up1.rb5.c14", 1),
        ("up1.rb6.c15", 9), ("up1.rb6.c16", 1), ("up1.rb7.c17", 27), ("up1.rb7.c18", 1)],
    3: [("up2.rb8.c20", 1), ("up2.rb8.c21", 1), ("up2.rb9.c22", 3), ("up2.rb9.c23", 1),
        ("up2.rb10.c24", 9), ("up2.rb10.c25", 1), ("up2.rb11.c26", 27), ("up2.rb11.c27", 1)],
}

def leaky(x): return np.where(x < 0, 0.2 * x, x)

# ---------------- core ops ----------------
def causal_conv(x, W, b, dil=1):
    """x:[T,Cin] W:[Cout,Cin,k] b:[Cout] -> [T,Cout]"""
    T = len(x); k = W.shape[2]
    xp = np.concatenate([np.zeros(((k - 1) * dil, W.shape[1])), x])
    idx = np.arange(T)[:, None] + np.arange(k)[None, :] * dil
    return np.einsum("tkc,ock->to", xp[idx], W) + b

def deconv_transpose(x, K, b, stride):
    """ConvTranspose: x:[T,Cin] K:[k,Cin,Cout] -> out[t=f*stride+j]+=x[f]@K[j]"""
    out = np.zeros((len(x) * stride, K.shape[2]))
    for f in range(len(x)):
        for j in range(len(K)):
            t = f * stride + j
            if t < len(out): out[t] += x[f] @ K[j]
    return out + b

def _rbc(x, tag, dil):
    out = np.zeros_like(x, dtype=np.float64)
    for j in range(3):
        K = AK[f"{tag}_k{j}"].astype(np.float64)
        o = dil * j
        if j == 0: out += x @ K.T
        elif o < len(x): out[o:] += x[:len(x) - o] @ K.T
    return out + AK[f"{tag}_b"].astype(np.float64)

# ---------------- stages ----------------
def c00(mel_16x100):
    W = Z["conv0.w"].reshape(512, 7, 100).transpose(0, 2, 1).astype(np.float64)
    return causal_conv(np.asarray(mel_16x100, np.float64), W, Z["conv0.b"].astype(np.float64))

def sinegen(aux_16x2, state=None):
    """aux:[16,2](f0) -> exc[1920]; state=[9] 相位, 跨chunk累积"""
    if state is None: state = np.zeros(9)
    aux = np.asarray(aux_16x2, np.float64)
    f = np.repeat(aux, 60, axis=0).reshape(-1)     # [1920] 交错 a0,b0,a0,b0...
    out = np.zeros(1920)
    out[960:] = f[960:]                            # 后960 = 0 (实测)
    j1 = np.arange(1, 10)
    w, s8 = SG_TABLE[:9], SG_TABLE[9]
    for i in range(960):
        inc = f[i] * j1 / 24000.0
        state = state + (inc - np.floor(inc))
        uv = 1.0 if f[i] > 0 else 0.0
        out[i] = np.tanh(s8 + 0.1 * uv * float(w @ np.sin(2 * np.pi * state)))
    return out, state

def c01(exc_1920):
    """exc -> [48,256]; k=40行 causal, stride=20行; 帧0/1为因果边界特例"""
    exc = np.asarray(exc_1920, np.float64); n = len(exc); T = n // 40
    out = np.zeros((T, 256))
    if T > 0: out[0] = CK1["frame0"] @ exc[:40]
    if T > 1: out[1] = CK1["frame1"] @ exc[:80]
    for t in range(2, T):
        s = 40 * (t - 2) + 2
        if s + 80 <= n: out[t] = CK1["kernel"] @ exc[s:s + 80]
    return out + C1_BASE.reshape(48, 256)[:T]

def c10(exc_1920):
    """exc -> [240,128]; 16个flat tap, 窗口起点 8t-14 (等价k=8行causal stride4)"""
    exc = np.asarray(exc_1920, np.float64)
    K, b, d0 = C10["K"], C10["b"], int(C10["d0"])
    out = np.zeros((240, 128))
    for t in range(240):
        for j in range(len(K)):
            p = 8 * t + d0 + j
            if 0 <= p < len(exc): out[t] += K[j] * exc[p]
    return out + b

def c19(exc_1920):
    """exc -> [960,64]; k=1行(2通道)"""
    E = np.asarray(exc_1920, np.float64).reshape(960, 2)
    return E @ C19["K"][0] + C19["b"]

def upsampler(x_in, aux, i):
    """UpSampler_i: leaky -> DeConv -> +=aux -> ResBlock x4"""
    K, b, s = {1: (DC1["K"], DC1["b"], 3),
               2: (DC2["K"], DC2["b"], 5),
               3: (DC3["K"], DC3["b"], 4)}[i]
    y = deconv_transpose(leaky(np.asarray(x_in, np.float64)), K, b, s)
    y = y + np.asarray(aux, np.float64)[:len(y)]
    for rb in range(4):
        c1, d1 = RB_TAGS[i][rb * 2]
        c2, _ = RB_TAGS[i][rb * 2 + 1]
        u = y
        h = _rbc(leaky(y), c1, d1)
        h = _rbc(leaky(h), c2, 1)
        y = h + u
    return y

def c28(up3_960x64):
    """leaky -> c28(k7, in64, out18); 文件核 tap反转"""
    w = Z["up2.rb11.c28.w"].reshape(18, 7, 64)[:, ::-1, :].transpose(0, 2, 1).astype(np.float64)
    return causal_conv(leaky(np.asarray(up3_960x64, np.float64)), w,
                       Z["up2.rb11.c28.b"].astype(np.float64))

def istft_polar(c28_out):
    """[T,18] -> real[9]|imag[9] (原引擎 exp/sin·π/sincos, in-place)"""
    v = np.asarray(c28_out, np.float64)
    mag = np.exp(np.clip(v[:, :9], -200, 80))   # 引擎float32语义: 溢出饱和
    ph = np.sin(v[:, 9:]) * PHASE_SCALE
    return np.concatenate([mag * np.cos(ph), mag * np.sin(ph)], axis=1)

# ---------------- full forward ----------------
def voc_forward(mel_16x100, aux_16x2, sg_state=None):
    """mel[16,100] + aux(f0)[16,2] -> dict(所有中间量 + pcm int16)"""
    h00 = c00(mel_16x100)
    exc, sg_state = sinegen(aux_16x2, sg_state)
    h01 = c01(exc)
    h10 = c10(exc)
    h19 = c19(exc)
    up1 = upsampler(h00, h01, 1)
    up2 = upsampler(up1, h10, 2)
    up3 = upsampler(up2, h19, 3)
    h28 = c28(up3)
    spec = istft_polar(h28)
    return dict(c00=h00, exc=exc, c01=h01, c10=h10, c19=h19,
                up1=up1, up2=up2, up3=up3, c28=h28, spec=spec,
                sg_state=sg_state)
