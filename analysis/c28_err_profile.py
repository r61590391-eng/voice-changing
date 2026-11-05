"""it1: c28误差逐帧分布 + 逐级替换实验(我的中间量 vs 引擎真值, 看哪级修复c28)"""
import sys
import numpy as np
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
import final_engine as FE
from vmrlib import raw as rawR
def unleaky(y): return np.where(y<0,y/0.2,y)
def leaky(x): return np.where(x<0,0.2*x,x)

eng=FE.VocoderEngine()
aux_in=np.fromfile(r"D:\vc_harness\build_v3\real_voc_in2.bin",dtype="<f4").reshape(16,2).astype(np.float64)
o0=eng.fwd(rawR(0,0,0)[:1600].reshape(16,100).astype(np.float64),aux_in)
o1=eng.fwd(rawR(1,0,0)[:1600].reshape(16,100).astype(np.float64),aux_in)
gt=rawR(1,28,1)[:910*18].reshape(910,18).astype(np.float64)
r=o1["c28"][:256]-gt[:256]
pf=np.sqrt((r**2).mean(axis=1))
print("it1 c28 逐帧rmse (f0-19):", np.round(pf[:20],1))
print("it1 c28 逐帧rmse (f120-139):", np.round(pf[120:140],1))
print("it1 c28 逐帧rmse (f240-259):", np.round(pf[240:260],1))

# 替换实验: 用引擎真值驱动各级
import voc as V
mel=rawR(1,0,0)[:1600].reshape(16,100).astype(np.float64)
exc=rawR(1,1,0).reshape(-1).astype(np.float64)
c00h=rawR(1,0,1)[:8192].reshape(16,512).astype(np.float64)
c01h=rawR(1,1,1)[:12288].reshape(48,256).astype(np.float64)
c10h=rawR(1,10,1).reshape(-1,128).astype(np.float64)
c19h=rawR(1,19,1).reshape(-1,64).astype(np.float64)
# 引擎的up1真值 = unleaky(rb0a)+posts
up1h=unleaky(rawR(1,2,0)[:12288].reshape(48,256).astype(np.float64))
for L in (1,3,5,7): up1h=up1h+rawR(1,2+L,1)[:12288].reshape(48,256).astype(np.float64)
up2h=unleaky(rawR(1,11,0).reshape(-1,128).astype(np.float64))
for L in (1,3,5,7): up2h=up2h+rawR(1,11+L,1).reshape(-1,128).astype(np.float64)[:len(up2h)]
up3h=unleaky(rawR(1,20,0).reshape(-1,64).astype(np.float64))
for L in (1,3,5,7): up3h=up3h+rawR(1,20+L,1).reshape(-1,64).astype(np.float64)[:len(up3h)]

def c28corr(y):
    h=V.c28(y) if False else None
    w28=V.Z["up2.rb11.c28.w"].reshape(18,7,64)[:,::-1,:].transpose(0,2,1).astype(np.float64)
    c=V.causal_conv(leaky(y),w28,V.Z["up2.rb11.c28.b"].astype(np.float64))
    return np.corrcoef(c[40:256].ravel(),gt[40:256].ravel())[0,1]

print()
print("A 全链(我):", c28corr(o1["up3"]))
print("B up3=引擎真值, c28直接卷:", np.corrcoef(V.causal_conv(leaky(up3h), V.Z['up2.rb11.c28.w'].reshape(18,7,64)[:,::-1,:].transpose(0,2,1).astype(np.float64), V.Z['up2.rb11.c28.b'].astype(np.float64))[40:256].ravel(), gt[40:256].ravel())[0,1])
# C: 我的up2 + 引擎流跑up3
o2=eng.up3.fwd(o1["up2"], c19h)
print("C 我的up2->up3:", c28corr(o2))
# D: 引擎up2 -> 我的up3
o3=eng.up3.fwd(up2h, c19h)
print("D 引擎up2->我的up3:", c28corr(o3))
# E: 我的up1 -> up2/up3
o4=eng.up2.fwd(o1["up1"], c10h); o5=eng.up3.fwd(o4, c19h)
print("E 我的up1->up2/3:", c28corr(o5))
# F: 引擎up1 -> up2/3
o6=eng.up2.fwd(up1h, c10h); o7=eng.up3.fwd(o6, c19h)
print("F 引擎up1->up2/3:", c28corr(o7))
# G: 引擎c00 -> 全链
o8=eng.up1.fwd(c00h, c01h); o9=eng.up2.fwd(o8,c10h); o10=eng.up3.fwd(o9,c19h)
print("G 引擎c00->全链:", c28corr(o10))
