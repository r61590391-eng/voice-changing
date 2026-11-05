"""自洽重拟合: 用修好的流式引擎产生up1/up2, 重拟合DC2/DC3"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
import final_engine as FE
from vmrlib import raw as rawR
from vm2lib import raw as rawQ
W=Path(r"D:\AA junior\ai change voice codex\vc_standalone\weights")
def leaky(x): return np.where(x<0,0.2*x,x)
def unleaky(y): return np.where(y<0,y/0.2,y)
def dec(x,K,b,stride,n):
    out=np.zeros((len(x)*stride,K.shape[2]))
    for f in range(len(x)):
        for j in range(len(K)):
            t=f*stride+j
            if t<len(out): out[t]+=x[f]@K[j]
    return (out+b)[:n]
# 用当前引擎跑两个数据集, 收集自洽up1/up2
def collect(raw):
    eng=FE.VocoderEngine()
    aux_in=np.fromfile(r"D:\vc_harness\build_v3\real_voc_in2.bin",dtype="<f4").reshape(16,2).astype(np.float64)
    ups1={};ups2={}
    for it in range(24):
        mel=raw(it,0,0)[:1600].reshape(16,100).astype(np.float64)
        o=eng.fwd(mel,aux_in)
        ups1[it]=o["up1"]; ups2[it]=o["up2"]
    return ups1,ups2
u1r,u2r=collect(rawR)
u1q,u2q=collect(rawQ)
print("自洽up1/2收集完成")
# ---- DC2重拟合 (输入=自洽up1) ----
pairs=[]
for ups1,raw in ((u1r,rawR),(u1q,rawQ)):
    for it in range(24):
        x=leaky(ups1[it])
        aux2=raw(it,10,1).reshape(-1,128).astype(np.float64)
        d2t=unleaky(raw(it,11,0).reshape(-1,128).astype(np.float64))-aux2
        pairs.append((x,d2t,it))
def fit(pairs,k,stride,Cin,Cout,nmax=128):
    ncol=k*Cin+1
    Xs=[];Ys=[];IDs=[]
    for pi,(x,d,it) in enumerate(pairs):
        T=min(len(d),nmax)
        rows=np.zeros((T,ncol))
        for t in range(T):
            for j in range(k):
                tj=t-j
                if tj>=0 and tj%stride==0:
                    f=tj//stride
                    if f<len(x): rows[t,j*Cin:(j+1)*Cin]=x[f]
        rows[t,-1]=1.0
        ok=np.isfinite(d[:T]).all(axis=1)
        if it>0: ok[:k]=False
        Xs.append(rows[ok]);Ys.append(d[:T][ok]);IDs.append(np.full(ok.sum(),pi))
    X=np.vstack(Xs);Y=np.vstack(Ys);ID=np.concatenate(IDs)
    tr=np.isin(ID,list(range(0,len(pairs),2)))
    sol=np.linalg.solve(X[tr].T@X[tr]+1e-8*np.eye(ncol),X[tr].T@Y[tr])
    pred=X@sol
    ho=~tr
    return sol,(np.corrcoef(pred[tr].ravel(),Y[tr].ravel())[0,1],np.sqrt(((pred[tr]-Y[tr])**2).mean())),(np.corrcoef(pred[ho].ravel(),Y[ho].ravel())[0,1],np.sqrt(((pred[ho]-Y[ho])**2).mean()))
sol2,tr2,ho2=fit(pairs,10,5,256,128)
print(f"DC2自洽: train corr={tr2[0]:.7f} rmse={tr2[1]:.4f} | hold corr={ho2[0]:.7f} rmse={ho2[1]:.4f}")
K2=np.zeros((10,256,128))
for j in range(10): K2[j]=sol2[j*256:(j+1)*256]
np.savez(W/"dc2_selfc.npz",K=K2,b=sol2[-1])
# ---- DC3 (输入=引擎真值up2 — 自洽up2受DC2影响, 用unleaky重建) ----
pairs=[]
for raw in (rawR,rawQ):
    for it in range(24):
        u2t=unleaky(raw(it,11,0).reshape(-1,128).astype(np.float64))
        for L in (1,3,5,7): u2t=u2t+raw(it,11+L,1).reshape(-1,128).astype(np.float64)[:len(u2t)]
        x=leaky(u2t)
        aux3=raw(it,19,1).reshape(-1,64).astype(np.float64)
        d3t=unleaky(raw(it,20,0).reshape(-1,64).astype(np.float64))-aux3
        pairs.append((x,d3t,it))
sol3,tr3,ho3=fit(pairs,8,4,128,64,nmax=256)
print(f"DC3自洽: train corr={tr3[0]:.7f} rmse={tr3[1]:.4f} | hold corr={ho3[0]:.7f} rmse={ho3[1]:.4f}")
K3=np.zeros((8,128,64))
for j in range(8): K3[j]=sol3[j*128:(j+1)*128]
np.savez(W/"dc3_selfc.npz",K=K3,b=sol3[-1])
