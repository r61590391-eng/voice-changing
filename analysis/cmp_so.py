import zipfile, io, capstone
from elftools.elf.elffile import ELFFile

def load(zpath=None, path=None):
    if zpath:
        data = zipfile.ZipFile(path).read(zpath)
        f = io.BytesIO(data)
    else:
        f = open(path, "rb")
    e = ELFFile(f)
    ds = e.get_section_by_name(".symtab")
    if ds is None:
        ds = e.get_section_by_name(".dynsym")
    syms = {}
    for s in ds.iter_symbols():
        if s.name and s["st_value"]:
            syms[s.name] = (int(s["st_value"]), int(s["st_size"]))
    return e, syms

e1, s1 = load(zpath="lib/arm64-v8a/libvc_probe.so", path=r"D:\vc_harness\harness.base.apk")
e2, s2 = load(path=r"D:\vc_harness\libs\arm64-v8a\libvc_probe.so")
for name in sorted(set(list(s1)+list(s2))):
    if "W_" in name or "runVocMulti" in name:
        a = s1.get(name); b = s2.get(name)
        print(f"{name:40s} orig={hex(a[0]) if a else '-'}:{a[1] if a else '-'} mine={hex(b[0]) if b else '-'}:{b[1] if b else '-'}")
