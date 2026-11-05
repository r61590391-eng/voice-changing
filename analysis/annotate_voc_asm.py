import re, sys
sys.path.insert(0, r"D:\AA junior\ai change voice codex\vc_standalone")
from load_symbols import resolve
src = open(r"D:\AA junior\ai change voice codex\vc_module\layout_runtime\voc_forward.asm", encoding="utf-8").read()
out = []
for line in src.splitlines():
    m = re.search(r"bl\s+#(0x[0-9a-f]+)", line)
    if m:
        a = int(m.group(1), 16)
        n = resolve(a)
        if n:
            # demangle lightly
            d = n
            for pat, rep in [("_ZN6Conv1d7forwardEP6TensorIfEi","Conv1d::forward"),
                             ("_ZN8DeConv1d7forwardEP6TensorIfE","DeConv1d::forward"),
                             ("_ZN9UpSampler7forwardEP6TensorIfES2_","UpSampler::forward"),
                             ("_ZN9vocengine7forwardERP6TensorIfES3_Ps","vocengine::forward"),
                             ("_Z7sinegenP6TensorIfES1_S1_","sinegen"),
                             ("_ZN6TensorIfE8upsampleEPS0_i","Tensor::upsample"),
                             ("_ZN6TensorIfE5melsEP6TensorIfES2_","Tensor::mels")]:
                d = d.replace(pat, rep)
            line = line + "    ; " + d
    out.append(line)
open(r"D:\AA junior\ai change voice codex\vc_standalone\voc_forward_annotated.asm","w",encoding="utf-8").write("\n".join(out))
print("\n".join(out))
