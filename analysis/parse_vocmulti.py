"""parse vocmulti2.txt -> index of per-iter per-call tensors"""
import struct
import numpy as np
from pathlib import Path

SRC = Path(r"D:\AA junior\ai change voice codex\vc_module\layout_runtime\vocmulti2.txt")
OUT = Path(r"D:\AA junior\ai change voice codex\vc_standalone\tests\vm2_cache")
OUT.mkdir(exist_ok=True, parents=True)

data = SRC.read_bytes()
pos = 0; recs = []
n = len(data)
while pos < n:
    b = data.find(b"\x01M", pos)
    if b < 0: break
    if b + 20 > n: break
    it, call, phase, cnt = struct.unpack_from("<iiii", data, b + 2)
    if not (0 <= it < 24 and 0 <= call < 4096 and phase in (0, 1) and 0 < cnt <= 16384):
        pos = b + 1; continue
    off = b + 18
    if off + cnt * 4 > n:
        pos = b + 1; continue
    recs.append((it, call, phase, cnt, off))
    pos = off + cnt * 4

print("records:", len(recs))
calls = {}
for it, call, phase, cnt, off in recs:
    calls.setdefault((it, call), {})[phase] = (cnt, off)
print("call keys:", len(calls))
per_iter = {}
for (it, call), ph in calls.items():
    per_iter.setdefault(it, []).append(call)
for it in sorted(per_iter):
    cs = sorted(per_iter[it])
    print("iter", it, "ncalls", len(cs), "first", cs[0], "last", cs[-1])
inv = {}
for (it, call), ph in sorted(calls.items()):
    cnt = ph.get(0, (None, None))[0]
    inv.setdefault(call % 66, []).append(cnt)
for call in sorted(inv):
    ns = sorted(set(inv[call]))
    print(f"callmod {call:02d}: n values {ns[:4]}{'...' if len(ns)>4 else ''} count={len(inv[call])}")
np.save(OUT / "_index.npy", np.array(recs, dtype=np.int64))
