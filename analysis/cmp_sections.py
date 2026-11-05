import zipfile, io
from elftools.elf.elffile import ELFFile
def secs(path=None, zpath=None):
    if zpath: f = io.BytesIO(zipfile.ZipFile(path).read(zpath))
    else: f = open(path, "rb")
    e = ELFFile(f)
    out = {}
    for s in e.iter_sections():
        out[s.name] = (s.header["sh_addr"], s.header["sh_size"], s.header["sh_type"])
    return out
o = secs(zpath="lib/arm64-v8a/libvc_probe.so", path=r"D:\vc_harness\harness.base.apk")
m = secs(path=r"D:\vc_harness\libs\arm64-v8a\libvc_probe.so")
allk = sorted(set(o) | set(m))
for k in allk:
    a = o.get(k); b = m.get(k)
    mark = "" if a == b else "   <-- DIFF"
    print(f"{k:20s} orig={a} mine={b}{mark}")
