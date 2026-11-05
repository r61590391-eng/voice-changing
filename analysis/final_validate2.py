"""最终引擎连续流式验证 (正确跳帧: it>0 跳过各层overlap窗口)"""
import sys
import numpy as np
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
from final_engine import VocoderEngine
from vmrlib import raw as rawR
def stats(a,b,skip=0):
    a=np.asarray(a,float)[skip:].ravel(); b=np.asarray(b,float)[skip:].ravel()
    m=np.isfinite(a)&np.isfinite(b)
    if m.sum()<10: return "EMPTY"
    return f"corr={np.corrcoef(a[m],b[m])[0,1]:.6f} rmse={np.sqrt(((a[m]-b[m])**2).mean()):.4f}"
def unleaky(y): return np.where(y<0,y/0.2,y)
eng = VocoderEngine()
print("=== 最终引擎连续流式验证 (24 chunks 真实语音) ===\n")
for it in range(24):
    mel = rawR(it,0,0)[:1600].reshape(16,100).astype(np.float64)
    aux_in = np.fromfile(r"D:\vc_harness\build_v3\real_voc_in2.bin", dtype="<f4").reshape(16,2).astype(np.float64)
    o = eng.fwd(mel, aux_in)
    skip2 = 0 if it==0 else 12   # DC2 overlap窗口
    skip3 = 0 if it==0 else 10
    rb0a = rawR(it,2,0)[:12288].reshape(48,256)
    pre4 = rawR(it,11,0).reshape(-1,128).astype(np.float64)
    up2t = unleaky(pre4)
    for L in (1,3,5,7): up2t = up2t + rawR(it,11+L,1).reshape(-1,128).astype(np.float64)[:len(up2t)]
    pre8 = rawR(it,20,0).reshape(-1,64).astype(np.float64)
    up3t = unleaky(pre8)
    for L in (1,3,5,7): up3t = up3t + rawR(it,20+L,1).reshape(-1,64).astype(np.float64)[:len(up3t)]
    c28gt = rawR(it,28,1)[:910*18].reshape(910,18)
    # up1比较: 跳RB最深感受野累积窗口 (54) for it>0
    up1t = unleaky(rb0a)
    for L in (1,3,5,7): up1t = up1t + rawR(it,2+L,1)[:12288].reshape(48,256).astype(np.float64)
    sk1 = 0 if it==0 else 54
    line = f"it{it:02d}: c00={stats(o['c00'], rawR(it,0,1)[:8192].reshape(16,512),6)[:34]}"
    line += f" up1={stats(o['up1'], up1t, sk1)[:34]}"
    line += f" up2={stats(o['up2'][:128], up2t[:128], skip2)[:34]}"
    line += f" up3={stats(o['up3'][:256], up3t[:256], skip3)[:34]}"
    if np.isfinite(c28gt[:256]).all():
        line += f" c28={stats(o['c28'][:256], c28gt[:256], 40 if it else 8)[:34]}"
    print(line)
