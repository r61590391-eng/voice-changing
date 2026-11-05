"""误差定位实验: 两种模式沿链路测 corr/rmse
A) 每级独立驱动 (hook输入->我的核->vs hook输出): 隔离各层核误差, 无累积
B) 全链传播 (hook首级输入->我的全链->vs每级hook输出): 误差累积曲线
数据: vocmulti2 iter1 (全部29个call有hook)
"""
import sys
import numpy as np
from pathlib import Path
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone\models")
from vm2lib import raw
import voc

def stats(mine, gt, skip):
    a = np.asarray(mine, float)[skip:].ravel(); b = np.asarray(gt, float)[skip:].ravel()
    m = np.isfinite(a) & np.isfinite(b)
    return dict(corr=float(np.corrcoef(a[m], b[m])[0,1]),
                rmse=float(np.sqrt(((a[m]-b[m])**2).mean())),
                rel=float(np.sqrt(((a[m]-b[m])**2).mean())/np.abs(b[m]).mean()))

it = 1
# ---- hook 真值 ----
mel_gt   = raw(it,0,0).reshape(16,100).astype(np.float64)
c00_gt   = raw(it,0,1).reshape(16,512).astype(np.float64)
exc_gt   = raw(it,1,0).reshape(-1).astype(np.float64)
c01_gt   = raw(it,1,1).reshape(48,256).astype(np.float64)
c10_gt   = raw(it,10,1).reshape(-1,128).astype(np.float64)   # 128/240 dumped
c19_gt   = raw(it,19,1).reshape(-1,64).astype(np.float64)    # 256/960
rb4a_pre = raw(it,11,0).reshape(-1,128).astype(np.float64)
rb7b_post= raw(it,18,1).reshape(-1,128).astype(np.float64)
rb8a_pre = raw(it,20,0).reshape(-1,64).astype(np.float64)
rb11b_post=raw(it,27,1).reshape(-1,64).astype(np.float64)
c28_pre  = raw(it,28,0).reshape(-1,64).astype(np.float64)
c28_post = raw(it,28,1)[:910*18].reshape(910,18).astype(np.float64)

def unleaky(y): return np.where(y<0, y/0.2, y)

print("=" * 78)
print("A) 每级独立驱动 (隔离核误差)          [跳过边界帧=该层感受野]")
print("=" * 78)
rows = []
# c00 (k7, 需6帧历史 -> 跳6)
m = voc.c00(mel_gt); rows.append(("c00", stats(m, c00_gt, 6)))
m = voc.c01(exc_gt); rows.append(("c01", stats(m, c01_gt, 4)))
m = voc.c10(exc_gt); rows.append(("c10", stats(m[:128], c10_gt, 4)))
m = voc.c19(exc_gt); rows.append(("c19", stats(m[:256], c19_gt, 4)))
# DeConv2: 输入 = leaky(up1_exact); 输出 = unleaky(rb4a_pre)-c10_gt
up1_exact = voc.deconv_transpose(voc.leaky(c00_gt), voc.DC1["K"], voc.DC1["b"], 3) + c01_gt
for L in (1,3,5,7):
    up1_exact = up1_exact + raw(it,2+L,1).reshape(48,256).astype(np.float64)
d2_true = unleaky(rb4a_pre) - c10_gt
d2_mine = voc.deconv_transpose(voc.leaky(up1_exact), voc.DC2["K"], voc.DC2["b"], 5)
rows.append(("DeConv2", stats(d2_mine[:128], d2_true[:128], 12)))
# Up2 RBs: 已验证1e-7 (略)
# DeConv3: 输入 = leaky(up2_exact); up2_exact = d2_true + posts
up2_exact = d2_true.copy()
for L in (1,3,5,7):
    up2_exact = up2_exact + raw(it,11+L,1).reshape(-1,128).astype(np.float64)[:len(up2_exact)]
d3_true = unleaky(rb8a_pre) - c19_gt
d3_mine = voc.deconv_transpose(voc.leaky(up2_exact[:128]), voc.DC3["K"], voc.DC3["b"], 4)
rows.append(("DeConv3", stats(d3_mine[:256], d3_true[:256], 12)))
# c28 (hook输入)
w28 = voc.Z["up2.rb11.c28.w"].reshape(18,7,64)[:,::-1,:].transpose(0,2,1).astype(np.float64)
c28m = voc.causal_conv(c28_pre, w28, voc.Z["up2.rb11.c28.b"].astype(np.float64))
rows.append(("c28", stats(c28m[:256], c28_post[:256], 8)))
# iSTFT: 无hook (公式) -> 用 c28_post 直接变换后与 mine 的 spec 比较
sp_gt = voc.istft_polar(c28_post)
sp_m  = voc.istft_polar(c28m)
rows.append(("iSTFT(由c28传播)", stats(sp_m[:256], sp_gt[:256], 8)))
for name, s in rows:
    print(f"  {name:16s} corr={s['corr']:.6f}  rmse={s['rmse']:.5f}  rel={s['rel']*100:.2f}%")

print()
print("=" * 78)
print("B) 全链传播 (我的链 vs hook, 逐级)      [输入=hook mel+hook exc]")
print("=" * 78)
out = {}
h00 = voc.c00(mel_gt)
out["c00"] = stats(h00, c00_gt, 6)
h01 = voc.c01(exc_gt)
out["c01"] = stats(h01, c01_gt, 4)
h10 = voc.c10(exc_gt)
h19 = voc.c19(exc_gt)
up1 = voc.upsampler(h00, h01, 1)
# up1 输出无直接hook; 用 rb4a_pre 逆推 d2 对比
pred_rb4a = voc.leaky(voc.deconv_transpose(voc.leaky(up1), voc.DC2["K"], voc.DC2["b"], 5) + h10)
out["rb4a入口(Up1+DC2)"] = stats(pred_rb4a[:128], rb4a_pre[:128], 16)
up2 = voc.upsampler(up1, h10, 2)
pred_rb8a = voc.leaky(voc.deconv_transpose(voc.leaky(up2), voc.DC3["K"], voc.DC3["b"], 4) + h19)
out["rb8a入口(Up2+DC3)"] = stats(pred_rb8a[:256], rb8a_pre[:256], 24)
up3 = voc.upsampler(up2, h19, 3)
pred_c28i = voc.leaky(up3)
out["c28入口(Up3)"] = stats(pred_c28i[:256], c28_pre[:256], 60)
h28 = voc.c28(up3)
out["c28出"] = stats(h28[:256], c28_post[:256], 60)
for name, s in out.items():
    print(f"  {name:18s} corr={s['corr']:.6f}  rmse={s['rmse']:.5f}  rel={s['rel']*100:.2f}%")
