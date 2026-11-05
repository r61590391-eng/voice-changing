"""带跨chunk历史的 c01/c10 (窗口延伸到上一chunk的exc尾部)"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
_W = Path(__file__).parent / "weights"

class StreamC01:
    """c01: out[t] = K[256,80] @ exc_ext[40(t-2)+2 : +80]; 帧边界用上一chunk的exc历史"""
    def __init__(self):
        z = np.load(_W / "c1_true_kernel.npz")
        self.K = z["kernel"].astype(np.float64)          # [256,80]
        self.b = np.load(_W / "c1_baseline.npy").reshape(48, 256).astype(np.float64)
        self.hist = np.zeros(0)                          # 上chunk exc flat尾
    def fwd(self, exc):
        ext = np.concatenate([self.hist, exc]) if len(self.hist) else exc
        base = len(self.hist)                            # 当前chunk首样本在ext中的下标
        T = 48
        out = np.zeros((T, 256))
        for t in range(T):
            s = 40 * (t - 2) + 2 + base
            if s < 0: s = 0
            if s + 80 <= len(ext):
                out[t] = self.K @ ext[s:s + 80]
        out += self.b
        self.hist = ext[-(78 + 40):] if len(ext) > 118 else ext   # 覆盖下chunk帧0/1的窗口
        return out

class StreamC10:
    """c10: out[t] = sum_j K[j,128] * ext[8t-14+j]; 需要14个历史float"""
    def __init__(self):
        z = np.load(_W / "c10_kernel_fit.npz")
        self.K = z["K"].astype(np.float64)                # [18,128]
        self.b = z["b"].astype(np.float64)
        self.d0 = int(z["d0"])                            # -14
        self.hist = np.zeros(0)
    def fwd(self, exc):
        ext = np.concatenate([self.hist, exc]) if len(self.hist) else exc
        base = len(self.hist)
        T = 240
        out = np.zeros((T, 128))
        for t in range(T):
            acc = np.zeros(128)
            for j in range(len(self.K)):
                p = 8 * t + self.d0 + j + base
                if 0 <= p < len(ext):
                    acc += self.K[j] * ext[p]
            out[t] = acc
        out += self.b
        need = 14
        self.hist = ext[-need:] if len(ext) >= need else ext
        return out

if __name__ == "__main__":
    from vmrlib import raw as rawR
    sys.path.insert(0, str(Path(__file__).parent / "models"))
    import voc as V
    def stats(a, b, skip=0):
        a = np.asarray(a, float)[skip:].ravel(); b = np.asarray(b, float)[skip:].ravel()
        return f"corr={np.corrcoef(a, b)[0,1]:.8f} rmse={np.sqrt(((a-b)**2).mean()):.4f}"
    c01 = StreamC01(); c10 = StreamC10()
    for it in range(4):
        exc = rawR(it, 1, 0)[:1920].astype(np.float64)
        o1 = c01.fwd(exc); o10 = c10.fwd(exc)
        g1 = rawR(it, 1, 1)[:12288].reshape(48, 256)
        g10 = rawR(it, 10, 1).reshape(-1, 128)
        print(f"it{it}: c01全帧 {stats(o1, g1)} | c10全帧(0..127) {stats(o10[:128], g10[:128])}")
