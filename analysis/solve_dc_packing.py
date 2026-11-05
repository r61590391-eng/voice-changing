import numpy as np
from pathlib import Path
W = Path(r"D:\AA junior\ai change voice codex\vc_standalone\weights")
A = np.load(W/"dc_kernel_ls.npz")["K"].ravel()   # exact 786432
T = np.load(W/"voc_tensors.npz")
F = T["up00.w"].astype(np.float64)
# take distinctive values of A (largest abs) and locate exact matches in F
idx = np.argsort(-np.abs(A))[:200]
avals = A[idx]
# exact float32 equality search
F32 = T["up00.w"]
hits = 0; pairs = []
for i, v in zip(idx, avals):
    m = np.where(F32 == np.float32(v))[0]
    if len(m):
        hits += 1
        if len(pairs) < 12: pairs.append((int(i), int(m[0]), float(v)))
print("exact hits:", hits, "/200")
for p in pairs: print(p)
# distribution comparison
print("A absmean", np.abs(A).mean(), "F absmean", np.abs(F).mean())
print("A std", A.std(), "F std", F.std())
