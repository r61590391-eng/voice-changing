"""DC1 精修: 全帧段(带overlap校正)重拟合, 两轮迭代"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
from vmrlib import raw as rawR
from vm2lib import raw as rawQ
W=Path(r"D:\AA junior\ai change voice codex\vc_standalone\weights")
def leaky(x): return np.where(x<0,0.2*x,x)
def unleaky(y): return np.where(y<0,y/0.2,y)
def dec(x,K,b,stride=3):
    out=np.zeros((len(x)*stride,256))
    for f in range(len(x)):
        for j in range(len(K)):
            t=f*stride+j
            if t<len(out): out[t]+=x[f]@K[j]
    return out+b
K=np.load(W/"dc1_final.npz")["K"]; b=np.load(W/"dc1_final.npz")["b"].copy()
def getds(raw):
    return {it: dict(c00=raw(it,0,1)[:8192].reshape(16,512).astype(np.float64),
                     c01=raw(it,1,1)[:12288].reshape(48,256).astype(np.float64),
                     rb0a=raw(it,2,0)[:12288].reshape(48,256).astype(np.float64)) for it in range(24)}
DS=[getds(rawR),getds(rawQ)]
for rnd in range(2):
    Xs=[];Ys=[]
    for DSi in range(2):
        prev_x=None
        for it in range(24):
            D=DS[DSi][it]
            x=leaky(D["c00"])
            d=unleaky(D["rb0a"])-D["c01"]
            # overlap校正: 减去当前K的overlap贡献
            if prev_x is not None:
                for t,jj in ((0,3),(1,4),(2,5)):
                    d=d.copy(); d[t]-=prev_x[-1]@K[jj]
            T=48
            rows=np.zeros((T,6*512+1))
            for t in range(T):
                for j in range(6):
                    tj=t-j
                    if tj>=0 and tj%3==0:
                        f=tj//3
                        if f<len(x): rows[t,j*512:(j+1)*512]=x[f]
                rows[t,-1]=1.0
            ok=np.isfinite(d).all(axis=1)
            Xs.append(rows[ok]);Ys.append(d[ok])
            prev_x=x
    X=np.vstack(Xs);Y=np.vstack(Ys)
    sol=np.linalg.solve(X.T@X+1e-9*np.eye(X.shape[1]), X.T@Y)
    K=np.zeros((6,512,256))
    for j in range(6): K[j]=sol[j*512:(j+1)*512]
    b=sol[-1]
    pred=X@sol
    print(f"round{rnd}: rmse={np.sqrt(((pred-Y)**2).mean()):.6f}")
np.savez(W/"dc1_final2.npz",K=K,b=b)
# 验证: it0/it1 全帧
for it in (0,1):
    D=DS[0][it]
    x=leaky(D["c00"])
    m=dec(x,K,b)+D["c01"]
    t=unleaky(D["rb0a"])
    r=(m-t)
    print(f"it{it} u0全帧残差:", np.round(np.sqrt((r[:6]**2).mean(axis=1)),4), " f6+max:", np.abs(r[6:]).max())
