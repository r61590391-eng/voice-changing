_ZN8ResBlock7forwardEP6TensorIfE 0x28670
0x28670  stp        x30, x21, [sp, #-0x20]!
0x28674  stp        x20, x19, [sp, #0x10]
0x28678  ldr        x21, [x0, #0x30]
0x2867c  mov        x19, x1
0x28680  ldr        w8, [x19, #0x20]
0x28684  mov        x20, x0
0x28688  ldr        w1, [x21]
0x2868c  cmp        w1, w8
0x28690  b.ge       #0x286a8
0x28694  ldr        w2, [x21, #0x20]
0x28698  adrp       x0, #0xf000
0x2869c  add        x0, x0, #0x22f
0x286a0  bl         #0x496c0    ; printf
0x286a4  ldr        w8, [x19, #0x20]
0x286a8  ldr        x0, [x21, #8]
0x286ac  ldr        x1, [x19, #8]
0x286b0  sbfiz      x2, x8, #2, #0x20
0x286b4  bl         #0x496d0    ; memcpy
0x286b8  ldp        w8, w9, [x19, #0x10]
0x286bc  ldp        w10, w11, [x19, #0x18]
0x286c0  ldr        w1, [x21]
0x286c4  stp        w8, w9, [x21, #0x10]
0x286c8  mul        w8, w9, w8
0x286cc  mul        w8, w8, w10
0x286d0  mul        w2, w8, w11
0x286d4  cmp        w1, w2
0x286d8  stp        w10, w11, [x21, #0x18]
0x286dc  str        w2, [x21, #0x20]
0x286e0  b.ge       #0x286f0
0x286e4  adrp       x0, #0xe000
0x286e8  add        x0, x0, #0xed3
0x286ec  bl         #0x496c0    ; printf
0x286f0  ldr        x8, [x20, #0x30]
0x286f4  ldp        w9, w10, [x19, #0x10]
0x286f8  ldp        w11, w12, [x19, #0x18]
0x286fc  ldr        w1, [x8]
0x28700  stp        w9, w10, [x8, #0x10]
0x28704  mul        w9, w10, w9
0x28708  mul        w9, w9, w11
0x2870c  mul        w2, w9, w12
0x28710  cmp        w1, w2
0x28714  stp        w11, w12, [x8, #0x18]
0x28718  str        w2, [x8, #0x20]
0x2871c  b.ge       #0x2872c
0x28720  adrp       x0, #0xe000
0x28724  add        x0, x0, #0xed3
0x28728  bl         #0x496c0    ; printf
0x2872c  ldr        w9, [x19, #0x20]
0x28730  cmp        w9, #1
0x28734  b.lt       #0x28778
0x28738  mov        w10, #0xcccd
0x2873c  mov        x8, xzr
0x28740  movk       w10, #0x3e4c, lsl #16
0x28744  b          #0x28754
0x28748  add        x8, x8, #1
0x2874c  cmp        x8, w9, sxtw
0x28750  b.ge       #0x28778
0x28754  ldr        x11, [x19, #8]
0x28758  ldr        s0, [x11, x8, lsl #2]
0x2875c  fcmp       s0, #0.0
0x28760  b.pl       #0x28748
0x28764  fmov       s1, w10
0x28768  fmul       s0, s0, s1
0x2876c  str        s0, [x11, x8, lsl #2]
0x28770  ldr        w9, [x19, #0x20]
0x28774  b          #0x28748
0x28778  ldr        x0, [x20, #0x20]
0x2877c  mov        w2, #1
0x28780  mov        x1, x19
0x28784  bl         #0x49d20    ; _ZN6Conv1d7forwardEP6TensorIfEi
0x28788  ldr        w9, [x19, #0x20]
0x2878c  cmp        w9, #1
0x28790  b.lt       #0x287d4
0x28794  mov        w10, #0xcccd
0x28798  mov        x8, xzr
0x2879c  movk       w10, #0x3e4c, lsl #16
0x287a0  b          #0x287b0
0x287a4  add        x8, x8, #1
0x287a8  cmp        x8, w9, sxtw
0x287ac  b.ge       #0x287d4
0x287b0  ldr        x11, [x19, #8]
0x287b4  ldr        s0, [x11, x8, lsl #2]
0x287b8  fcmp       s0, #0.0
0x287bc  b.pl       #0x287a4
0x287c0  fmov       s1, w10
0x287c4  fmul       s0, s0, s1
0x287c8  str        s0, [x11, x8, lsl #2]
0x287cc  ldr        w9, [x19, #0x20]
0x287d0  b          #0x287a4
0x287d4  ldr        x0, [x20, #0x28]
0x287d8  mov        w2, #1
0x287dc  mov        x1, x19
0x287e0  bl         #0x49d20    ; _ZN6Conv1d7forwardEP6TensorIfEi
0x287e4  ldr        w8, [x19, #0x20]
0x287e8  cmp        w8, #1
0x287ec  b.lt       #0x28824
0x287f0  ldr        x8, [x20, #0x30]
0x287f4  mov        x9, xzr
0x287f8  ldr        x10, [x19, #8]
0x287fc  ldr        x11, [x8, #8]
0x28800  lsl        x12, x9, #2
0x28804  add        x9, x9, #1
0x28808  ldr        s0, [x10, x12]
0x2880c  ldr        s1, [x11, x12]
0x28810  fadd       s0, s0, s1
0x28814  str        s0, [x10, x12]
0x28818  ldrsw      x10, [x19, #0x20]
0x2881c  cmp        x9, x10
0x28820  b.lt       #0x287f8
0x28824  ldp        x20, x19, [sp, #0x10]
0x28828  ldp        x30, x21, [sp], #0x20
0x2882c  ret        
0x28830  str        wzr, [x0, #0x320]
0x28834  ret        
0x28838  ret        
0x2883c  str        wzr, [x0, #0x320]
0x28840  ret        
0x28844  ldr        w8, [x0, #0x320]
0x28848  str        x1, [x0, #0x328]
0x2884c  str        w2, [x0, #0x330]
0x28850  add        w8, w8, w2
0x28854  str        w8, [x0, #0x334]
0x28858  ret        
0x2885c  ldr        w0, [x0, #0x334]
0x28860  ret        
0x28864  ldr        w8, [x0, #0x320]
0x28868  ldr        w9, [x0, #0x334]
0x2886c  ldr        x10, [x0, #0x328]
0x28870  sub        w8, w1, w8
0x28874  sub        w9, w9, w1
0x28878  add        x1, x10, w8, sxtw #1
0x2887c  sbfiz      x2, x9, #1, #0x20
0x28880  str        w9, [x0, #0x320]
0x28884  b          #0x496d0    ; memcpy
0x28888  ldr        w8, [x0, #0x320]
0x2888c  cmp        w8, w1
0x28890  b.le       #0x2889c
0x28894  add        x0, x0, w1, sxtw #1
0x28898  ret        
0x2889c  ldr        x9, [x0, #0x328]
0x288a0  sub        w8, w1, w8
0x288a4  add        x0, x9, w8, sxtw #1
0x288a8  ret        
0x288ac  stp        x30, x21, [sp, #-0x20]!
0x288b0  stp        x20, x19, [sp, #0x10]
0x288b4  mov        x20, x0
0x288b8  str        x1, [x0, #8]
0x288bc  str        s0, [x0, #0x18]
0x288c0  str        w2, [x0]
0x288c4  mov        w0, #0x28
0x288c8  mov        w19, w2
0x288cc  bl         #0x49500    ; _Znwm
0x288d0  lsl        w8, w19, #1
0x288d4  movi       v0.2s, #1
0x288d8  mov        w9, #1
0x288dc  mov        x21, x0
0x288e0  str        d0, [x0, #0x10]
0x288e4  stp        w9, w8, [x0, #0x18]
0x288e8  str        w8, [x0, #0x20]
0x288ec  str        w8, [x0]
0x288f0  sbfiz      x1, x8, #2, #0x20
0x288f4  mov        w0, #0x40
0x288f8  bl         #0x49560    ; _Z14aligned_mallocmm
0x288fc  str        x0, [x21, #8]
0x28900  ldr        w8, [x20]
0x28904  mov        w1, #0x20
0x28908  str        x21, [x20, #0x10]
0x2890c  str        wzr, [x20, #4]
0x28910  mul        w8, w8, w8
0x28914  lsl        w0, w8, #1
0x28918  bl         #0x497c0    ; _Z9alignsizeii
0x2891c  ldp        w9, w8, [x20]
0x28920  mov        w1, #0x20
0x28924  add        w8, w8, w0
0x28928  lsl        w0, w9, #1
0x2892c  str        w8, [x20, #4]
0x28930  bl         #0x497c0    ; _Z9alignsizeii
0x28934  ldr        w8, [x20, #4]
0x28938  add        w8, w8, w0
0x2893c  str        w8, [x20, #4]
0x28940  ldp        x20, x19, [sp, #0x10]
0x28944  ldp        x30, x21, [sp], #0x20
0x28948  ret        
0x2894c  sub        sp, sp, #0x40
0x28950  str        x30, [sp, #0x10]
0x28954  stp        x22, x21, [sp, #0x20]
0x28958  stp        x20, x19, [sp, #0x30]
0x2895c  mov        x21, x0
0x28960  str        s0, [x0, #0x18]
0x28964  str        w2, [x0]
0x28968  mov        w0, #0x28
0x2896c  mov        w19, w2
0x28970  mov        x20, x1
0x28974  bl         #0x49500    ; _Znwm
0x28978  lsl        w8, w19, #1
0x2897c  movi       v0.2s, #1
0x28980  mov        w9, #1
0x28984  mov        x22, x0
0x28988  str        d0, [x0, #0x10]
0x2898c  stp        w9, w8, [x0, #0x18]
0x28990  str        w8, [x0, #0x20]
0x28994  str        w8, [x0]
0x28998  sbfiz      x1, x8, #2, #0x20
0x2899c  mov        w0, #0x40
0x289a0  bl         #0x49560    ; _Z14aligned_mallocmm
0x289a4  str        x0, [x22, #8]
0x289a8  mov        x19, x21
0x289ac  mov        w0, #0x18
0x289b0  str        x22, [x21, #0x10]
0x289b4  str        wzr, [x19, #4]!
0x289b8  bl         #0x49500    ; _Znwm
0x289bc  ldr        w8, [x21]
0x289c0  mov        x1, x0
0x289c4  str        x0, [x21, #8]
0x289c8  add        x2, x0, #8
0x289cc  add        x3, x0, #0x10
0x289d0  add        x4, x0, #0x14
0x289d4  add        x5, x0, #0x15
0x289d8  lsl        w7, w8, #1
0x289dc  mov        x0, x20
0x289e0  mov        x6, x19
0x289e4  str        w8, [sp]
0x289e8  bl         #0x49830    ; _Z12GerzzPreWsBsPvPPhPPfS2_S0_PbPiii
0x289ec  ldp        x20, x19, [sp, #0x30]
0x289f0  ldp        x22, x21, [sp, #0x20]
0x289f4  ldr        x30, [sp, #0x10]
0x289f8  add        sp, sp, #0x40
0x289fc  ret        
0x28a00  ldr        w0, [x0, #4]
0x28a04  ret        
0x28a08  str        x30, [sp, #-0x20]!
0x28a0c  stp        x20, x19, [sp, #0x10]
0x28a10  ldr        x20, [x0, #0x10]
0x28a14  mov        x19, x0
0x28a18  cbz        x20, #0x28a34
0x28a1c  ldr        x0, [x20, #8]
0x28a20  cbz        x0, #0x28a2c
0x28a24  bl         #0x49630    ; _Z12aligned_freePv
0x28a28  str        xzr, [x20, #8]
0x28a2c  mov        x0, x20
0x28a30  bl         #0x49600    ; _ZdlPv
0x28a34  ldr        x0, [x19, #8]
0x28a38  cbz        x0, #0x28a48
0x28a3c  ldp        x20, x19, [sp, #0x10]
0x28a40  ldr        x30, [sp], #0x20
0x28a44  b          #0x49600    ; _ZdlPv
0x28a48  ldp        x20, x19, [sp, #0x10]
0x28a4c  ldr        x30, [sp], #0x20
0x28a50  ret        
0x28a54  str        wzr, [x2]
0x28a58  ldr        w8, [x0]
0x28a5c  fmov       s0, wzr
0x28a60  cmp        w8, #1
0x28a64  b.lt       #0x28a90
0x28a68  mov        x9, xzr
0x28a6c  fmov       s1, wzr
0x28a70  ldr        s2, [x1, x9, lsl #2]
0x28a74  add        x9, x9, #1
0x28a78  fadd       s1, s2, s1
0x28a7c  str        s1, [x2]
0x28a80  ldrsw      x8, [x0]
0x28a84  cmp        x9, x8
0x28a88  b.lt       #0x28a70
0x28a8c  b          #0x28a94
0x28a90  fmov       s1, wzr
0x28a94  scvtf      s2, w8
0x28a98  fdiv       s1, s1, s2
0x28a9c  str        s1, [x2]
0x28aa0  str        wzr, [x3]
0x28aa4  ldr        w9, [x0]
0x28aa8  cmp        w9, #1
0x28aac  b.lt       #0x28ae0
0x28ab0  mov        x8, xzr
0x28ab4  fmov       s0, wzr
0x28ab8  ldr        s1, [x1, x8, lsl #2]
0x28abc  ldr        s2, [x2]
0x28ac0  add        x8, x8, #1
0x28ac4  fsub       s1, s1, s2
0x28ac8  fmul       s1, s1, s1
0x28acc  fadd       s0, s0, s1
0x28ad0  str        s0, [x3]
0x28ad4  ldrsw      x9, [x0]
0x28ad8  cmp        x8, x9
0x28adc  b.lt       #0x28ab8
0x28ae0  scvtf      s1, w9
0x28ae4  fdiv       s0, s0, s1
0x28ae8  str        s0, [x3]
0x28aec  ret        
0x28af0  ldr        w9, [x0]
0x28af4  cmp        w9, #1
0x28af8  b.lt       #0x28b54
0x28afc  ldr        s2, [x0, #0x18]
0x28b00  mov        x8, xzr
0x28b04  fadd       s1, s2, s1
0x28b08  fsqrt      s1, s1
0x28b0c  fmov       s2, #1.00000000
0x28b10  fdiv       s1, s2, s1
0x28b14  ldr        x10, [x0, #0x10]
0x28b18  lsl        x11, x8, #2
0x28b1c  ldr        s2, [x1, x11]
0x28b20  add        w9, w8, w9
0x28b24  ldr        x10, [x10, #8]
0x28b28  add        x8, x8, #1
0x28b2c  fsub       s2, s2, s0
0x28b30  fmul       s2, s1, s2
0x28b34  ldr        s3, [x10, x11]
0x28b38  ldr        s4, [x10, w9, sxtw #2]
0x28b3c  fmul       s2, s3, s2
0x28b40  fadd       s2, s4, s2
0x28b44  str        s2, [x1, x11]
0x28b48  ldrsw      x9, [x0]
0x28b4c  cmp        x8, x9
0x28b50  b.lt       #0x28b14
0x28b54  ret        
0x28b58  sub        sp, sp, #0x40
0x28b5c  str        x30, [sp, #0x20]
0x28b60  stp        x20, x19, [sp, #0x30]
0x28b64  ldr        x8, [x0, #0x10]
0x28b68  mov        x20, x0
0x28b6c  mov        x19, x1
0x28b70  mov        w1, wzr
0x28b74  ldrsw      x9, [x8, #0x20]
0x28b78  ldr        x0, [x8, #8]
0x28b7c  lsl        x2, x9, #2
0x28b80  bl         #0x49680    ; memset
0x28b84  ldp        x8, x9, [x20, #8]
0x28b88  ldr        w6, [x20]
0x28b8c  ldr        x1, [x19, #8]
0x28b90  mov        w4, #1
0x28b94  ldp        x2, x0, [x8]
0x28b98  ldr        x3, [x9, #8]
0x28b9c  ldr        s0, [x8, #0x10]
0x28ba0  ldrb       w9, [x8, #0x14]
0x28ba4  ldrb       w8, [x8, #0x15]
0x28ba8  lsl        w5, w6, #1
0x28bac  mov        w7, w6
0x28bb0  strb       w9, [sp, #0x10]
0x28bb4  strb       w8, [sp, #0x18]
0x28bb8  str        w5, [sp, #8]
0x28bbc  str        w5, [sp]
0x28bc0  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x28bc4  ldp        x20, x19, [sp, #0x30]
0x28bc8  ldr        x30, [sp, #0x20]
0x28bcc  add        sp, sp, #0x40
0x28bd0  ret        
0x28bd4  sub        sp, sp, #0x30
0x28bd8  str        x30, [sp, #0x20]
0x28bdc  ldp        x8, x9, [x0, #8]
0x28be0  ldr        w6, [x0]
0x28be4  mov        w4, #1
0x28be8  ldp        x2, x0, [x8]
0x28bec  ldr        x3, [x9, #8]
0x28bf0  ldr        s0, [x8, #0x10]
0x28bf4  ldrb       w9, [x8, #0x14]
0x28bf8  ldrb       w8, [x8, #0x15]
0x28bfc  lsl        w5, w6, #1
0x28c00  mov        w7, w6
0x28c04  strb       w9, [sp, #0x10]
0x28c08  strb       w8, [sp, #0x18]
0x28c0c  str        w5, [sp, #8]
0x28c10  str        w5, [sp]
0x28c14  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x28c18  ldr        x30, [sp, #0x20]
0x28c1c  add        sp, sp, #0x30
0x28c20  ret        
0x28c24  ldr        w8, [x1, #0x20]
0x28c28  ldr        w10, [x0]
0x28c2c  sdiv       w8, w8, w10
0x28c30  cmp        w8, #1
0x28c34  b.lt       #0x28d10
0x28c38  mov        w9, wzr
0x28c3c  fmov       s0, #1.00000000
0x28c40  b          #0x28c50
0x28c44  add        w9, w9, #1
0x28c48  cmp        w9, w8
0x28c4c  b.eq       #0x28d10
0x28c50  cmp        w10, #1
0x28c54  b.lt       #0x28c44
0x28c58  ldr        x11, [x1, #8]
0x28c5c  mul        w13, w10, w9
0x28c60  mov        w12, w10
0x28c64  fmov       s1, wzr
0x28c68  add        x11, x11, w13, sxtw #2
0x28c6c  mov        x13, x11
0x28c70  mov        x14, x12
0x28c74  ldr        s2, [x13], #4
0x28c78  subs       x14, x14, #1
0x28c7c  fadd       s1, s1, s2
0x28c80  b.ne       #0x28c74
0x28c84  scvtf      s2, w10
0x28c88  fdiv       s1, s1, s2
0x28c8c  fmov       s3, wzr
0x28c90  mov        x13, x11
0x28c94  ldr        s4, [x13], #4
0x28c98  subs       x12, x12, #1
0x28c9c  fsub       s4, s4, s1
0x28ca0  fmul       s4, s4, s4
0x28ca4  fadd       s3, s3, s4
0x28ca8  b.ne       #0x28c94
0x28cac  cmp        w10, #1
0x28cb0  b.lt       #0x28c44
0x28cb4  ldr        s4, [x0, #0x18]
0x28cb8  fdiv       s2, s3, s2
0x28cbc  mov        x12, xzr
0x28cc0  fadd       s2, s4, s2
0x28cc4  fsqrt      s2, s2
0x28cc8  fdiv       s2, s0, s2
0x28ccc  ldr        x13, [x0, #0x10]
0x28cd0  lsl        x14, x12, #2
0x28cd4  ldr        s3, [x11, x14]
0x28cd8  add        w10, w12, w10
0x28cdc  ldr        x13, [x13, #8]
0x28ce0  add        x12, x12, #1
0x28ce4  fsub       s3, s3, s1
0x28ce8  fmul       s3, s2, s3
0x28cec  ldr        s4, [x13, x14]
0x28cf0  ldr        s5, [x13, w10, sxtw #2]
0x28cf4  fmul       s3, s4, s3
0x28cf8  fadd       s3, s5, s3
0x28cfc  str        s3, [x11, x14]
0x28d00  ldrsw      x10, [x0]
0x28d04  cmp        x12, x10
0x28d08  b.lt       #0x28ccc
0x28d0c  b          #0x28c44
0x28d10  ret        
0x28d14  str        d8, [sp, #-0x50]!
0x28d18  str        x30, [sp, #8]
0x28d1c  stp        x26, x25, [sp, #0x10]
0x28d20  stp        x24, x23, [sp, #0x20]
0x28d24  stp        x22, x21, [sp, #0x30]
0x28d28  stp        x20, x19, [sp, #0x40]
0x28d2c  mov        x19, x0
0x28d30  str        x1, [x0, #0x20]
0x28d34  stp        w4, w5, [x0]
0x28d38  str        w6, [x0, #8]
0x28d3c  mov        w0, #0x28
0x28d40  mov        w24, w7
0x28d44  mov        w20, w6
0x28d48  mov        x23, x3
0x28d4c  mov        w21, w2
0x28d50  mov        x22, x1
0x28d54  bl         #0x49500    ; _Znwm
0x28d58  movi       v8.2s, #1
0x28d5c  mov        w8, #0x400
0x28d60  lsl        w25, w20, #0xa
0x28d64  mov        x26, x0
0x28d68  str        d8, [x0, #0x10]
0x28d6c  stp        w8, w20, [x0, #0x18]
0x28d70  str        w25, [x0, #0x20]
0x28d74  str        w25, [x0]
0x28d78  sbfiz      x1, x25, #2, #0x20
0x28d7c  mov        w0, #0x40
0x28d80  bl         #0x49560    ; _Z14aligned_mallocmm
0x28d84  str        x0, [x26, #8]
0x28d88  str        x26, [x19, #0x10]
0x28d8c  str        d8, [x26, #0x10]
0x28d90  stp        wzr, w20, [x26, #0x18]
0x28d94  str        wzr, [x26, #0x20]
0x28d98  tbz        w20, #0x1f, #0x28db0
0x28d9c  adrp       x0, #0xe000
0x28da0  add        x0, x0, #0xed3
0x28da4  mov        w1, w25
0x28da8  mov        w2, wzr
0x28dac  bl         #0x496c0    ; printf
0x28db0  mov        w0, #0x28
0x28db4  bl         #0x49500    ; _Znwm
0x28db8  mov        w8, #0x10
0x28dbc  lsl        w25, w20, #4
0x28dc0  mov        x26, x0
0x28dc4  str        d8, [x0, #0x10]
0x28dc8  stp        w8, w20, [x0, #0x18]
0x28dcc  str        w25, [x0, #0x20]
0x28dd0  str        w25, [x0]
0x28dd4  sbfiz      x1, x25, #2, #0x20
0x28dd8  mov        w0, #0x40
0x28ddc  bl         #0x49560    ; _Z14aligned_mallocmm
0x28de0  str        x0, [x26, #8]
0x28de4  str        x26, [x19, #0x18]
0x28de8  str        d8, [x26, #0x10]
0x28dec  stp        wzr, w20, [x26, #0x18]
0x28df0  str        wzr, [x26, #0x20]
0x28df4  tbz        w20, #0x1f, #0x28e0c
0x28df8  adrp       x0, #0xe000
0x28dfc  add        x0, x0, #0xed3
0x28e00  mov        w1, w25
0x28e04  mov        w2, wzr
0x28e08  bl         #0x496c0    ; printf
0x28e0c  mov        w0, #0x18
0x28e10  bl         #0x49500    ; _Znwm
0x28e14  mov        w8, #0xbccc
0x28e18  movk       w8, #0x2b8c, lsl #16
0x28e1c  fmov       s8, w8
0x28e20  add        x1, x22, #0x158
0x28e24  mov        v0.16b, v8.16b
0x28e28  mov        w2, w20
0x28e2c  mov        x25, x0
0x28e30  bl         #0x49730    ; _ZN9LayerNormC1EP10NormParamsfi
0x28e34  mov        w0, #0x18
0x28e38  str        x25, [x19, #0x58]
0x28e3c  bl         #0x49500    ; _Znwm
0x28e40  add        x1, x22, #0x148
0x28e44  mov        v0.16b, v8.16b
0x28e48  mov        w2, w20
0x28e4c  mov        x25, x0
0x28e50  bl         #0x49730    ; _ZN9LayerNormC1EP10NormParamsfi
0x28e54  mov        w0, #0x18
0x28e58  str        x25, [x19, #0x50]
0x28e5c  bl         #0x49500    ; _Znwm
0x28e60  add        x1, x22, #0x168
0x28e64  mov        v0.16b, v8.16b
0x28e68  mov        w2, w20
0x28e6c  mov        x25, x0
0x28e70  bl         #0x49730    ; _ZN9LayerNormC1EP10NormParamsfi
0x28e74  mov        w0, #0x18
0x28e78  str        x25, [x19, #0x60]
0x28e7c  bl         #0x49500    ; _Znwm
0x28e80  add        x1, x22, #0x138
0x28e84  mov        v0.16b, v8.16b
0x28e88  mov        w2, w20
0x28e8c  mov        x25, x0
0x28e90  bl         #0x49730    ; _ZN9LayerNormC1EP10NormParamsfi
0x28e94  mov        w0, #0x18
0x28e98  str        x25, [x19, #0x48]
0x28e9c  bl         #0x49500    ; _Znwm
0x28ea0  add        x1, x22, #0x178
0x28ea4  mov        v0.16b, v8.16b
0x28ea8  mov        w2, w20
0x28eac  mov        x25, x0
0x28eb0  bl         #0x49730    ; _ZN9LayerNormC1EP10NormParamsfi
0x28eb4  mov        w0, #0x30
0x28eb8  str        x25, [x19, #0x68]
0x28ebc  bl         #0x49500    ; _Znwm
0x28ec0  add        x1, x22, #0xb0
0x28ec4  mov        w2, #1
0x28ec8  mov        w3, w20
0x28ecc  mov        w4, w24
0x28ed0  mov        x25, x0
0x28ed4  bl         #0x49d30    ; _ZN11FeedForwardC1EP17FeedForwardParamsiii
0x28ed8  mov        w0, #0x30
0x28edc  str        x25, [x19, #0x40]
0x28ee0  bl         #0x49500    ; _Znwm
0x28ee4  add        x1, x22, #0x80
0x28ee8  mov        w2, #1
0x28eec  mov        w3, w20
0x28ef0  mov        w4, w24
0x28ef4  mov        x25, x0
0x28ef8  bl         #0x49d30    ; _ZN11FeedForwardC1EP17FeedForwardParamsiii
0x28efc  mov        w0, #0x78
0x28f00  str        x25, [x19, #0x38]
0x28f04  bl         #0x49500    ; _Znwm
0x28f08  ldp        w3, w4, [x19]
0x28f0c  mov        x1, x22
0x28f10  mov        x2, x23
0x28f14  mov        w5, w20
0x28f18  mov        x24, x0
0x28f1c  bl         #0x49d40    ; _ZN11EncSelfAttnC1EP17EncSelfAttnParamsP16PositionEncodingiii
0x28f20  mov        w0, #0x58
0x28f24  str        x24, [x19, #0x30]
0x28f28  bl         #0x49500    ; _Znwm
0x28f2c  add        x1, x22, #0xe0
0x28f30  mov        w2, w21
0x28f34  mov        w3, w20
0x28f38  mov        x23, x0
0x28f3c  bl         #0x49d50    ; _ZN10ConvModuleC1EP13EncConvParamsii
0x28f40  ldr        x0, [x19, #0x30]
0x28f44  str        x23, [x19, #0x28]
0x28f48  str        wzr, [x19, #0xc]
0x28f4c  bl         #0x49d60    ; _ZN11EncSelfAttn11get_memsizeEv
0x28f50  ldr        w9, [x19, #0xc]
0x28f54  ldr        x8, [x19, #0x38]
0x28f58  add        w9, w9, w0
0x28f5c  mov        x0, x8
0x28f60  str        w9, [x19, #0xc]
0x28f64  bl         #0x49d70    ; _ZN11FeedForward11get_memsizeEv
0x28f68  ldr        w9, [x19, #0xc]
0x28f6c  ldr        x8, [x19, #0x40]
0x28f70  add        w9, w9, w0
0x28f74  mov        x0, x8
0x28f78  str        w9, [x19, #0xc]
0x28f7c  bl         #0x49d70    ; _ZN11FeedForward11get_memsizeEv
0x28f80  ldr        w9, [x19, #0xc]
0x28f84  ldr        x8, [x19, #0x28]
0x28f88  add        w9, w9, w0
0x28f8c  mov        x0, x8
0x28f90  str        w9, [x19, #0xc]
0x28f94  bl         #0x49d80    ; _ZN10ConvModule11get_memsizeEv
0x28f98  ldr        w9, [x19, #0xc]
0x28f9c  ldr        x8, [x19, #0x48]
0x28fa0  add        w9, w9, w0
0x28fa4  mov        x0, x8
0x28fa8  str        w9, [x19, #0xc]
0x28fac  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x28fb0  ldr        w9, [x19, #0xc]
0x28fb4  ldr        x8, [x19, #0x50]
0x28fb8  add        w9, w9, w0
0x28fbc  mov        x0, x8
0x28fc0  str        w9, [x19, #0xc]
0x28fc4  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x28fc8  ldr        w9, [x19, #0xc]
0x28fcc  ldr        x8, [x19, #0x58]
0x28fd0  add        w9, w9, w0
0x28fd4  mov        x0, x8
0x28fd8  str        w9, [x19, #0xc]
0x28fdc  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x28fe0  ldr        w9, [x19, #0xc]
0x28fe4  ldr        x8, [x19, #0x60]
0x28fe8  add        w9, w9, w0
0x28fec  mov        x0, x8
0x28ff0  str        w9, [x19, #0xc]
0x28ff4  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x28ff8  ldr        w9, [x19, #0xc]
0x28ffc  ldr        x8, [x19, #0x68]
0x29000  add        w9, w9, w0
0x29004  mov        x0, x8
0x29008  str        w9, [x19, #0xc]
0x2900c  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x29010  ldr        w8, [x19, #0xc]
0x29014  ldp        x22, x21, [sp, #0x30]
0x29018  ldp        x24, x23, [sp, #0x20]
0x2901c  ldp        x26, x25, [sp, #0x10]
0x29020  add        w8, w8, w0
0x29024  str        w8, [x19, #0xc]
0x29028  ldp        x20, x19, [sp, #0x40]
0x2902c  ldr        x30, [sp, #8]
0x29030  ldr        d8, [sp], #0x50
0x29034  ret        
0x29038  str        d8, [sp, #-0x50]!
0x2903c  str        x30, [sp, #8]
0x29040  stp        x26, x25, [sp, #0x10]
0x29044  stp        x24, x23, [sp, #0x20]
0x29048  stp        x22, x21, [sp, #0x30]
0x2904c  stp        x20, x19, [sp, #0x40]
0x29050  mov        x19, x0
0x29054  stp        w4, w5, [x0]
0x29058  str        w6, [x0, #8]
0x2905c  mov        w0, #0x28
0x29060  mov        w23, w7
0x29064  mov        w20, w6
0x29068  mov        x24, x3
0x2906c  mov        w22, w2
0x29070  mov        x21, x1
0x29074  bl         #0x49500    ; _Znwm
0x29078  movi       v8.2s, #1
0x2907c  mov        w8, #1
0x29080  mov        x25, x0
0x29084  stp        w20, w20, [x0, #0x1c]
0x29088  str        w20, [x0]
0x2908c  str        d8, [x0, #0x10]
0x29090  str        w8, [x0, #0x18]
0x29094  sbfiz      x1, x20, #2, #0x20
0x29098  mov        w0, #0x40
0x2909c  bl         #0x49560    ; _Z14aligned_mallocmm
0x290a0  str        x0, [x25, #8]
0x290a4  str        x25, [x19, #0x10]
0x290a8  str        d8, [x25, #0x10]
0x290ac  stp        wzr, w20, [x25, #0x18]
0x290b0  str        wzr, [x25, #0x20]
0x290b4  tbz        w20, #0x1f, #0x290cc
0x290b8  adrp       x0, #0xe000
0x290bc  add        x0, x0, #0xed3
0x290c0  mov        w1, w20
0x290c4  mov        w2, wzr
0x290c8  bl         #0x496c0    ; printf
0x290cc  mov        w0, #0x28
0x290d0  bl         #0x49500    ; _Znwm
0x290d4  mov        w8, #0x10
0x290d8  lsl        w25, w20, #4
0x290dc  mov        x26, x0
0x290e0  str        d8, [x0, #0x10]
0x290e4  stp        w8, w20, [x0, #0x18]
0x290e8  str        w25, [x0, #0x20]
0x290ec  str        w25, [x0]
0x290f0  sbfiz      x1, x25, #2, #0x20
0x290f4  mov        w0, #0x40
0x290f8  bl         #0x49560    ; _Z14aligned_mallocmm
0x290fc  str        x0, [x26, #8]
0x29100  str        x26, [x19, #0x18]
0x29104  str        d8, [x26, #0x10]
0x29108  stp        wzr, w20, [x26, #0x18]
0x2910c  str        wzr, [x26, #0x20]
0x29110  tbz        w20, #0x1f, #0x29128
0x29114  adrp       x0, #0xe000
0x29118  add        x0, x0, #0xed3
0x2911c  mov        w1, w25
0x29120  mov        w2, wzr
0x29124  bl         #0x496c0    ; printf
0x29128  mov        w0, #0x78
0x2912c  str        wzr, [x19, #0xc]
0x29130  bl         #0x49500    ; _Znwm
0x29134  ldp        w3, w4, [x19]
0x29138  mov        x1, x21
0x2913c  mov        x2, x24
0x29140  mov        w5, w20
0x29144  mov        x25, x0
0x29148  bl         #0x49d90    ; _ZN11EncSelfAttnC1EPvP16PositionEncodingiii
0x2914c  mov        x0, x25
0x29150  str        x25, [x19, #0x30]
0x29154  bl         #0x49d60    ; _ZN11EncSelfAttn11get_memsizeEv
0x29158  ldrsw      x8, [x19, #0xc]
0x2915c  add        x25, x8, w0, sxtw
0x29160  mov        w0, #0x30
0x29164  str        w25, [x19, #0xc]
0x29168  bl         #0x49500    ; _Znwm
0x2916c  add        x1, x21, x25
0x29170  mov        w2, #1
0x29174  mov        w3, w20
0x29178  mov        w4, w23
0x2917c  mov        x24, x0
0x29180  bl         #0x49da0    ; _ZN11FeedForwardC1EPviii
0x29184  mov        x0, x24
0x29188  str        x24, [x19, #0x38]
0x2918c  bl         #0x49d70    ; _ZN11FeedForward11get_memsizeEv
0x29190  ldrsw      x8, [x19, #0xc]
0x29194  add        x25, x8, w0, sxtw
0x29198  mov        w0, #0x30
0x2919c  str        w25, [x19, #0xc]
0x291a0  bl         #0x49500    ; _Znwm
0x291a4  add        x1, x21, x25
0x291a8  mov        w2, #1
0x291ac  mov        w3, w20
0x291b0  mov        w4, w23
0x291b4  mov        x24, x0
0x291b8  bl         #0x49da0    ; _ZN11FeedForwardC1EPviii
0x291bc  mov        x0, x24
0x291c0  str        x24, [x19, #0x40]
0x291c4  bl         #0x49d70    ; _ZN11FeedForward11get_memsizeEv
0x291c8  ldrsw      x8, [x19, #0xc]
0x291cc  add        x24, x8, w0, sxtw
0x291d0  mov        w0, #0x58
0x291d4  str        w24, [x19, #0xc]
0x291d8  bl         #0x49500    ; _Znwm
0x291dc  add        x1, x21, x24
0x291e0  mov        w2, w22
0x291e4  mov        w3, w20
0x291e8  mov        x23, x0
0x291ec  bl         #0x49db0    ; _ZN10ConvModuleC1EPvii
0x291f0  mov        x0, x23
0x291f4  str        x23, [x19, #0x28]
0x291f8  bl         #0x49d80    ; _ZN10ConvModule11get_memsizeEv
0x291fc  ldrsw      x8, [x19, #0xc]
0x29200  add        x23, x8, w0, sxtw
0x29204  mov        w0, #0x18
0x29208  str        w23, [x19, #0xc]
0x2920c  bl         #0x49500    ; _Znwm
0x29210  mov        w8, #0xbccc
0x29214  movk       w8, #0x2b8c, lsl #16
0x29218  fmov       s8, w8
0x2921c  add        x1, x21, x23
0x29220  mov        v0.16b, v8.16b
0x29224  mov        w2, w20
0x29228  mov        x22, x0
0x2922c  bl         #0x49770    ; _ZN9LayerNormC1EPvfi
0x29230  mov        x0, x22
0x29234  str        x22, [x19, #0x48]
0x29238  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x2923c  ldrsw      x8, [x19, #0xc]
0x29240  add        x23, x8, w0, sxtw
0x29244  mov        w0, #0x18
0x29248  str        w23, [x19, #0xc]
0x2924c  bl         #0x49500    ; _Znwm
0x29250  add        x1, x21, x23
0x29254  mov        v0.16b, v8.16b
0x29258  mov        w2, w20
0x2925c  mov        x22, x0
0x29260  bl         #0x49770    ; _ZN9LayerNormC1EPvfi
0x29264  mov        x0, x22
0x29268  str        x22, [x19, #0x50]
0x2926c  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x29270  ldrsw      x8, [x19, #0xc]
0x29274  add        x23, x8, w0, sxtw
0x29278  mov        w0, #0x18
0x2927c  str        w23, [x19, #0xc]
0x29280  bl         #0x49500    ; _Znwm
0x29284  add        x1, x21, x23
0x29288  mov        v0.16b, v8.16b
0x2928c  mov        w2, w20
0x29290  mov        x22, x0
0x29294  bl         #0x49770    ; _ZN9LayerNormC1EPvfi
0x29298  mov        x0, x22
0x2929c  str        x22, [x19, #0x58]
0x292a0  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x292a4  ldrsw      x8, [x19, #0xc]
0x292a8  add        x23, x8, w0, sxtw
0x292ac  mov        w0, #0x18
0x292b0  str        w23, [x19, #0xc]
0x292b4  bl         #0x49500    ; _Znwm
0x292b8  add        x1, x21, x23
0x292bc  mov        v0.16b, v8.16b
0x292c0  mov        w2, w20
0x292c4  mov        x22, x0
0x292c8  bl         #0x49770    ; _ZN9LayerNormC1EPvfi
0x292cc  mov        x0, x22
0x292d0  str        x22, [x19, #0x60]
0x292d4  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x292d8  ldrsw      x8, [x19, #0xc]
0x292dc  add        x23, x8, w0, sxtw
0x292e0  mov        w0, #0x18
0x292e4  str        w23, [x19, #0xc]
0x292e8  bl         #0x49500    ; _Znwm
0x292ec  add        x1, x21, x23
0x292f0  mov        v0.16b, v8.16b
0x292f4  mov        w2, w20
0x292f8  mov        x22, x0
0x292fc  bl         #0x49770    ; _ZN9LayerNormC1EPvfi
0x29300  mov        x0, x22
0x29304  str        x22, [x19, #0x68]
0x29308  bl         #0x49750    ; _ZN9LayerNorm11get_memsizeEv
0x2930c  ldr        w8, [x19, #0xc]
0x29310  ldp        x22, x21, [sp, #0x30]
0x29314  ldp        x24, x23, [sp, #0x20]
0x29318  ldp        x26, x25, [sp, #0x10]
0x2931c  add        w8, w8, w0
0x29320  str        w8, [x19, #0xc]
0x29324  ldp        x20, x19, [sp, #0x40]
0x29328  ldr        x30, [sp, #8]
0x2932c  ldr        d8, [sp], #0x50
0x29330  ret        
0x29334  ldr        w0, [x0, #0xc]
0x29338  ret        
0x2933c  str        x30, [sp, #-0x20]!
0x29340  stp        x20, x19, [sp, #0x10]
0x29344  ldr        x20, [x0, #0x10]
0x29348  mov        x19, x0
0x2934c  cbz        x20, #0x29368
0x29350  ldr        x0, [x20, #8]
0x29354  cbz        x0, #0x29360
0x29358  bl         #0x49630    ; _Z12aligned_freePv
0x2935c  str        xzr, [x20, #8]
0x29360  mov        x0, x20
0x29364  bl         #0x49600    ; _ZdlPv
0x29368  ldr        x20, [x19, #0x18]
0x2936c  cbz        x20, #0x29388
0x29370  ldr        x0, [x20, #8]
0x29374  cbz        x0, #0x29380
0x29378  bl         #0x49630    ; _Z12aligned_freePv
0x2937c  str        xzr, [x20, #8]
0x29380  mov        x0, x20
0x29384  bl         #0x49600    ; _ZdlPv
0x29388  ldr        x20, [x19, #0x58]
0x2938c  cbz        x20, #0x293a0
0x29390  mov        x0, x20
0x29394  bl         #0x49790    ; _ZN9LayerNormD1Ev
0x29398  mov        x0, x20
0x2939c  bl         #0x49600    ; _ZdlPv
0x293a0  ldr        x20, [x19, #0x50]
0x293a4  cbz        x20, #0x293b8
0x293a8  mov        x0, x20
0x293ac  bl         #0x49790    ; _ZN9LayerNormD1Ev
0x293b0  mov        x0, x20
0x293b4  bl         #0x49600    ; _ZdlPv
0x293b8  ldr        x20, [x19, #0x60]
0x293bc  cbz        x20, #0x293d0
0x293c0  mov        x0, x20
0x293c4  bl         #0x49790    ; _ZN9LayerNormD1Ev
0x293c8  mov        x0, x20
0x293cc  bl         #0x49600    ; _ZdlPv
0x293d0  ldr        x20, [x19, #0x48]
0x293d4  cbz        x20, #0x293e8
0x293d8  mov        x0, x20
0x293dc  bl         #0x49790    ; _ZN9LayerNormD1Ev
0x293e0  mov        x0, x20
0x293e4  bl         #0x49600    ; _ZdlPv
0x293e8  ldr        x20, [x19, #0x68]
0x293ec  cbz        x20, #0x29400
0x293f0  mov        x0, x20
0x293f4  bl         #0x49790    ; _ZN9LayerNormD1Ev
0x293f8  mov        x0, x20
0x293fc  bl         #0x49600    ; _ZdlPv
0x29400  ldr        x20, [x19, #0x40]
0x29404  cbz        x20, #0x29418
0x29408  mov        x0, x20
0x2940c  bl         #0x49dc0    ; _ZN11FeedForwardD1Ev
0x29410  mov        x0, x20
0x29414  bl         #0x49600    ; _ZdlPv
0x29418  ldr        x20, [x19, #0x38]
0x2941c  cbz        x20, #0x29430
0x29420  mov        x0, x20
0x29424  bl         #0x49dc0    ; _ZN11FeedForwardD1Ev
0x29428  mov        x0, x20
0x2942c  bl         #0x49600    ; _ZdlPv
0x29430  ldr        x20, [x19, #0x30]
0x29434  cbz        x20, #0x29448
0x29438  mov        x0, x20
0x2943c  bl         #0x49dd0    ; _ZN11EncSelfAttnD1Ev
0x29440  mov        x0, x20
0x29444  bl         #0x49600    ; _ZdlPv
0x29448  ldr        x19, [x19, #0x28]
0x2944c  cbz        x19, #0x29468
0x29450  mov        x0, x19
0x29454  bl         #0x49de0    ; _ZN10ConvModuleD1Ev
0x29458  mov        x0, x19
0x2945c  ldp        x20, x19, [sp, #0x10]
0x29460  ldr        x30, [sp], #0x20
0x29464  b          #0x49600    ; _ZdlPv
0x29468  ldp        x20, x19, [sp, #0x10]
0x2946c  ldr        x30, [sp], #0x20
0x29470  ret        
0x29474  str        d8, [sp, #-0x20]!
0x29478  stp        x30, x19, [sp, #0x10]
0x2947c  ldr        x8, [x0, #0x10]
0x29480  ldr        w9, [x0, #8]
0x29484  mov        x19, x0
0x29488  movi       v8.2s, #1
0x2948c  ldr        w1, [x8]
0x29490  str        d8, [x8, #0x10]
0x29494  stp        wzr, w9, [x8, #0x18]
0x29498  str        wzr, [x8, #0x20]
0x2949c  tbz        w1, #0x1f, #0x294b0
0x294a0  adrp       x0, #0xe000
0x294a4  add        x0, x0, #0xed3
0x294a8  mov        w2, wzr
0x294ac  bl         #0x496c0    ; printf
0x294b0  ldr        x8, [x19, #0x18]
0x294b4  ldr        w9, [x19, #8]
0x294b8  ldr        w1, [x8]
0x294bc  str        d8, [x8, #0x10]
0x294c0  stp        wzr, w9, [x8, #0x18]
0x294c4  str        wzr, [x8, #0x20]
0x294c8  tbz        w1, #0x1f, #0x294dc
0x294cc  adrp       x0, #0xe000
0x294d0  add        x0, x0, #0xed3
0x294d4  mov        w2, wzr
0x294d8  bl         #0x496c0    ; printf
0x294dc  ldr        x0, [x19, #0x28]
0x294e0  bl         #0x49810    ; _ZN10ConvModule5resetEv
0x294e4  ldr        x0, [x19, #0x30]
0x294e8  ldp        x30, x19, [sp, #0x10]
0x294ec  ldr        d8, [sp], #0x20
0x294f0  b          #0x49df0    ; _ZN11EncSelfAttn5resetEv
0x294f4  stp        x30, x21, [sp, #-0x20]!
0x294f8  stp        x20, x19, [sp, #0x10]
0x294fc  ldr        x8, [x0, #0x18]
0x29500  ldp        w9, w10, [x1, #0x10]
0x29504  ldp        w11, w12, [x1, #0x18]
0x29508  mov        x19, x1
0x2950c  ldr        w1, [x8]
0x29510  stp        w9, w10, [x8, #0x10]
0x29514  mul        w9, w10, w9
0x29518  mul        w9, w9, w11
0x2951c  mul        w2, w9, w12
0x29520  mov        x20, x0
0x29524  cmp        w1, w2
0x29528  stp        w11, w12, [x8, #0x18]
0x2952c  str        w2, [x8, #0x20]
0x29530  b.ge       #0x29540
0x29534  adrp       x0, #0xe000
0x29538  add        x0, x0, #0xed3
0x2953c  bl         #0x496c0    ; printf
0x29540  ldr        x21, [x20, #0x18]
0x29544  ldr        w8, [x19, #0x20]
0x29548  ldr        w1, [x21]
0x2954c  cmp        w1, w8
0x29550  b.ge       #0x29568
0x29554  ldr        w2, [x21, #0x20]
0x29558  adrp       x0, #0xf000
0x2955c  add        x0, x0, #0x22f
0x29560  bl         #0x496c0    ; printf
0x29564  ldr        w8, [x19, #0x20]
0x29568  ldr        x0, [x21, #8]
0x2956c  ldr        x1, [x19, #8]
0x29570  sbfiz      x2, x8, #2, #0x20
0x29574  bl         #0x496d0    ; memcpy
0x29578  ldp        w8, w9, [x19, #0x10]
0x2957c  ldp        w10, w11, [x19, #0x18]
0x29580  ldr        w1, [x21]
0x29584  stp        w8, w9, [x21, #0x10]
0x29588  mul        w8, w9, w8
0x2958c  mul        w8, w8, w10
0x29590  mul        w2, w8, w11
0x29594  cmp        w1, w2
0x29598  stp        w10, w11, [x21, #0x18]
0x2959c  str        w2, [x21, #0x20]
0x295a0  b.ge       #0x295b0
0x295a4  adrp       x0, #0xe000
0x295a8  add        x0, x0, #0xed3
0x295ac  bl         #0x496c0    ; printf
0x295b0  ldr        x0, [x20, #0x58]
0x295b4  ldr        x1, [x20, #0x18]
0x295b8  bl         #0x497b0    ; _ZN9LayerNorm7forwardEP6TensorIfE
0x295bc  ldr        x0, [x20, #0x40]
0x295c0  ldr        x1, [x20, #0x18]
0x295c4  bl         #0x49e00    ; _ZN11FeedForward7forwardEP6TensorIfE
0x295c8  ldr        w8, [x19, #0x20]
0x295cc  cmp        w8, #1
0x295d0  b.lt       #0x29614
0x295d4  ldr        x9, [x20, #0x18]
0x295d8  mov        x8, xzr
0x295dc  fmov       s0, #0.50000000
0x295e0  ldr        x10, [x9, #8]
0x295e4  ldr        x11, [x19, #8]
0x295e8  lsl        x12, x8, #2
0x295ec  add        x8, x8, #1
0x295f0  ldr        s1, [x10, x12]
0x295f4  ldr        s2, [x11, x12]
0x295f8  fmul       s1, s1, s0
0x295fc  fadd       s1, s2, s1
0x29600  str        s1, [x11, x12]
0x29604  ldrsw      x10, [x19, #0x20]
0x29608  cmp        x8, x10
0x2960c  b.lt       #0x295e0
0x29610  mov        w8, w10
0x29614  ldr        x21, [x20, #0x18]
0x29618  ldr        w1, [x21]
0x2961c  cmp        w1, w8
0x29620  b.ge       #0x29638
0x29624  ldr        w2, [x21, #0x20]
0x29628  adrp       x0, #0xf000
0x2962c  add        x0, x0, #0x22f
0x29630  bl         #0x496c0    ; printf
0x29634  ldr        w8, [x19, #0x20]
0x29638  ldr        x0, [x21, #8]
0x2963c  ldr        x1, [x19, #8]
0x29640  sbfiz      x2, x8, #2, #0x20
0x29644  bl         #0x496d0    ; memcpy
0x29648  ldp        w8, w9, [x19, #0x10]
0x2964c  ldp        w10, w11, [x19, #0x18]
0x29650  ldr        w1, [x21]
0x29654  stp        w8, w9, [x21, #0x10]
0x29658  mul        w8, w9, w8
0x2965c  mul        w8, w8, w10
0x29660  mul        w2, w8, w11
0x29664  cmp        w1, w2
0x29668  stp        w10, w11, [x21, #0x18]
0x2966c  str        w2, [x21, #0x20]
0x29670  b.ge       #0x29680
0x29674  adrp       x0, #0xe000
0x29678  add        x0, x0, #0xed3
0x2967c  bl         #0x496c0    ; printf
0x29680  ldr        x0, [x20, #0x50]
0x29684  mov        x1, x19
0x29688  bl         #0x497b0    ; _ZN9LayerNorm7forwardEP6TensorIfE
0x2968c  ldr        x0, [x20, #0x30]
0x29690  mov        x1, x19
0x29694  mov        x2, x19
0x29698  mov        x3, x19
0x2969c  bl         #0x49e10    ; _ZN11EncSelfAttn7forwardEP6TensorIfES2_S2_
0x296a0  ldr        w8, [x19, #0x20]
0x296a4  cmp        w8, #1
0x296a8  b.lt       #0x296e4
0x296ac  ldr        x8, [x20, #0x18]
0x296b0  mov        x9, xzr
0x296b4  ldr        x10, [x19, #8]
0x296b8  ldr        x11, [x8, #8]
0x296bc  lsl        x12, x9, #2
0x296c0  add        x9, x9, #1
0x296c4  ldr        s0, [x10, x12]
0x296c8  ldr        s1, [x11, x12]
0x296cc  fadd       s0, s0, s1
0x296d0  str        s0, [x10, x12]
0x296d4  ldrsw      x10, [x19, #0x20]
0x296d8  cmp        x9, x10
0x296dc  b.lt       #0x296b4
0x296e0  mov        w8, w10
0x296e4  ldr        x21, [x20, #0x18]
0x296e8  ldr        w1, [x21]
0x296ec  cmp        w1, w8
0x296f0  b.ge       #0x29708
0x296f4  ldr        w2, [x21, #0x20]
0x296f8  adrp       x0, #0xf000
0x296fc  add        x0, x0, #0x22f
0x29700  bl         #0x496c0    ; printf
0x29704  ldr        w8, [x19, #0x20]
0x29708  ldr        x0, [x21, #8]
0x2970c  ldr        x1, [x19, #8]
0x29710  sbfiz      x2, x8, #2, #0x20
0x29714  bl         #0x496d0    ; memcpy
0x29718  ldp        w8, w9, [x19, #0x10]
0x2971c  ldp        w10, w11, [x19, #0x18]
0x29720  ldr        w1, [x21]
0x29724  stp        w8, w9, [x21, #0x10]
0x29728  mul        w8, w9, w8
0x2972c  mul        w8, w8, w10
0x29730  mul        w2, w8, w11
0x29734  cmp        w1, w2
0x29738  stp        w10, w11, [x21, #0x18]
0x2973c  str        w2, [x21, #0x20]
0x29740  b.ge       #0x29750
0x29744  adrp       x0, #0xe000
0x29748  add        x0, x0, #0xed3
0x2974c  bl         #0x496c0    ; printf
0x29750  ldr        x0, [x20, #0x60]
0x29754  mov        x1, x19
0x29758  bl         #0x497b0    ; _ZN9LayerNorm7forwardEP6TensorIfE
0x2975c  ldr        x0, [x20, #0x28]
0x29760  mov        x1, x19
0x29764  bl         #0x49e20    ; _ZN10ConvModule7forwardEP6TensorIfE
0x29768  ldr        w8, [x19, #0x20]
0x2976c  cmp        w8, #1
0x29770  b.lt       #0x297ac
0x29774  ldr        x8, [x20, #0x18]
0x29778  mov        x9, xzr
0x2977c  ldr        x10, [x19, #8]
0x29780  ldr        x11, [x8, #8]
0x29784  lsl        x12, x9, #2
0x29788  add        x9, x9, #1
0x2978c  ldr        s0, [x10, x12]
0x29790  ldr        s1, [x11, x12]
0x29794  fadd       s0, s0, s1
0x29798  str        s0, [x10, x12]
0x2979c  ldrsw      x10, [x19, #0x20]
0x297a0  cmp        x9, x10
0x297a4  b.lt       #0x2977c
0x297a8  mov        w8, w10
0x297ac  ldr        x21, [x20, #0x18]
0x297b0  ldr        w1, [x21]
0x297b4  cmp        w1, w8
0x297b8  b.ge       #0x297d0
0x297bc  ldr        w2, [x21, #0x20]
0x297c0  adrp       x0, #0xf000
0x297c4  add        x0, x0, #0x22f
0x297c8  bl         #0x496c0    ; printf
0x297cc  ldr        w8, [x19, #0x20]
0x297d0  ldr        x0, [x21, #8]
0x297d4  ldr        x1, [x19, #8]
0x297d8  sbfiz      x2, x8, #2, #0x20
0x297dc  bl         #0x496d0    ; memcpy
0x297e0  ldp        w8, w9, [x19, #0x10]
0x297e4  ldp        w10, w11, [x19, #0x18]
0x297e8  ldr        w1, [x21]
0x297ec  stp        w8, w9, [x21, #0x10]
0x297f0  mul        w8, w9, w8
0x297f4  mul        w8, w8, w10
0x297f8  mul        w2, w8, w11
0x297fc  cmp        w1, w2
0x29800  stp        w10, w11, [x21, #0x18]
0x29804  str        w2, [x21, #0x20]
0x29808  b.ge       #0x29818
0x2980c  adrp       x0, #0xe000
0x29810  add        x0, x0, #0xed3
0x29814  bl         #0x496c0    ; printf
0x29818  ldr        x0, [x20, #0x48]
0x2981c  ldr        x1, [x20, #0x18]
0x29820  bl         #0x497b0    ; _ZN9LayerNorm7forwardEP6TensorIfE
0x29824  ldr        x0, [x20, #0x38]
0x29828  ldr        x1, [x20, #0x18]
0x2982c  bl         #0x49e00    ; _ZN11FeedForward7forwardEP6TensorIfE
0x29830  ldr        w8, [x19, #0x20]
0x29834  cmp        w8, #1
0x29838  b.lt       #0x29878
0x2983c  ldr        x9, [x20, #0x18]
0x29840  mov        x8, xzr
0x29844  fmov       s0, #0.50000000
0x29848  ldr        x10, [x9, #8]
0x2984c  ldr        x11, [x19, #8]
0x29850  lsl        x12, x8, #2
0x29854  add        x8, x8, #1
0x29858  ldr        s1, [x10, x12]
0x2985c  ldr        s2, [x11, x12]
0x29860  fmul       s1, s1, s0
0x29864  fadd       s1, s2, s1
0x29868  str        s1, [x11, x12]
0x2986c  ldrsw      x10, [x19, #0x20]
0x29870  cmp        x8, x10
0x29874  b.lt       #0x29848
0x29878  ldr        x0, [x20, #0x68]
0x2987c  mov        x1, x19
0x29880  ldp        x20, x19, [sp, #0x10]
0x29884  ldp        x30, x21, [sp], #0x20
0x29888  b          #0x497b0    ; _ZN9LayerNorm7forwardEP6TensorIfE
0x2988c  str        d8, [sp, #-0x50]!
0x29890  str        x30, [sp, #8]
0x29894  stp        x26, x25, [sp, #0x10]
0x29898  stp        x24, x23, [sp, #0x20]
0x2989c  stp        x22, x21, [sp, #0x30]
0x298a0  stp        x20, x19, [sp, #0x40]
0x298a4  mov        x19, x0
0x298a8  str        x1, [x0, #0x18]
0x298ac  stp        w4, w5, [x0]
0x298b0  str        w6, [x0, #8]
0x298b4  mov        w0, #0x28
0x298b8  mov        w23, w7
0x298bc  mov        w25, w6
0x298c0  mov        x22, x3
0x298c4  mov        w20, w2
0x298c8  mov        x21, x1
0x298cc  bl         #0x49500    ; _Znwm
0x298d0  movi       v8.2s, #1
0x298d4  mov        w8, #0x10
0x298d8  lsl        w24, w25, #4
0x298dc  mov        x26, x0
0x298e0  str        d8, [x0, #0x10]
0x298e4  stp        w8, w25, [x0, #0x18]
0x298e8  str        w24, [x0, #0x20]
0x298ec  str        w24, [x0]
0x298f0  sbfiz      x1, x24, #2, #0x20
0x298f4  mov        w0, #0x40
0x298f8  bl         #0x49560    ; _Z14aligned_mallocmm
0x298fc  str        x0, [x26, #8]
0x29900  ldr        w8, [x19, #8]
0x29904  str        x26, [x19, #0x10]
0x29908  str        d8, [x26, #0x10]
0x2990c  str        wzr, [x26, #0x20]
0x29910  stp        wzr, w8, [x26, #0x18]
0x29914  tbz        w25, #0x1f, #0x2992c
0x29918  adrp       x0, #0xe000
0x2991c  add        x0, x0, #0xed3
0x29920  mov        w1, w24
0x29924  mov        w2, wzr
0x29928  bl         #0x496c0    ; printf
0x2992c  mov        w0, #0x20
0x29930  bl         #0x49500    ; _Znwm
0x29934  ldr        w2, [x19, #8]
0x29938  mov        w8, #0xbccc
0x2993c  movk       w8, #0x2b8c, lsl #16
0x29940  fmov       s8, w8
0x29944  add        x1, x21, #0x168
0x29948  mov        v0.16b, v8.16b
0x2994c  mov        x24, x0
0x29950  bl         #0x49e30    ; _ZN14StyleLayerNormC1EP15StyleNormParamsfi
0x29954  mov        w0, #0x20
0x29958  str        x24, [x19, #0x50]
0x2995c  bl         #0x49500    ; _Znwm
0x29960  ldr        w2, [x19, #8]
0x29964  add        x1, x21, #0x150
0x29968  mov        v0.16b, v8.16b
0x2996c  mov        x24, x0
0x29970  bl         #0x49e30    ; _ZN14StyleLayerNormC1EP15StyleNormParamsfi
0x29974  mov        w0, #0x20
0x29978  str        x24, [x19, #0x48]
0x2997c  bl         #0x49500    ; _Znwm
0x29980  ldr        w2, [x19, #8]
0x29984  add        x1, x21, #0x180
0x29988  mov        v0.16b, v8.16b
0x2998c  mov        x24, x0
0x29990  bl         #0x49e30    ; _ZN14StyleLayerNormC1EP15StyleNormParamsfi
0x29994  mov        w0, #0x20
0x29998  str        x24, [x19, #0x58]
0x2999c  bl         #0x49500    ; _Znwm
0x299a0  ldr        w2, [x19, #8]
0x299a4  add        x1, x21, #0x138
0x299a8  mov        v0.16b, v8.16b
0x299ac  mov        x24, x0
0x299b0  bl         #0x49e30    ; _ZN14StyleLayerNormC1EP15StyleNormParamsfi
0x299b4  mov        w0, #0x20
0x299b8  str        x24, [x19, #0x40]
0x299bc  bl         #0x49500    ; _Znwm
0x299c0  ldr        w2, [x19, #8]
0x299c4  add        x1, x21, #0x198
0x299c8  mov        v0.16b, v8.16b
0x299cc  mov        x24, x0
0x299d0  bl         #0x49e30    ; _ZN14StyleLayerNormC1EP15StyleNormParamsfi
0x299d4  mov        w0, #0x30
0x299d8  str        x24, [x19, #0x60]
0x299dc  bl         #0x49500    ; _Znwm
0x299e0  ldr        w3, [x19, #8]
0x299e4  add        x1, x21, #0xb0
0x299e8  mov        w2, #1
0x299ec  mov        w4, w23
0x299f0  mov        x24, x0
0x299f4  bl         #0x49d30    ; _ZN11FeedForwardC1EP17FeedForwardParamsiii
0x299f8  mov        w0, #0x30
0x299fc  str        x24, [x19, #0x38]
0x29a00  bl         #0x49500    ; _Znwm
0x29a04  ldr        w3, [x19, #8]
0x29a08  add        x1, x21, #0x80
0x29a0c  mov        w2, #1
0x29a10  mov        w4, w23
0x29a14  mov        x24, x0
0x29a18  bl         #0x49d30    ; _ZN11FeedForwardC1EP17FeedForwardParamsiii
0x29a1c  mov        w0, #0x78
0x29a20  str        x24, [x19, #0x30]
0x29a24  bl         #0x49500    ; _Znwm
0x29a28  ldp        w3, w4, [x19]
0x29a2c  ldr        w5, [x19, #8]
0x29a30  mov        x1, x21
0x29a34  mov        x2, x22
0x29a38  mov        x23, x0
0x29a3c  bl         #0x49d40    ; _ZN11EncSelfAttnC1EP17EncSelfAttnParamsP16PositionEncodingiii
0x29a40  mov        w0, #0x58
0x29a44  str        x23, [x19, #0x28]
0x29a48  bl         #0x49500    ; _Znwm
0x29a4c  ldr        w3, [x19, #8]
0x29a50  add        x1, x21, #0xe0
0x29a54  mov        w2, w20
0x29a58  mov        x22, x0
0x29a5c  bl         #0x49d50    ; _ZN10ConvModuleC1EP13EncConvParamsii
0x29a60  ldr        x0, [x19, #0x28]
0x29a64  str        x22, [x19, #0x20]
0x29a68  str        wzr, [x19, #0xc]
0x29a6c  bl         #0x49d60    ; _ZN11EncSelfAttn11get_memsizeEv
