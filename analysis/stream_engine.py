"""全层流式引擎: 所有conv带输入历史, DeConv暂用无状态(12帧状态窗口已知)"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone\models")
import voc

class StreamConv:
    """任意k的因果卷积带历史"""
    def __init__(self, W, b, dil=1):
        self.W, self.b, self.dil = W, b, dil
        self.hist = np.zeros((0, W.shape[1]))
    def fwd(self, x):
        xp = np.concatenate([self.hist, x]) if len(self.hist) else x
        k = self.W.shape[2]
        self.hist = xp[-(k-1)*self.dil:] if (k-1)*self.dil else xp[:0]
        T = len(x)
        full = np.zeros((len(xp), self.W.shape[0]))
        for j in range(k):
            K = self.W[:, :, j]; o = self.dil*j
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
        h = self.cv1.fwd(voc.leaky(y))
        h = self.cv2.fwd(voc.leaky(h))
        return h + y

class StreamUpsampler:
    def __init__(self, i):
        self.i = i
        self.K, self.b, self.s = {1:(voc.DC1["K"],voc.DC1["b"],3),
                                   2:(voc.DC2["K"],voc.DC2["b"],5),
                                   3:(voc.DC3["K"],voc.DC3["b"],4)}[i]
        self.rbs = [StreamRB(i, r) for r in range(4)]
        self.xhist = np.zeros((0, {1:512,2:256,3:128}[i]))
    def fwd(self, x_in, aux):
        # DeConv: 无状态近似 (首12帧有已知状态误差)
        y = voc.deconv_transpose(voc.leaky(x_in), self.K, self.b, self.s)
        n = {1:48, 2:240, 3:960}[self.i]
        y = y[:n] + np.asarray(aux, np.float64)[:n]
        for rb in self.rbs:
            y = rb.fwd(y)
        return y

class StreamVocoder:
    def __init__(self):
        W0 = voc.Z["conv0.w"].reshape(512,7,100).transpose(0,2,1).astype(np.float64)[:,:,::-1]  # StreamConv tap方向
        self.c00 = StreamConv(W0, voc.Z["conv0.b"].astype(np.float64), 1)
        self.up1 = StreamUpsampler(1)
        self.up2 = StreamUpsampler(2)
        self.up3 = StreamUpsampler(3)
        self.sg_state = np.zeros(9)
        self.c28W = voc.Z["up2.rb11.c28.w"].reshape(18,7,64).transpose(0,2,1).astype(np.float64)  # StreamConv方向(不反转)
        self.c28 = StreamConv(self.c28W, voc.Z["up2.rb11.c28.b"].astype(np.float64), 1)
    def fwd(self, mel, f0):
        h00 = self.c00.fwd(np.asarray(mel,np.float64))
        exc, self.sg_state = voc.sinegen(f0, self.sg_state)
        h01 = voc.c01(exc); h10 = voc.c10(exc); h19 = voc.c19(exc)
        up1 = self.up1.fwd(h00, h01)
        up2 = self.up2.fwd(up1, h10)
        up3 = self.up3.fwd(up2, h19)
        h28 = self.c28.fwd(voc.leaky(up3))
        return dict(c00=h00, exc=exc, c01=h01, c10=h10, c19=h19,
                    up1=up1, up2=up2, up3=up3, c28=h28, spec=voc.istft_polar(h28))

if __name__ == "__main__":
    from vmrlib import raw as rawR
    def stats(a,b,skip=0):
        a=np.asarray(a,float)[skip:].ravel(); b=np.asarray(b,float)[skip:].ravel()
        m=np.isfinite(a)&np.isfinite(b)
        if m.sum()<10: return "EMPTY"
        return f"corr={np.corrcoef(a[m],b[m])[0,1]:.6f} rmse={np.sqrt(((a[m]-b[m])**2).mean()):.4f}"
    def unleaky(y): return np.where(y<0,y/0.2,y)
    eng = StreamVocoder()
    outs = []
    for it in range(3):
        mel = rawR(it,0,0)[:1600].reshape(16,100).astype(np.float64)
        f0raw = rawR(it,1,0).reshape(-1)
        # f0 从 aux 真值恢复: 用hook exc反推不可行, 直接用引擎的f0输入(我们有real_voc_in2)
        aux_in = np.fromfile(r"D:\vc_harness\build_v3\real_voc_in2.bin", dtype="<f4").reshape(16,2).astype(np.float64)
        o = eng.fwd(mel, aux_in)
        outs.append(o)
        # 验证各级 (iter>=1时跳状态窗口)
        skips = {0:8, 1:16, 2:24}
        print(f"--- iter{it} ---")
        print("  c00 :", stats(o["c00"], rawR(it,0,1)[:8192].reshape(16,512), 6))
        print("  c01 :", stats(o["c01"], rawR(it,1,1)[:12288].reshape(48,256), 4))
        rb0a_gt = rawR(it,2,0)[:12288].reshape(48,256)
        d1m = voc.deconv_transpose(voc.leaky(o["c00"]), voc.DC1["K"], voc.DC1["b"], 3) + o["c01"]
        print("  Up1入口:", stats(voc.leaky(d1m), rb0a_gt, 8))
        # up2 真值
        aux2 = rawR(it,10,1).reshape(-1,128).astype(np.float64)
        pre4 = rawR(it,11,0).reshape(-1,128).astype(np.float64)
        d2t = unleaky(pre4)-aux2
        up2t = d2t.copy()
        for L in (1,3,5,7): up2t = up2t + rawR(it,11+L,1).reshape(-1,128).astype(np.float64)[:len(up2t)]
        print("  up2  :", stats(o["up2"][:128], up2t[:128], 16))
        c28gt = rawR(it,28,1)[:910*18].reshape(910,18)
        if np.isfinite(c28gt[:256]).all():
            print("  c28  :", stats(o["c28"][:256], c28gt[:256], 60))
