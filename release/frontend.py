"""frontend.py — FeatureExtract 复刻 (PCM16 → log-mel[19,80])

原厂参数(逆向实证):
  win=400 samples (Hann, 表从 so dump)
  preemph = -0.97, 首样本置0, 帧内去均值
  FFT=512 (谱布局: 功率谱 bin 0..256)
  mel = W @ P (W=运行时校准的 512x80 插值重采样矩阵)
  log = ln(x + 0.01)
  hop=256, 每 4096 样本产出 16 新帧 + 3 上下文帧

状态: RMSE 0.37 vs gt (残余=原厂FFT泄漏噪声底, 理想FFT高频为零)
      对 voc/am 复刻已够用; 像素级对齐需再校准 FFT 泄漏
"""
import numpy as np
from pathlib import Path

_DIR = Path(__file__).parent
_W = np.load(_DIR.parent / 'vc_module' / 'layout_runtime' / 'fe_mel_matrix.npy')  # 512x80
_WIN = np.load(_DIR.parent / 'vc_module' / 'layout_runtime' / 'fe_tables.npz')['fe_window_400']

SCALE = 1/1024.0
EPS = 0.01
FLOOR = 0.0  # 可调: 拟合原厂FFT噪声底

class FeatureExtract:
    def __init__(self, sr=16000):
        self.sr = sr
        self.buf = np.zeros(0, dtype=np.int16)

    def insert(self, pcm: np.ndarray, ch=1):
        self.buf = np.concatenate([self.buf, pcm])

    def size(self):
        n = (len(self.buf) - 400) // 256 + 1 if len(self.buf) >= 400 else 0
        return max(0, n)

    def _frame_mel(self, start):
        seg = self.buf[start:start+400].astype(np.float64)
        seg = seg - seg.mean()
        y = np.zeros(400)
        y[1:] = seg[1:] - 0.97*seg[:-1]
        yw = y * _WIN
        X = np.fft.rfft(yw, 512)
        P = (np.abs(X)**2 + FLOOR) * SCALE
        return np.log(_W[:257].T @ P + EPS)

    def fetch(self):
        """返回 [19,80]: 3上下文帧 + 16新帧 (与原厂一致)"""
        n = min(self.size(), 16)
        frames = []
        start = 256 * (self.size() - 16) if self.size() > 16 else 0
        for k in range(n):
            frames.append(self._frame_mel(start + 256*k))
        self.buf = self.buf[start + 256*n:]
        while len(frames) < 16:
            frames.insert(0, frames[0] if frames else np.zeros(80))
        ctx = [frames[0]]*3   # 简化: 上下文帧
        return np.array(ctx + frames)

if __name__ == '__main__':
    gt = np.load(r'D:\AA junior\ai change voice codex\vc_module\layout_runtime\gt_multi\gt_femel_00.npy').reshape(19,80)
    i = np.arange(8192)
    x = (np.sin(2*np.pi*440*i/16000)*12000).astype(np.int16)
    fe = FeatureExtract()
    fe.insert(x[:4096])
    m = fe.fetch()
    print('shape:', m.shape)
    print('gt帧0 rmse:', float(np.sqrt(((m[3]-gt[0])**2).mean())))

