import sys, capstone
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
from elftools.elf.elffile import ELFFile
from load_symbols import resolve, build

m = build()
syms = m["syms"]
inv = {}
for a, n in syms.items():
    inv.setdefault(n, a)
name = sys.argv[1] if len(sys.argv) > 1 else "_ZN9UpSampler7forwardEP6TensorIfES2_"
addr = inv.get(name)
print(name, hex(addr) if addr else None)
if addr:
    with open(r"D:\AA junior\ai change voice codex\vc_module\libs\arm64-v8a\libdubbing_sdk_android.so","rb") as f:
        elf = ELFFile(f)
        text = elf.get_section_by_name(".text")
        base = text["sh_addr"]; data = text.data()
        off = addr - base
        md = capstone.Cs(capstone.CS_ARCH_ARM64, capstone.CS_MODE_LITTLE_ENDIAN)
        # take 4KB
        for ins in md.disasm(data[off:off+0x1400], addr):
            extra = ""
            if ins.mnemonic in ("bl","b") and "#0x" in ins.op_str:
                t = int(ins.op_str.split("#")[1],0)
                n = resolve(t)
                if n: extra = "    ; " + n
            print(f"{ins.address:#x}  {ins.mnemonic:10s} {ins.op_str}{extra}")
