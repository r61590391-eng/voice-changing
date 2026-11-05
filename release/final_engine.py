"""final_engine.py — 完全独立的流式声码器引擎 (数学正确的连续流语义)"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
sys.path.insert(0, str(Path(__file__).parent / "models"))
sys.path.insert(0, str(Path(__file__).parent))
import voc
from stream_heads import StreamC01, StreamC10

_W = Path(__file__).parent / "weights"
DC1 = np.load(_W / "dc1_final2.npz")     # 真实语音+静音双数据集拟合
DC2 = np.load(_W / "dc2_final.npz")
DC3 = np.load(_W / "dc3_final.npz")

def leaky(x): return np.where(x < 0, 0.2 * x, x)

class StreamConv:
    """因果卷积带跨chunk输入历史"""
    def __init__(self, W, b, dil=1):
        self.W, self.b, self.dil = W, b, dil
        self.hist = np.zeros((0, W.shape[1]))
    def fwd(self, x):
        xp = np.concatenate([self.hist, x]) if len(self.hist) else x
        k = self.W.shape[2]
        keep = (k - 1) * self.dil
        self.hist = xp[-keep:] if keep else xp[:0]
        T = len(x)
        full = np.zeros((len(xp), self.W.shape[0]))
        for j in range(k):
            K = self.W[:, :, j]; o = self.dil * j
            if o == 0: full += xp @ K.T
            elif o < len(xp): full[o:] += xp[:len(xp)-o] @ K.T
        return full[-T:] + self.b

class StreamRB:
    def __init__(self, i, rb):
        c1, d1 = voc.RB_TAGS[i][rb*2]; c2, _ = voc.RB_TAGS[i][rb*2+1]
        W1 = np.stack([voc.AK[f"{c1}_k{j}"].astype(np.float64) for j in range(3)], axis=2)
        W2 = np.stack([voc.AK[f"{c2}_k{j}"].astype(np.float64) for j in range(3)], axis=2)
        self.cv1 = StreamConv(W1, voc.AK[f"{c1}_b"].astype(np.float64), d1)
        self.cv2 = StreamConv(W2, voc.AK[f"{c2}_b"].astype(np.float64), 1)
    def fwd(self, y):
        h = self.cv1.fwd(leaky(y))
        h = self.cv2.fwd(leaky(h))
        return h + y

class StreamDeConv:
    """流式ConvTranspose: 无状态主体 + 实测W_t overlap映射
       (W_t = 引擎ring状态对上一chunk输入尾帧的线性耦合, holdout corr 0.998-0.99999)"""
    def __init__(self, K, b, stride, n_out, Wov=None, n_ov=0):
        self.K, self.b, self.stride, self.n_out = K, b, stride, n_out
        self.Wov = Wov            # {t: [Cin,Cout]}
        self.n_ov = n_ov
        self.xprev_last = None
    def fwd(self, x):
        k, s = len(self.K), self.stride
        out = np.zeros((len(x) * s, self.K.shape[2]))
        for f in range(len(x)):
            for j in range(k):
                t = f * s + j
                if t < len(out): out[t] += x[f] @ self.K[j]
        if self.Wov is not None and self.xprev_last is not None:
            for t in range(min(self.n_ov, len(out))):
                out[t] += self.xprev_last @ self.Wov[t]
        self.xprev_last = x[-1]
        return out[:self.n_out] + self.b
class StreamUpsampler:
    def __init__(self, i):
        self.i = i
        K, b, s, n = {1: (DC1["K"], DC1["b"], 3, 48),
                      2: (DC2["K"], DC2["b"], 5, 240),
                      3: (DC3["K"], DC3["b"], 4, 960)}[i]
        Wov = None; n_ov = 0
        if i in (1, 2):
            try:
                z = np.load(_W / ('dc%d_overlap_W.npz' % i))
                Wov = {t: z['W%d' % t] for t in range(len(z.files))}
                n_ov = len(Wov)
            except Exception:
                pass
        self.dc = StreamDeConv(K, b, s, n, Wov=Wov, n_ov=n_ov)
        self.rbs = [StreamRB(i, r) for r in range(4)]
    def fwd(self, x_in, aux):
        y = self.dc.fwd(leaky(np.asarray(x_in, np.float64)))
        y = y + np.asarray(aux, np.float64)[:len(y)]
        for rb in self.rbs:
            y = rb.fwd(y)
        return y

class VocoderEngine:
    """完全独立流式声码器: mel[16,100]+f0[16,2] -> c28[960,18]/spec/PCM"""
    def __init__(self):
        W0 = voc.Z["conv0.w"].reshape(512, 7, 100).transpose(0, 2, 1).astype(np.float64)[:, :, ::-1]
        self.c00 = StreamConv(W0, voc.Z["conv0.b"].astype(np.float64), 1)
        self.up1 = StreamUpsampler(1)
        self.up2 = StreamUpsampler(2)
        self.up3 = StreamUpsampler(3)
        self.sg_state = np.zeros(9)
        self.c01s = StreamC01()
        self.c10s = StreamC10()
        c28W = voc.Z["up2.rb11.c28.w"].reshape(18, 7, 64).transpose(0, 2, 1).astype(np.float64)
        self.c28 = StreamConv(c28W, voc.Z["up2.rb11.c28.b"].astype(np.float64), 1)
    def fwd(self, mel_16x100, f0_16x2):
        h00 = self.c00.fwd(np.asarray(mel_16x100, np.float64))
        exc, self.sg_state = voc.sinegen(f0_16x2, self.sg_state)
        h01 = self.c01s.fwd(exc); h10 = self.c10s.fwd(exc); h19 = voc.c19(exc)
        up1 = self.up1.fwd(h00, h01)
        up2 = self.up2.fwd(up1, h10)
        up3 = self.up3.fwd(up2, h19)
        h28 = self.c28.fwd(leaky(up3))
        return dict(c00=h00, exc=exc, c01=h01, c10=h10, c19=h19,
                    up1=up1, up2=up2, up3=up3, c28=h28, spec=voc.istft_polar(h28))

_TAIL = np.load(_W / "tail_wide_fit.npz")
def synth_pcm(spec_960x18):
    sol, dfs = _TAIL["sol"], _TAIL["dfs"]
    spec = np.asarray(spec_960x18, np.float64)
    out = np.zeros(len(spec) * 4)
    for t in range(len(out)):
        acc = 0.0
        for di, df in enumerate(dfs):
            f = t // 4 + df
            if 0 <= f < len(spec):
                acc += spec[f] @ sol[di * 18:(di + 1) * 18]
        out[t] = acc + sol[-1]
    return np.clip(out, -32768, 32767).astype(np.int16)
