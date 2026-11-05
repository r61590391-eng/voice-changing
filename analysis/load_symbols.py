"""Resolve PLT stubs -> symbol names via .rela.plt."""
import capstone
from elftools.elf.elffile import ELFFile
from elftools.elf.relocation import RelocationSection
from pathlib import Path

SO = Path(r"D:\AA junior\ai change voice codex\vc_module\libs\arm64-v8a\libdubbing_sdk_android.so")
md = capstone.Cs(capstone.CS_ARCH_ARM64, capstone.CS_MODE_LITTLE_ENDIAN)

def _imm(s):
    s = s.strip().lstrip("#")
    return int(s, 0)

def build():
    with open(SO, "rb") as f:
        elf = ELFFile(f)
        gotmap = {}
        for sec in elf.iter_sections():
            if isinstance(sec, RelocationSection):
                symtab = elf.get_section(sec["sh_link"])
                for r in sec.iter_relocations():
                    si = r["r_info_sym"]
                    if si:
                        gotmap[int(r["r_offset"])] = symtab.get_symbol(si).name
        syms = {}
        for sec in elf.iter_sections():
            if sec.header["sh_type"] in ("SHT_DYNSYM", "SHT_SYMTAB"):
                for s in sec.iter_symbols():
                    if s["st_value"] and s.name:
                        syms.setdefault(int(s["st_value"]), s.name)
        plt = elf.get_section_by_name(".plt")
        data, base = plt.data(), plt["sh_addr"]
        entries = {}
        for off in range(0, len(data) - 16, 16):
            chunk = data[off:off+16]
            page = None
            for ins in md.disasm(chunk, base + off):
                if ins.mnemonic == "adrp":
                    page = _imm(ins.op_str.split(", ")[1]) & ~0xfff
                elif ins.mnemonic == "ldr" and page is not None and "#" in ins.op_str:
                    off2 = _imm(ins.op_str.split("#")[1].rstrip("]"))
                    slot = page + off2
                    if slot in gotmap:
                        entries[base + off] = gotmap[slot]
                    break
        return {"syms": syms, "plt": entries, "gotmap": gotmap}

_CACHE = None
def resolve(addr):
    global _CACHE
    if _CACHE is None: _CACHE = build()
    return _CACHE["plt"].get(addr) or _CACHE["syms"].get(addr)

if __name__ == "__main__":
    m = build()
    for a in (0x49d20, 0x4a0c0, 0x4a0d0, 0x4a0e0, 0x496c0, 0x496d0):
        print(hex(a), resolve(a))
