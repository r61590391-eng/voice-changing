_ZN8DeConv1d7forwardEP6TensorIfE 0x1e6c8
0x1e6c8  sub        sp, sp, #0xc0
0x1e6cc  stp        x29, x30, [sp, #0x60]
0x1e6d0  stp        x28, x27, [sp, #0x70]
0x1e6d4  stp        x26, x25, [sp, #0x80]
0x1e6d8  stp        x24, x23, [sp, #0x90]
0x1e6dc  stp        x22, x21, [sp, #0xa0]
0x1e6e0  stp        x20, x19, [sp, #0xb0]
0x1e6e4  ldr        w8, [x0, #0x10]
0x1e6e8  ldp        x11, x12, [x0, #0x20]
0x1e6ec  ldp        w24, w23, [x1, #0x18]
0x1e6f0  mov        x19, x1
0x1e6f4  mov        x20, x0
0x1e6f8  ldp        w21, w26, [x0]
0x1e6fc  ldr        w27, [x0, #8]
0x1e700  ldr        x0, [x1, #8]
0x1e704  cmp        w8, #1
0x1e708  ldr        x1, [x11, #8]
0x1e70c  ldr        x8, [x12, #8]
0x1e710  mov        w9, #2
0x1e714  mov        w10, #4
0x1e718  csel       w25, w10, w9, eq
0x1e71c  sub        w28, w25, #1
0x1e720  mov        w2, #1
0x1e724  mov        w6, #1
0x1e728  mov        w7, #1
0x1e72c  mov        w3, w24
0x1e730  mov        w4, w23
0x1e734  mov        w5, w25
0x1e738  sxtw       x21, w21
0x1e73c  csel       x29, x10, x9, eq
0x1e740  str        w28, [sp]
0x1e744  str        wzr, [sp, #8]
0x1e748  str        x8, [sp, #0x10]
0x1e74c  bl         #0x497d0    ; _Z10im2col_cpuPfPKfiiiiiiiiS_
0x1e750  ldr        x8, [x20, #0x28]
0x1e754  mul        x21, x29, x21
0x1e758  mul        w2, w0, w21
0x1e75c  mov        w22, w0
0x1e760  ldr        w1, [x8]
0x1e764  movi       v0.2s, #1
0x1e768  str        d0, [x8, #0x10]
0x1e76c  stp        w0, w21, [x8, #0x18]
0x1e770  cmp        w1, w2
0x1e774  str        w2, [x8, #0x20]
0x1e778  b.ge       #0x1e788
0x1e77c  adrp       x0, #0xe000
0x1e780  add        x0, x0, #0xed3
0x1e784  bl         #0x496c0    ; printf
0x1e788  ldr        x8, [x20, #0x20]
0x1e78c  ldr        x9, [x19, #8]
0x1e790  sxtw       x29, w26
0x1e794  sdiv       w25, w27, w25
0x1e798  ldr        x0, [x8, #8]
0x1e79c  mul        w8, w23, w24
0x1e7a0  add        x1, x9, w8, sxtw #2
0x1e7a4  mul        w8, w28, w23
0x1e7a8  sbfiz      x2, x8, #2, #0x20
0x1e7ac  bl         #0x496d0    ; memcpy
0x1e7b0  ldr        w8, [x20, #0x10]
0x1e7b4  cbz        w8, #0x1e7e4
0x1e7b8  ldr        x0, [x19, #8]
0x1e7bc  mov        w8, w22
0x1e7c0  sxtw       x9, w25
0x1e7c4  sxtw       x8, w8
0x1e7c8  mul        x9, x29, x9
0x1e7cc  mul        x8, x9, x8
0x1e7d0  lsl        x2, x8, #2
0x1e7d4  mov        w1, wzr
0x1e7d8  bl         #0x49680    ; memset
0x1e7dc  mul        w24, w22, w25
0x1e7e0  b          #0x1e820
0x1e7e4  mul        w24, w22, w25
0x1e7e8  cmp        w24, #1
0x1e7ec  b.lt       #0x1e820
0x1e7f0  mov        x27, xzr
0x1e7f4  lsl        x23, x29, #2
0x1e7f8  mov        w28, w24
0x1e7fc  ldr        x8, [x20, #0x18]
0x1e800  ldr        x9, [x19, #8]
0x1e804  mov        x2, x23
0x1e808  ldr        x1, [x8, #8]
0x1e80c  add        x0, x9, x27
0x1e810  bl         #0x496d0    ; memcpy
0x1e814  subs       x28, x28, #1
0x1e818  add        x27, x27, x23
0x1e81c  b.ne       #0x1e7fc
0x1e820  ldr        x9, [x20, #0x28]
0x1e824  ldr        x10, [x20, #0x18]
0x1e828  mul        w8, w25, w26
0x1e82c  ldr        x11, [x19, #8]
0x1e830  sxtw       x3, w8
0x1e834  ldr        x8, [x9, #8]
0x1e838  ldr        x9, [x10]
0x1e83c  sxtw       x2, w22
0x1e840  fmov       v0.2s, #1.00000000
0x1e844  add        x5, sp, #0x18
0x1e848  mov        w0, #0x6f
0x1e84c  mov        w1, #0x70
0x1e850  mov        w6, #1
0x1e854  mov        x4, x21
0x1e858  mov        x7, xzr
0x1e85c  strb       wzr, [sp, #0x50]
0x1e860  str        xzr, [sp, #0x58]
0x1e864  str        d0, [sp, #0x48]
0x1e868  stp        x8, x21, [sp, #0x18]
0x1e86c  stp        x9, x21, [sp, #0x28]
0x1e870  stp        x11, x3, [sp, #0x38]
0x1e874  bl         #0x497e0    ; _Z13MlasGemmBatch15CBLAS_TRANSPOSES_mmmPK22MLAS_SGEMM_DATA_PARAMSmP15IMlasThreadPool
0x1e878  ldr        w1, [x19]
0x1e87c  mul        w2, w24, w26
0x1e880  movi       v0.2s, #1
0x1e884  str        d0, [x19, #0x10]
0x1e888  cmp        w1, w2
0x1e88c  stp        w24, w26, [x19, #0x18]
0x1e890  str        w2, [x19, #0x20]
0x1e894  b.ge       #0x1e8a4
0x1e898  adrp       x0, #0xe000
0x1e89c  add        x0, x0, #0xed3
0x1e8a0  bl         #0x496c0    ; printf
0x1e8a4  ldp        x20, x19, [sp, #0xb0]
0x1e8a8  ldp        x22, x21, [sp, #0xa0]
0x1e8ac  ldp        x24, x23, [sp, #0x90]
0x1e8b0  ldp        x26, x25, [sp, #0x80]
0x1e8b4  ldp        x28, x27, [sp, #0x70]
0x1e8b8  ldp        x29, x30, [sp, #0x60]
0x1e8bc  add        sp, sp, #0xc0
0x1e8c0  ret        
0x1e8c4  adrp       x8, #0x4f000
0x1e8c8  ldr        x8, [x8, #0x390]
0x1e8cc  strh       wzr, [x0, #0x10]
0x1e8d0  strb       wzr, [x0, #0x12]
0x1e8d4  add        x8, x8, #0x10
0x1e8d8  str        x8, [x0]
0x1e8dc  ret        
0x1e8e0  ret        
0x1e8e4  b          #0x49600    ; _ZdlPv
0x1e8e8  adrp       x0, #0xf000
0x1e8ec  add        x0, x0, #0xc5
0x1e8f0  ret        
0x1e8f4  str        x30, [sp, #-0x10]!
0x1e8f8  mov        x8, x0
0x1e8fc  mov        x0, xzr
0x1e900  cbz        x1, #0x1e918
0x1e904  ldr        x8, [x8, #8]
0x1e908  cbz        x8, #0x1e918
0x1e90c  mov        x0, x8
0x1e910  bl         #0x498a0    ; _ZN6engine8setstyleEPf
0x1e914  mov        w0, #1
0x1e918  ldr        x30, [sp], #0x10
0x1e91c  ret        
0x1e920  str        x30, [sp, #-0x20]!
0x1e924  stp        x20, x19, [sp, #0x10]
0x1e928  ldr        x20, [x0, #8]
0x1e92c  mov        x19, x0
0x1e930  cbz        x20, #0x1e944
0x1e934  mov        x0, x20
0x1e938  bl         #0x498b0    ; _ZN6engineD1Ev
0x1e93c  mov        x0, x20
0x1e940  bl         #0x49600    ; _ZdlPv
0x1e944  str        xzr, [x19, #8]
0x1e948  strb       wzr, [x19, #0x10]
0x1e94c  strb       wzr, [x19, #0x12]
0x1e950  ldp        x20, x19, [sp, #0x10]
0x1e954  ldr        x30, [sp], #0x20
0x1e958  ret        
0x1e95c  stp        x30, x21, [sp, #-0x20]!
0x1e960  stp        x20, x19, [sp, #0x10]
0x1e964  ldrb       w8, [x0, #0x10]
0x1e968  cbz        w8, #0x1e9d0
0x1e96c  mov        x19, x0
0x1e970  ldr        x0, [x0, #8]
0x1e974  cbz        x0, #0x1e9d0
0x1e978  mov        w8, #1
0x1e97c  strb       w8, [x19, #0x11]
0x1e980  bl         #0x498c0    ; _ZN6engine6InpushEPsiiiPf
0x1e984  ldrb       w8, [x19, #0x12]
0x1e988  mov        w20, w0
0x1e98c  strb       wzr, [x19, #0x11]
0x1e990  cbz        w8, #0x1e9b8
0x1e994  ldr        x21, [x19, #8]
0x1e998  cbz        x21, #0x1e9ac
0x1e99c  mov        x0, x21
0x1e9a0  bl         #0x498b0    ; _ZN6engineD1Ev
0x1e9a4  mov        x0, x21
0x1e9a8  bl         #0x49600    ; _ZdlPv
0x1e9ac  str        xzr, [x19, #8]
0x1e9b0  strb       wzr, [x19, #0x10]
0x1e9b4  strb       wzr, [x19, #0x12]
0x1e9b8  sxtw       x8, w20
0x1e9bc  cmp        w20, #1
0x1e9c0  csel       x0, xzr, x8, lt
0x1e9c4  ldp        x20, x19, [sp, #0x10]
0x1e9c8  ldp        x30, x21, [sp], #0x20
0x1e9cc  ret        
0x1e9d0  mov        x0, #-1
0x1e9d4  ldp        x20, x19, [sp, #0x10]
0x1e9d8  ldp        x30, x21, [sp], #0x20
0x1e9dc  ret        
0x1e9e0  str        x30, [sp, #-0x10]!
0x1e9e4  ldrb       w8, [x0, #0x10]
0x1e9e8  cbz        w8, #0x1ea0c
0x1e9ec  ldr        x0, [x0, #8]
0x1e9f0  cbz        x0, #0x1ea0c
0x1e9f4  bl         #0x498d0    ; _ZN6engine6OutpopEPsi
0x1e9f8  sxtw       x8, w0
0x1e9fc  cmp        w0, #1
0x1ea00  csel       x0, xzr, x8, lt
0x1ea04  ldr        x30, [sp], #0x10
0x1ea08  ret        
0x1ea0c  mov        x0, #-1
0x1ea10  ldr        x30, [sp], #0x10
0x1ea14  ret        
0x1ea18  stp        x30, x25, [sp, #-0x40]!
0x1ea1c  stp        x24, x23, [sp, #0x10]
0x1ea20  stp        x22, x21, [sp, #0x20]
0x1ea24  stp        x20, x19, [sp, #0x30]
0x1ea28  mov        x24, x0
0x1ea2c  mov        w0, #0x78
0x1ea30  mov        x19, x5
0x1ea34  mov        x20, x4
0x1ea38  mov        x21, x3
0x1ea3c  mov        x22, x2
0x1ea40  mov        x23, x1
0x1ea44  bl         #0x49500    ; _Znwm
0x1ea48  mov        x1, x23
0x1ea4c  mov        x2, x22
0x1ea50  mov        x3, x21
0x1ea54  mov        w4, w20
0x1ea58  mov        w5, w19
0x1ea5c  mov        x25, x0
0x1ea60  bl         #0x498e0    ; _ZN6engineC1EPvS0_S0_ii
0x1ea64  mov        x0, x25
0x1ea68  str        x25, [x24, #8]
0x1ea6c  bl         #0x498f0    ; _ZN6engine5resetEv
0x1ea70  mov        w8, #1
0x1ea74  strh       w8, [x24, #0x10]
0x1ea78  strb       wzr, [x24, #0x12]
0x1ea7c  ldp        x20, x19, [sp, #0x30]
0x1ea80  ldp        x22, x21, [sp, #0x20]
0x1ea84  ldp        x24, x23, [sp, #0x10]
0x1ea88  mov        w0, #0x2710
0x1ea8c  ldp        x30, x25, [sp], #0x40
0x1ea90  ret        
0x1ea94  ldr        x0, [x0, #8]
0x1ea98  cbz        x0, #0x1eaa0
0x1ea9c  b          #0x498f0    ; _ZN6engine5resetEv
0x1eaa0  ret        
0x1eaa4  str        x30, [sp, #-0x20]!
0x1eaa8  stp        x20, x19, [sp, #0x10]
0x1eaac  ldrb       w8, [x0, #0x10]
0x1eab0  cbz        w8, #0x1eaf0
0x1eab4  ldrb       w8, [x0, #0x11]
0x1eab8  mov        x19, x0
0x1eabc  cbz        w8, #0x1eac8
0x1eac0  mov        w8, #1
0x1eac4  b          #0x1eaec
0x1eac8  ldr        x20, [x19, #8]
0x1eacc  cbz        x20, #0x1eae0
0x1ead0  mov        x0, x20
0x1ead4  bl         #0x498b0    ; _ZN6engineD1Ev
0x1ead8  mov        x0, x20
0x1eadc  bl         #0x49600    ; _ZdlPv
0x1eae0  mov        w8, wzr
0x1eae4  str        xzr, [x19, #8]
0x1eae8  strb       wzr, [x19, #0x10]
0x1eaec  strb       w8, [x19, #0x12]
0x1eaf0  ldp        x20, x19, [sp, #0x10]
0x1eaf4  ldr        x30, [sp], #0x20
0x1eaf8  ret        
0x1eafc  str        x30, [sp, #-0x10]!
0x1eb00  mov        w0, #0x18
0x1eb04  bl         #0x49500    ; _Znwm
0x1eb08  adrp       x8, #0x4f000
0x1eb0c  ldr        x8, [x8, #0x390]
0x1eb10  strh       wzr, [x0, #0x10]
0x1eb14  strb       wzr, [x0, #0x12]
0x1eb18  add        x8, x8, #0x10
0x1eb1c  str        x8, [x0]
0x1eb20  ldr        x30, [sp], #0x10
0x1eb24  ret        
0x1eb28  cbz        x0, #0x1eb38
0x1eb2c  ldr        x8, [x0]
0x1eb30  ldr        x1, [x8, #8]
0x1eb34  br         x1
0x1eb38  ret        
0x1eb3c  stp        x30, x21, [sp, #-0x20]!
0x1eb40  stp        x20, x19, [sp, #0x10]
0x1eb44  mov        x19, x0
0x1eb48  str        x1, [x0, #8]
0x1eb4c  stp        w2, wzr, [x0]
0x1eb50  add        w0, w2, w2, lsl #3
0x1eb54  mov        w1, #0x20
0x1eb58  mov        w20, w2
0x1eb5c  bl         #0x497c0    ; _Z9alignsizeii
0x1eb60  ldr        w8, [x19, #4]
0x1eb64  mov        w1, #0x20
0x1eb68  add        w8, w8, w0
0x1eb6c  mov        w0, w20
0x1eb70  str        w8, [x19, #4]
0x1eb74  bl         #0x497c0    ; _Z9alignsizeii
0x1eb78  ldr        w8, [x19, #4]
0x1eb7c  mul        w21, w20, w20
0x1eb80  mov        w1, #0x20
0x1eb84  add        w8, w8, w0
0x1eb88  add        w0, w21, w21, lsl #3
0x1eb8c  str        w8, [x19, #4]
0x1eb90  bl         #0x497c0    ; _Z9alignsizeii
0x1eb94  ldr        w8, [x19, #4]
0x1eb98  mov        w1, #0x20
0x1eb9c  add        w8, w8, w0
0x1eba0  mov        w0, w20
0x1eba4  str        w8, [x19, #4]
0x1eba8  bl         #0x497c0    ; _Z9alignsizeii
0x1ebac  ldr        w8, [x19, #4]
0x1ebb0  mov        w9, #0x13
0x1ebb4  mov        w1, #0x20
0x1ebb8  add        w8, w8, w0
0x1ebbc  mul        w0, w21, w9
0x1ebc0  str        w8, [x19, #4]
0x1ebc4  bl         #0x497c0    ; _Z9alignsizeii
0x1ebc8  ldr        w8, [x19, #4]
0x1ebcc  mov        w1, #0x20
0x1ebd0  add        w8, w8, w0
0x1ebd4  mov        w0, w20
0x1ebd8  str        w8, [x19, #4]
0x1ebdc  bl         #0x497c0    ; _Z9alignsizeii
0x1ebe0  ldr        w8, [x19, #4]
0x1ebe4  add        w8, w8, w0
0x1ebe8  str        w8, [x19, #4]
0x1ebec  ldp        x20, x19, [sp, #0x10]
0x1ebf0  ldp        x30, x21, [sp], #0x20
0x1ebf4  ret        
0x1ebf8  sub        sp, sp, #0x40
0x1ebfc  str        x30, [sp, #0x10]
0x1ec00  stp        x22, x21, [sp, #0x20]
0x1ec04  stp        x20, x19, [sp, #0x30]
0x1ec08  mov        x19, x0
0x1ec0c  str        w2, [x0]
0x1ec10  mov        x21, x0
0x1ec14  mov        w0, #0x48
0x1ec18  mov        w20, w2
0x1ec1c  mov        x22, x1
0x1ec20  str        wzr, [x21, #4]!
0x1ec24  bl         #0x49500    ; _Znwm
0x1ec28  mov        x1, x0
0x1ec2c  str        x0, [x19, #8]
0x1ec30  add        x2, x0, #8
0x1ec34  add        x3, x0, #0x10
0x1ec38  add        x4, x0, #0x14
0x1ec3c  add        x5, x0, #0x15
0x1ec40  mov        w8, #9
0x1ec44  mov        x0, x22
0x1ec48  mov        x6, x21
0x1ec4c  mov        w7, w20
0x1ec50  str        w8, [sp]
0x1ec54  bl         #0x49820    ; _Z13GerzzPreWsBs1PvPPhPPfS2_S0_PbPiii
0x1ec58  ldr        x8, [x19, #8]
0x1ec5c  mov        x0, x22
0x1ec60  mov        x6, x21
0x1ec64  mov        w7, w20
0x1ec68  add        x1, x8, #0x18
0x1ec6c  add        x2, x8, #0x20
0x1ec70  add        x3, x8, #0x28
0x1ec74  add        x4, x8, #0x2c
0x1ec78  add        x5, x8, #0x2d
0x1ec7c  add        w8, w20, w20, lsl #3
0x1ec80  str        w8, [sp]
0x1ec84  bl         #0x49820    ; _Z13GerzzPreWsBs1PvPPhPPfS2_S0_PbPiii
0x1ec88  ldr        x8, [x19, #8]
0x1ec8c  mov        w9, #0x13
0x1ec90  mov        x0, x22
0x1ec94  mov        x6, x21
0x1ec98  add        x1, x8, #0x30
0x1ec9c  add        x2, x8, #0x38
0x1eca0  add        x3, x8, #0x40
0x1eca4  add        x4, x8, #0x44
0x1eca8  add        x5, x8, #0x45
0x1ecac  mul        w8, w20, w9
0x1ecb0  mov        w7, w20
0x1ecb4  str        w8, [sp]
0x1ecb8  bl         #0x49820    ; _Z13GerzzPreWsBs1PvPPhPPfS2_S0_PbPiii
0x1ecbc  ldr        w9, [x19]
0x1ecc0  cmp        w9, #1
0x1ecc4  b.lt       #0x1ed00
0x1ecc8  scvtf      d0, w9
0x1eccc  fsqrt      d0, d0
0x1ecd0  mov        x8, xzr
0x1ecd4  fcvt       s0, d0
0x1ecd8  ldr        x9, [x19, #8]
0x1ecdc  lsl        x10, x8, #2
0x1ece0  add        x8, x8, #1
0x1ece4  ldr        x9, [x9, #0x38]
0x1ece8  ldr        s1, [x9, x10]
0x1ecec  fmul       s1, s1, s0
0x1ecf0  str        s1, [x9, x10]
0x1ecf4  ldrsw      x9, [x19]
0x1ecf8  cmp        x8, x9
0x1ecfc  b.lt       #0x1ecd8
0x1ed00  ldp        x20, x19, [sp, #0x30]
0x1ed04  ldp        x22, x21, [sp, #0x20]
0x1ed08  ldr        x30, [sp, #0x10]
0x1ed0c  add        sp, sp, #0x40
0x1ed10  ret        
0x1ed14  ldr        w0, [x0, #4]
0x1ed18  ret        
0x1ed1c  ldr        x0, [x0, #8]
0x1ed20  cbz        x0, #0x1ed28
0x1ed24  b          #0x49600    ; _ZdlPv
0x1ed28  ret        
0x1ed2c  str        x30, [sp, #-0x20]!
0x1ed30  stp        x20, x19, [sp, #0x10]
0x1ed34  ldr        x11, [x1]
0x1ed38  mov        x19, x1
0x1ed3c  mov        x20, x0
0x1ed40  ldr        w8, [x11, #0x18]
0x1ed44  cmp        w8, #1
0x1ed48  b.lt       #0x1edc4
0x1ed4c  adrp       x9, #0xf000
0x1ed50  adrp       x10, #0xf000
0x1ed54  mov        w8, wzr
0x1ed58  add        x9, x9, #0x3dc
0x1ed5c  add        x10, x10, #0x29c
0x1ed60  b          #0x1ed74
0x1ed64  ldr        w12, [x11, #0x18]
0x1ed68  add        w8, w8, #1
0x1ed6c  cmp        w8, w12
0x1ed70  b.ge       #0x1edc4
0x1ed74  ldr        w13, [x11, #0x1c]
0x1ed78  cmp        w13, #1
0x1ed7c  b.lt       #0x1ed64
0x1ed80  mov        x12, xzr
0x1ed84  ldr        x11, [x11, #8]
0x1ed88  madd       w13, w8, w13, w12
0x1ed8c  lsl        x14, x12, #2
0x1ed90  sbfiz      x13, x13, #2, #0x20
0x1ed94  ldr        s0, [x11, x13]
0x1ed98  ldr        s1, [x9, x14]
0x1ed9c  ldr        s2, [x10, x14]
0x1eda0  add        x12, x12, #1
0x1eda4  fsub       s0, s0, s1
0x1eda8  fmul       s0, s0, s2
0x1edac  str        s0, [x11, x13]
0x1edb0  ldr        x11, [x19]
0x1edb4  ldrsw      x13, [x11, #0x1c]
0x1edb8  cmp        x12, x13
0x1edbc  b.lt       #0x1ed84
0x1edc0  b          #0x1ed64
0x1edc4  mov        x0, x20
0x1edc8  mov        x1, x19
0x1edcc  bl         #0x49900    ; _ZN10EmbedLayer13conv0_forwardERP6TensorIfE
0x1edd0  mov        x0, x20
0x1edd4  mov        x1, x19
0x1edd8  bl         #0x49910    ; _ZN10EmbedLayer13conv1_forwardERP6TensorIfE
0x1eddc  mov        x0, x20
0x1ede0  mov        x1, x19
0x1ede4  ldp        x20, x19, [sp, #0x10]
0x1ede8  ldr        x30, [sp], #0x20
0x1edec  b          #0x49920    ; _ZN10EmbedLayer18linear_out_forwardERP6TensorIfE
0x1edf0  sub        sp, sp, #0x90
0x1edf4  stp        x29, x30, [sp, #0x30]
0x1edf8  stp        x28, x27, [sp, #0x40]
0x1edfc  stp        x26, x25, [sp, #0x50]
0x1ee00  stp        x24, x23, [sp, #0x60]
0x1ee04  stp        x22, x21, [sp, #0x70]
0x1ee08  stp        x20, x19, [sp, #0x80]
0x1ee0c  ldr        x8, [x1]
0x1ee10  mov        x20, x0
0x1ee14  mov        x19, x1
0x1ee18  ldp        w23, w22, [x8, #0x18]
0x1ee1c  sub        w8, w23, #1
0x1ee20  sub        w9, w22, #1
0x1ee24  cmp        w8, #0
0x1ee28  csel       w8, w23, w8, lt
0x1ee2c  cmp        w9, #0
0x1ee30  asr        w27, w8, #1
0x1ee34  csel       w8, w22, w9, lt
0x1ee38  asr        w28, w8, #1
0x1ee3c  smull      x8, w27, w28
0x1ee40  lsl        x8, x8, #3
0x1ee44  smaddl     x8, w27, w28, x8
0x1ee48  lsl        x0, x8, #2
0x1ee4c  bl         #0x494e0    ; malloc
0x1ee50  mov        x21, x0
0x1ee54  cbz        x0, #0x1eee8
0x1ee58  sub        w8, w23, #3
0x1ee5c  sub        w9, w22, #3
0x1ee60  orr        w10, w9, w8
0x1ee64  tbnz       w10, #0x1f, #0x1eee8
0x1ee68  mov        w10, wzr
0x1ee6c  mov        x13, xzr
0x1ee70  lsl        w11, w22, #1
0x1ee74  add        x12, x21, #0x10
0x1ee78  mov        w14, #1
0x1ee7c  sxtw       x0, w13
0x1ee80  mov        w15, wzr
0x1ee84  add        x16, x12, w13, sxtw #2
0x1ee88  mov        w17, w14
0x1ee8c  mov        x13, x0
0x1ee90  add        w1, w22, w17
0x1ee94  sub        w0, w17, #1
0x1ee98  add        w2, w17, #1
0x1ee9c  stp        w17, w1, [x16, #-4]
0x1eea0  add        w17, w11, w17
0x1eea4  add        w15, w15, #2
0x1eea8  sub        w3, w1, #1
0x1eeac  sub        w4, w17, #1
0x1eeb0  add        w5, w1, #1
0x1eeb4  add        w6, w17, #1
0x1eeb8  add        x13, x13, #9
0x1eebc  stp        w17, w2, [x16, #4]
0x1eec0  cmp        w15, w8
0x1eec4  stp        w0, w3, [x16, #-0x10]
0x1eec8  stur       w4, [x16, #-8]
0x1eecc  stp        w5, w6, [x16, #0xc]
0x1eed0  add        x16, x16, #0x24
0x1eed4  b.le       #0x1ee90
0x1eed8  add        w10, w10, #2
0x1eedc  cmp        w10, w9
0x1eee0  add        w14, w14, #2
0x1eee4  b.le       #0x1ee7c
0x1eee8  mul        w23, w28, w27
0x1eeec  add        w26, w23, w23, lsl #3
0x1eef0  sbfiz      x1, x26, #2, #0x20
0x1eef4  mov        w0, #0x40
0x1eef8  bl         #0x49560    ; _Z14aligned_mallocmm
0x1eefc  ldr        w8, [x20]
0x1ef00  mov        x22, x0
0x1ef04  mov        w0, #0x40
0x1ef08  mul        w29, w8, w23
0x1ef0c  sbfiz      x25, x29, #2, #0x20
0x1ef10  mov        x1, x25
0x1ef14  str        w8, [sp, #0x2c]
0x1ef18  bl         #0x49560    ; _Z14aligned_mallocmm
0x1ef1c  cmp        w23, #1
0x1ef20  mov        x24, x0
0x1ef24  b.lt       #0x1ef54
0x1ef28  mov        x8, xzr
0x1ef2c  sxtw       x9, w26
0x1ef30  ldr        x10, [x19]
0x1ef34  lsl        x11, x8, #2
0x1ef38  ldrsw      x12, [x21, x11]
0x1ef3c  add        x8, x8, #1
0x1ef40  ldr        x10, [x10, #8]
0x1ef44  cmp        x8, x9
0x1ef48  ldr        s0, [x10, x12, lsl #2]
0x1ef4c  str        s0, [x22, x11]
0x1ef50  b.lt       #0x1ef30
0x1ef54  ldr        x26, [x19]
0x1ef58  cbz        x26, #0x1ef74
0x1ef5c  ldr        x0, [x26, #8]
0x1ef60  cbz        x0, #0x1ef6c
0x1ef64  bl         #0x49630    ; _Z12aligned_freePv
0x1ef68  str        xzr, [x26, #8]
0x1ef6c  mov        x0, x26
0x1ef70  bl         #0x49600    ; _ZdlPv
0x1ef74  mov        w0, #0x28
0x1ef78  bl         #0x49500    ; _Znwm
0x1ef7c  ldr        w8, [x20]
0x1ef80  mov        w9, #1
0x1ef84  mov        x26, x0
0x1ef88  stp        w28, w27, [x0, #0x18]
0x1ef8c  stp        w9, w8, [x0, #0x10]
0x1ef90  mul        w8, w23, w8
0x1ef94  str        w8, [x0, #0x20]
0x1ef98  str        w8, [x0]
0x1ef9c  sbfiz      x1, x8, #2, #0x20
0x1efa0  mov        w0, #0x40
0x1efa4  bl         #0x49560    ; _Z14aligned_mallocmm
0x1efa8  str        x0, [x26, #8]
0x1efac  mov        x0, x24
0x1efb0  mov        w1, wzr
0x1efb4  mov        x2, x25
0x1efb8  str        x26, [x19]
0x1efbc  bl         #0x49680    ; memset
0x1efc0  ldr        x8, [x20, #8]
0x1efc4  ldr        w5, [x20]
0x1efc8  mov        w6, #9
0x1efcc  mov        w7, #9
0x1efd0  ldp        x2, x0, [x8]
0x1efd4  ldr        s0, [x8, #0x10]
0x1efd8  ldrb       w9, [x8, #0x14]
0x1efdc  ldrb       w8, [x8, #0x15]
0x1efe0  mov        x1, x22
0x1efe4  mov        x3, x24
0x1efe8  mov        w4, w23
0x1efec  strb       w8, [sp, #0x18]
0x1eff0  strb       w9, [sp, #0x10]
0x1eff4  str        w5, [sp, #8]
0x1eff8  str        w5, [sp]
0x1effc  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x1f000  cmp        w29, #1
0x1f004  b.lt       #0x1f058
0x1f008  ldr        w9, [sp, #0x2c]
0x1f00c  mov        x8, xzr
0x1f010  fmov       s0, wzr
0x1f014  mul        w9, w9, w28
0x1f018  mul        w9, w9, w27
0x1f01c  ldr        x11, [x19]
0x1f020  ldr        w10, [x20]
0x1f024  ldr        s1, [x24, x8, lsl #2]
0x1f028  ldr        x11, [x11, #8]
0x1f02c  sdiv       w12, w8, w10
0x1f030  msub       w10, w12, w10, w8
0x1f034  add        x8, x8, #1
0x1f038  fmaxnm     s1, s1, s0
0x1f03c  madd       w10, w10, w23, w12
0x1f040  cmp        x9, x8
0x1f044  str        s1, [x11, w10, sxtw #2]
0x1f048  b.ne       #0x1f01c
0x1f04c  mov        x0, x21
0x1f050  bl         #0x494f0    ; free
0x1f054  b          #0x1f064
0x1f058  mov        x0, x21
0x1f05c  bl         #0x494f0    ; free
0x1f060  cbz        x24, #0x1f06c
0x1f064  mov        x0, x24
0x1f068  bl         #0x49630    ; _Z12aligned_freePv
0x1f06c  cbz        x22, #0x1f094
0x1f070  mov        x0, x22
0x1f074  ldp        x20, x19, [sp, #0x80]
0x1f078  ldp        x22, x21, [sp, #0x70]
0x1f07c  ldp        x24, x23, [sp, #0x60]
0x1f080  ldp        x26, x25, [sp, #0x50]
0x1f084  ldp        x28, x27, [sp, #0x40]
0x1f088  ldp        x29, x30, [sp, #0x30]
0x1f08c  add        sp, sp, #0x90
0x1f090  b          #0x49630    ; _Z12aligned_freePv
0x1f094  ldp        x20, x19, [sp, #0x80]
0x1f098  ldp        x22, x21, [sp, #0x70]
0x1f09c  ldp        x24, x23, [sp, #0x60]
0x1f0a0  ldp        x26, x25, [sp, #0x50]
0x1f0a4  ldp        x28, x27, [sp, #0x40]
0x1f0a8  ldp        x29, x30, [sp, #0x30]
0x1f0ac  add        sp, sp, #0x90
0x1f0b0  ret        
0x1f0b4  sub        sp, sp, #0x90
0x1f0b8  stp        x29, x30, [sp, #0x30]
0x1f0bc  stp        x28, x27, [sp, #0x40]
0x1f0c0  stp        x26, x25, [sp, #0x50]
0x1f0c4  stp        x24, x23, [sp, #0x60]
0x1f0c8  stp        x22, x21, [sp, #0x70]
0x1f0cc  stp        x20, x19, [sp, #0x80]
0x1f0d0  ldr        x8, [x1]
0x1f0d4  mov        x20, x0
0x1f0d8  mov        x19, x1
0x1f0dc  ldp        w28, w29, [x8, #0x18]
0x1f0e0  sub        w8, w28, #1
0x1f0e4  sub        w9, w29, #1
0x1f0e8  cmp        w8, #0
0x1f0ec  csel       w8, w28, w8, lt
0x1f0f0  cmp        w9, #0
0x1f0f4  asr        w26, w8, #1
0x1f0f8  csel       w8, w29, w9, lt
0x1f0fc  asr        w27, w8, #1
0x1f100  smull      x8, w26, w27
0x1f104  lsl        x8, x8, #3
0x1f108  smaddl     x8, w26, w27, x8
0x1f10c  lsl        x0, x8, #2
0x1f110  bl         #0x494e0    ; malloc
0x1f114  mov        x21, x0
0x1f118  cbz        x0, #0x1f1c4
0x1f11c  sub        w8, w28, #3
0x1f120  sub        w9, w29, #3
0x1f124  orr        w10, w9, w8
0x1f128  tbnz       w10, #0x1f, #0x1f1c4
0x1f12c  adrp       x13, #0xe000
0x1f130  ldr        d0, [x13, #0x540]
0x1f134  lsl        w13, w29, #1
0x1f138  mov        w10, wzr
0x1f13c  mov        w11, wzr
0x1f140  mov        x12, xzr
0x1f144  add        x14, x21, #0x10
0x1f148  mov        w15, w29
0x1f14c  mov        w16, w13
0x1f150  sxtw       x1, w12
0x1f154  mov        w17, wzr
0x1f158  add        x0, x14, w12, sxtw #2
0x1f15c  mov        x12, x1
0x1f160  add        w2, w15, w17
0x1f164  dup        v1.2s, w2
0x1f168  add        w1, w10, w17
0x1f16c  add        w3, w16, w17
0x1f170  add        v1.2s, v1.2s, v0.2s
0x1f174  str        w3, [x0, #8]
0x1f178  str        d1, [x0]
0x1f17c  dup        v1.2s, w3
0x1f180  add        w3, w1, #1
0x1f184  stp        w1, w3, [x0, #-0x10]
0x1f188  add        w17, w17, #2
0x1f18c  add        w1, w1, #2
0x1f190  add        v1.2s, v1.2s, v0.2s
0x1f194  add        x12, x12, #9
0x1f198  cmp        w17, w9
0x1f19c  stp        w1, w2, [x0, #-8]
0x1f1a0  stur       d1, [x0, #0xc]
0x1f1a4  add        x0, x0, #0x24
0x1f1a8  b.le       #0x1f160
0x1f1ac  add        w11, w11, #2
0x1f1b0  add        w10, w10, w13
0x1f1b4  add        w16, w16, w13
0x1f1b8  cmp        w11, w8
0x1f1bc  add        w15, w15, w13
0x1f1c0  b.le       #0x1f150
0x1f1c4  ldr        w8, [x20]
0x1f1c8  mul        w24, w27, w26
0x1f1cc  mov        w0, #0x40
0x1f1d0  mul        w8, w24, w8
0x1f1d4  add        w8, w8, w8, lsl #3
0x1f1d8  sbfiz      x1, x8, #2, #0x20
0x1f1dc  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f1e0  ldr        w8, [x20]
0x1f1e4  mov        x22, x0
0x1f1e8  mov        w0, #0x40
0x1f1ec  str        w8, [sp, #0x24]
0x1f1f0  mul        w8, w8, w24
0x1f1f4  sbfiz      x25, x8, #2, #0x20
0x1f1f8  mov        x1, x25
0x1f1fc  str        x8, [sp, #0x28]
0x1f200  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f204  cmp        w24, #1
0x1f208  mov        x23, x0
0x1f20c  b.lt       #0x1f2d4
0x1f210  ldr        w4, [x20]
0x1f214  mov        x8, xzr
0x1f218  mov        w9, wzr
0x1f21c  mul        w10, w29, w28
0x1f220  mov        w11, w24
0x1f224  b          #0x1f234
0x1f228  add        x8, x8, #1
0x1f22c  cmp        x8, x11
0x1f230  b.eq       #0x1f2d4
0x1f234  cmp        w4, #1
0x1f238  b.lt       #0x1f228
0x1f23c  add        w13, w8, w8, lsl #3
0x1f240  add        x3, x21, w13, uxtw #2
0x1f244  ldpsw      x13, x14, [x3]
0x1f248  ldpsw      x15, x16, [x3, #8]
0x1f24c  ldpsw      x17, x0, [x3, #0x10]
0x1f250  ldpsw      x1, x2, [x3, #0x18]
0x1f254  ldrsw      x3, [x3, #0x20]
0x1f258  mov        w12, wzr
0x1f25c  mov        x5, xzr
0x1f260  ldr        x4, [x19]
0x1f264  add        x6, x22, w9, sxtw #2
0x1f268  add        x5, x5, #1
0x1f26c  add        w9, w9, #9
0x1f270  ldr        x4, [x4, #8]
0x1f274  add        x4, x4, w12, sxtw #2
0x1f278  ldr        s0, [x4, x13, lsl #2]
0x1f27c  add        w12, w12, w10
0x1f280  str        s0, [x6]
0x1f284  ldr        s0, [x4, x14, lsl #2]
0x1f288  str        s0, [x6, #4]
0x1f28c  ldr        s0, [x4, x15, lsl #2]
0x1f290  str        s0, [x6, #8]
0x1f294  ldr        s0, [x4, x16, lsl #2]
0x1f298  str        s0, [x6, #0xc]
0x1f29c  ldr        s0, [x4, x17, lsl #2]
0x1f2a0  str        s0, [x6, #0x10]
0x1f2a4  ldr        s0, [x4, x0, lsl #2]
0x1f2a8  str        s0, [x6, #0x14]
0x1f2ac  ldr        s0, [x4, x1, lsl #2]
0x1f2b0  str        s0, [x6, #0x18]
0x1f2b4  ldr        s0, [x4, x2, lsl #2]
0x1f2b8  str        s0, [x6, #0x1c]
0x1f2bc  ldr        s0, [x4, x3, lsl #2]
0x1f2c0  str        s0, [x6, #0x20]
0x1f2c4  ldrsw      x4, [x20]
0x1f2c8  cmp        x5, x4
0x1f2cc  b.lt       #0x1f260
0x1f2d0  b          #0x1f228
0x1f2d4  mov        x0, x23
0x1f2d8  mov        w1, wzr
0x1f2dc  mov        x2, x25
0x1f2e0  bl         #0x49680    ; memset
0x1f2e4  ldr        x8, [x20, #8]
0x1f2e8  ldr        w5, [x20]
0x1f2ec  mov        x1, x22
0x1f2f0  mov        x3, x23
0x1f2f4  ldp        x2, x0, [x8, #0x18]
0x1f2f8  ldr        s0, [x8, #0x28]
0x1f2fc  ldrb       w9, [x8, #0x2c]
0x1f300  ldrb       w8, [x8, #0x2d]
0x1f304  add        w6, w5, w5, lsl #3
0x1f308  mov        w4, w24
0x1f30c  mov        w7, w6
0x1f310  strb       w8, [sp, #0x18]
0x1f314  strb       w9, [sp, #0x10]
0x1f318  str        w5, [sp, #8]
0x1f31c  str        w5, [sp]
0x1f320  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x1f324  ldr        x25, [x19]
0x1f328  cbz        x25, #0x1f344
0x1f32c  ldr        x0, [x25, #8]
0x1f330  cbz        x0, #0x1f33c
0x1f334  bl         #0x49630    ; _Z12aligned_freePv
0x1f338  str        xzr, [x25, #8]
0x1f33c  mov        x0, x25
0x1f340  bl         #0x49600    ; _ZdlPv
0x1f344  mov        w0, #0x28
0x1f348  bl         #0x49500    ; _Znwm
0x1f34c  ldr        w8, [x20]
0x1f350  mov        w9, #1
0x1f354  mov        x25, x0
0x1f358  stp        w9, w27, [x0, #0x10]
0x1f35c  stp        w8, w26, [x0, #0x18]
0x1f360  mul        w8, w24, w8
0x1f364  str        w8, [x0, #0x20]
0x1f368  str        w8, [x0]
0x1f36c  sbfiz      x1, x8, #2, #0x20
0x1f370  mov        w0, #0x40
0x1f374  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f378  ldr        x8, [sp, #0x28]
0x1f37c  str        x0, [x25, #8]
0x1f380  str        x25, [x19]
0x1f384  cmp        w8, #1
0x1f388  b.lt       #0x1f3f8
0x1f38c  ldr        w9, [sp, #0x24]
0x1f390  mov        x8, xzr
0x1f394  fmov       s0, wzr
0x1f398  mul        w9, w9, w27
0x1f39c  mul        w9, w9, w26
0x1f3a0  sub        x9, x9, #1
0x1f3a4  ldr        w10, [x20]
0x1f3a8  ldr        s1, [x23, x8, lsl #2]
0x1f3ac  ldr        x11, [x25, #8]
0x1f3b0  cmp        x9, x8
0x1f3b4  mul        w12, w10, w27
0x1f3b8  sdiv       w14, w8, w12
0x1f3bc  sdiv       w13, w8, w10
0x1f3c0  msub       w12, w14, w12, w8
0x1f3c4  msub       w13, w13, w10, w8
0x1f3c8  sdiv       w12, w12, w10
0x1f3cc  madd       w10, w12, w10, w13
0x1f3d0  fmaxnm     s1, s1, s0
0x1f3d4  madd       w10, w10, w26, w14
0x1f3d8  str        s1, [x11, w10, sxtw #2]
0x1f3dc  b.eq       #0x1f3ec
0x1f3e0  ldr        x25, [x19]
0x1f3e4  add        x8, x8, #1
0x1f3e8  b          #0x1f3a4
0x1f3ec  mov        x0, x21
0x1f3f0  bl         #0x494f0    ; free
0x1f3f4  b          #0x1f404
0x1f3f8  mov        x0, x21
0x1f3fc  bl         #0x494f0    ; free
0x1f400  cbz        x23, #0x1f40c
0x1f404  mov        x0, x23
0x1f408  bl         #0x49630    ; _Z12aligned_freePv
0x1f40c  cbz        x22, #0x1f434
0x1f410  mov        x0, x22
0x1f414  ldp        x20, x19, [sp, #0x80]
0x1f418  ldp        x22, x21, [sp, #0x70]
0x1f41c  ldp        x24, x23, [sp, #0x60]
0x1f420  ldp        x26, x25, [sp, #0x50]
0x1f424  ldp        x28, x27, [sp, #0x40]
0x1f428  ldp        x29, x30, [sp, #0x30]
0x1f42c  add        sp, sp, #0x90
0x1f430  b          #0x49630    ; _Z12aligned_freePv
0x1f434  ldp        x20, x19, [sp, #0x80]
0x1f438  ldp        x22, x21, [sp, #0x70]
0x1f43c  ldp        x24, x23, [sp, #0x60]
0x1f440  ldp        x26, x25, [sp, #0x50]
0x1f444  ldp        x28, x27, [sp, #0x40]
0x1f448  ldp        x29, x30, [sp, #0x30]
0x1f44c  add        sp, sp, #0x90
0x1f450  ret        
0x1f454  sub        sp, sp, #0x70
0x1f458  stp        d9, d8, [sp, #0x20]
0x1f45c  str        x30, [sp, #0x30]
0x1f460  stp        x24, x23, [sp, #0x40]
0x1f464  stp        x22, x21, [sp, #0x50]
0x1f468  stp        x20, x19, [sp, #0x60]
0x1f46c  ldr        x8, [x1]
0x1f470  ldr        w23, [x0]
0x1f474  mov        x22, x0
0x1f478  mov        w0, #0x28
0x1f47c  ldr        w21, [x8, #0x14]
0x1f480  ldr        w24, [x8, #0x1c]
0x1f484  scvtf      d0, w23
0x1f488  fsqrt      d0, d0
0x1f48c  mov        x19, x1
0x1f490  fcvt       s8, d0
0x1f494  bl         #0x49500    ; _Znwm
0x1f498  lsl        w8, w21, #2
0x1f49c  movi       v9.2s, #1
0x1f4a0  stp        w8, w23, [x0, #0x18]
0x1f4a4  mul        w23, w23, w8
0x1f4a8  mov        x20, x0
0x1f4ac  str        d9, [x0, #0x10]
0x1f4b0  str        w23, [x0, #0x20]
0x1f4b4  str        w23, [x0]
0x1f4b8  sbfiz      x1, x23, #2, #0x20
0x1f4bc  mov        w0, #0x40
0x1f4c0  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f4c4  str        x0, [x20, #8]
0x1f4c8  ldr        w8, [x22]
0x1f4cc  str        d9, [x20, #0x10]
0x1f4d0  mul        w2, w8, w21
0x1f4d4  cmp        w23, w2
0x1f4d8  stp        w21, w8, [x20, #0x18]
0x1f4dc  str        w2, [x20, #0x20]
0x1f4e0  b.ge       #0x1f4fc
0x1f4e4  adrp       x0, #0xe000
0x1f4e8  add        x0, x0, #0xed3
0x1f4ec  mov        w1, w23
0x1f4f0  bl         #0x496c0    ; printf
0x1f4f4  ldr        x0, [x20, #8]
0x1f4f8  ldr        w2, [x20, #0x20]
0x1f4fc  sbfiz      x2, x2, #2, #0x20
0x1f500  mov        w1, wzr
0x1f504  bl         #0x49680    ; memset
0x1f508  ldr        x9, [x22, #8]
0x1f50c  ldr        x8, [x19]
0x1f510  ldr        w5, [x22]
0x1f514  ldr        x3, [x20, #8]
0x1f518  ldr        s0, [x9, #0x40]
0x1f51c  ldr        x1, [x8, #8]
0x1f520  ldp        x2, x0, [x9, #0x30]
0x1f524  ldrb       w8, [x9, #0x44]
0x1f528  ldrb       w9, [x9, #0x45]
0x1f52c  mul        w6, w5, w24
0x1f530  fmul       s0, s0, s8
0x1f534  mov        w4, w21
0x1f538  mov        w7, w6
0x1f53c  strb       w9, [sp, #0x18]
0x1f540  strb       w8, [sp, #0x10]
0x1f544  str        w5, [sp, #8]
0x1f548  str        w5, [sp]
0x1f54c  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x1f550  ldr        x21, [x19]
0x1f554  cbz        x21, #0x1f570
0x1f558  ldr        x0, [x21, #8]
0x1f55c  cbz        x0, #0x1f568
0x1f560  bl         #0x49630    ; _Z12aligned_freePv
0x1f564  str        xzr, [x21, #8]
0x1f568  mov        x0, x21
0x1f56c  bl         #0x49600    ; _ZdlPv
0x1f570  str        x20, [x19]
0x1f574  ldp        x20, x19, [sp, #0x60]
0x1f578  ldp        x22, x21, [sp, #0x50]
0x1f57c  ldp        x24, x23, [sp, #0x40]
0x1f580  ldr        x30, [sp, #0x30]
0x1f584  ldp        d9, d8, [sp, #0x20]
0x1f588  add        sp, sp, #0x70
0x1f58c  ret        
0x1f590  str        x30, [sp, #-0x40]!
0x1f594  stp        x24, x23, [sp, #0x10]
0x1f598  stp        x22, x21, [sp, #0x20]
0x1f59c  stp        x20, x19, [sp, #0x30]
0x1f5a0  sub        w23, w2, w4
0x1f5a4  ldr        x22, [sp, #0x40]
0x1f5a8  add        w8, w23, w5
0x1f5ac  sub        w24, w3, w4
0x1f5b0  sdiv       w8, w8, w5
0x1f5b4  str        w8, [x6]
0x1f5b8  add        w8, w24, w5
0x1f5bc  mov        w19, w5
0x1f5c0  mov        w20, w3
0x1f5c4  mov        w21, w1
0x1f5c8  sdiv       w8, w8, w5
0x1f5cc  str        w8, [x7]
0x1f5d0  cbz        w1, #0x1f5e4
0x1f5d4  ldr        w9, [x6]
0x1f5d8  str        w8, [x6]
0x1f5dc  mov        w8, w9
0x1f5e0  str        w9, [x7]
0x1f5e4  ldrsw      x9, [x6]
0x1f5e8  sxtw       x8, w8
0x1f5ec  mul        x8, x9, x8
0x1f5f0  add        x8, x8, x8, lsl #3
0x1f5f4  lsl        x0, x8, #2
0x1f5f8  bl         #0x494e0    ; malloc
0x1f5fc  str        x0, [x22]
0x1f600  cbz        x0, #0x1f7c0
0x1f604  cbz        w21, #0x1f6e4
0x1f608  orr        w8, w24, w23
0x1f60c  tbnz       w8, #0x1f, #0x1f7c0
0x1f610  mov        w8, wzr
0x1f614  mov        x9, xzr
0x1f618  mul        w10, w19, w20
0x1f61c  lsl        w11, w20, #1
0x1f620  mov        w12, #2
0x1f624  mov        w13, wzr
0x1f628  sxtw       x9, w9
0x1f62c  mov        w14, w12
0x1f630  ldr        x15, [x22]
0x1f634  sub        w16, w14, #2
0x1f638  lsl        x17, x9, #2
0x1f63c  add        w13, w13, w19
0x1f640  str        w16, [x15, x17]
0x1f644  ldr        x15, [x22]
0x1f648  add        w16, w20, w14
0x1f64c  sub        w0, w16, #2
0x1f650  add        x9, x9, #9
0x1f654  add        x15, x15, x17
0x1f658  str        w0, [x15, #4]
0x1f65c  ldr        x15, [x22]
0x1f660  add        w0, w11, w14
0x1f664  sub        w1, w0, #2
0x1f668  cmp        w13, w23
0x1f66c  add        x15, x15, x17
0x1f670  str        w1, [x15, #8]
0x1f674  ldr        x15, [x22]
0x1f678  sub        w1, w14, #1
0x1f67c  add        x15, x15, x17
0x1f680  str        w1, [x15, #0xc]
0x1f684  ldr        x15, [x22]
0x1f688  sub        w1, w16, #1
0x1f68c  add        x15, x15, x17
0x1f690  str        w1, [x15, #0x10]
0x1f694  ldr        x15, [x22]
0x1f698  sub        w1, w0, #1
0x1f69c  add        x15, x15, x17
0x1f6a0  str        w1, [x15, #0x14]
0x1f6a4  ldr        x15, [x22]
0x1f6a8  add        x15, x15, x17
0x1f6ac  str        w14, [x15, #0x18]
0x1f6b0  ldr        x15, [x22]
0x1f6b4  add        w14, w14, w10
0x1f6b8  add        x15, x15, x17
0x1f6bc  str        w16, [x15, #0x1c]
0x1f6c0  ldr        x15, [x22]
0x1f6c4  add        x15, x15, x17
0x1f6c8  str        w0, [x15, #0x20]
0x1f6cc  b.le       #0x1f630
0x1f6d0  add        w8, w8, w19
0x1f6d4  cmp        w8, w24
0x1f6d8  add        w12, w12, w19
0x1f6dc  b.le       #0x1f624
0x1f6e0  b          #0x1f7c0
0x1f6e4  orr        w8, w23, w24
0x1f6e8  tbnz       w8, #0x1f, #0x1f7c0
0x1f6ec  mov        w8, wzr
0x1f6f0  mov        w9, wzr
0x1f6f4  mov        x10, xzr
0x1f6f8  mul        w11, w19, w20
0x1f6fc  lsl        w12, w20, #1
0x1f700  mov        w13, wzr
0x1f704  sxtw       x10, w10
0x1f708  ldr        x14, [x22]
0x1f70c  add        w15, w8, w13
0x1f710  lsl        x16, x10, #2
0x1f714  add        w17, w15, #1
0x1f718  str        w15, [x14, x16]
0x1f71c  ldr        x14, [x22]
0x1f720  add        w15, w15, #2
0x1f724  add        x10, x10, #9
0x1f728  add        x14, x14, x16
0x1f72c  str        w17, [x14, #4]
0x1f730  ldr        x14, [x22]
0x1f734  add        x14, x14, x16
0x1f738  str        w15, [x14, #8]
0x1f73c  ldr        x14, [x22]
0x1f740  add        w15, w20, w13
0x1f744  add        w17, w15, #1
0x1f748  add        x14, x14, x16
0x1f74c  str        w15, [x14, #0xc]
0x1f750  ldr        x14, [x22]
0x1f754  add        w15, w15, #2
0x1f758  add        x14, x14, x16
0x1f75c  str        w17, [x14, #0x10]
0x1f760  ldr        x14, [x22]
0x1f764  add        x14, x14, x16
0x1f768  str        w15, [x14, #0x14]
0x1f76c  ldr        x14, [x22]
0x1f770  add        w15, w12, w13
0x1f774  add        w17, w15, #1
0x1f778  add        w13, w13, w19
0x1f77c  add        x14, x14, x16
0x1f780  str        w15, [x14, #0x18]
0x1f784  ldr        x14, [x22]
0x1f788  add        w15, w15, #2
0x1f78c  cmp        w13, w24
0x1f790  add        x14, x14, x16
0x1f794  str        w17, [x14, #0x1c]
0x1f798  ldr        x14, [x22]
0x1f79c  add        x14, x14, x16
0x1f7a0  str        w15, [x14, #0x20]
0x1f7a4  b.le       #0x1f708
0x1f7a8  add        w9, w9, w19
0x1f7ac  add        w8, w8, w11
0x1f7b0  add        w20, w20, w11
0x1f7b4  cmp        w9, w23
0x1f7b8  add        w12, w12, w11
0x1f7bc  b.le       #0x1f700
0x1f7c0  ldp        x20, x19, [sp, #0x30]
0x1f7c4  ldp        x22, x21, [sp, #0x20]
0x1f7c8  ldp        x24, x23, [sp, #0x10]
0x1f7cc  ldr        x30, [sp], #0x40
0x1f7d0  ret        
0x1f7d4  sub        sp, sp, #0x70
0x1f7d8  str        d8, [sp, #0x20]
0x1f7dc  str        x30, [sp, #0x28]
0x1f7e0  stp        x26, x25, [sp, #0x30]
0x1f7e4  stp        x24, x23, [sp, #0x40]
0x1f7e8  stp        x22, x21, [sp, #0x50]
0x1f7ec  stp        x20, x19, [sp, #0x60]
0x1f7f0  ldrsw      x9, [x1, #0x20]
0x1f7f4  mov        x26, x0
0x1f7f8  ldr        w8, [x0, #0x20]
0x1f7fc  ldr        x0, [x1, #8]
0x1f800  mov        x20, x2
0x1f804  mov        x25, x1
0x1f808  lsl        x2, x9, #2
0x1f80c  mov        w1, wzr
0x1f810  mov        w23, w6
0x1f814  mov        w22, w5
0x1f818  mov        v8.16b, v0.16b
0x1f81c  mov        w19, w4
0x1f820  mov        x24, x3
0x1f824  sdiv       w21, w8, w4
0x1f828  bl         #0x49680    ; memset
0x1f82c  ldr        x1, [x26, #8]
0x1f830  ldr        x3, [x25, #8]
0x1f834  and        w8, w23, #1
0x1f838  cbz        x24, #0x1f854
0x1f83c  mov        x0, x24
0x1f840  strb       w22, [sp, #0x10]
0x1f844  str        w19, [sp, #8]
0x1f848  strb       w8, [sp, #0x18]
0x1f84c  str        w19, [sp]
0x1f850  b          #0x1f868
0x1f854  strb       w22, [sp, #0x10]
0x1f858  str        w19, [sp, #8]
0x1f85c  strb       w8, [sp, #0x18]
0x1f860  str        w19, [sp]
0x1f864  mov        x0, xzr
0x1f868  mov        x2, x20
0x1f86c  mov        w4, w21
0x1f870  mov        w5, w19
0x1f874  mov        w6, w19
0x1f878  mov        w7, w19
0x1f87c  mov        v0.16b, v8.16b
0x1f880  bl         #0x49860    ; _Z10Gerzzgemm1PfS_PhPiiiiiiifhb
0x1f884  ldp        x20, x19, [sp, #0x60]
0x1f888  ldp        x22, x21, [sp, #0x50]
0x1f88c  ldp        x24, x23, [sp, #0x40]
0x1f890  ldp        x26, x25, [sp, #0x30]
0x1f894  ldr        x30, [sp, #0x28]
0x1f898  ldr        d8, [sp, #0x20]
0x1f89c  add        sp, sp, #0x70
0x1f8a0  ret        
0x1f8a4  sub        sp, sp, #0x80
0x1f8a8  stp        d9, d8, [sp, #0x20]
0x1f8ac  str        x30, [sp, #0x30]
0x1f8b0  stp        x26, x25, [sp, #0x40]
0x1f8b4  stp        x24, x23, [sp, #0x50]
0x1f8b8  stp        x22, x21, [sp, #0x60]
0x1f8bc  stp        x20, x19, [sp, #0x70]
0x1f8c0  mov        x19, x0
0x1f8c4  str        x1, [x0, #0x18]
0x1f8c8  stp        w3, w4, [x0]
0x1f8cc  str        w5, [x0, #8]
0x1f8d0  mov        w0, #0x28
0x1f8d4  mov        w22, w5
0x1f8d8  mov        x21, x2
0x1f8dc  mov        x20, x1
0x1f8e0  bl         #0x49500    ; _Znwm
0x1f8e4  lsl        w8, w22, #1
0x1f8e8  movi       v8.2s, #1
0x1f8ec  stp        w8, w22, [x0, #0x18]
0x1f8f0  mul        w22, w8, w22
0x1f8f4  mov        x23, x0
0x1f8f8  str        d8, [x0, #0x10]
0x1f8fc  str        w22, [x0, #0x20]
0x1f900  str        w22, [x0]
0x1f904  sbfiz      x1, x22, #2, #0x20
0x1f908  mov        w0, #0x40
0x1f90c  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f910  str        x0, [x23, #8]
0x1f914  adrp       x8, #0xe000
0x1f918  ldr        d9, [x8, #0x5e0]
0x1f91c  ldr        d0, [x19]
0x1f920  str        x23, [x19, #0x30]
0x1f924  str        wzr, [x23, #0x20]
0x1f928  stp        d9, d0, [x23, #0x10]
0x1f92c  tbz        w22, #0x1f, #0x1f944
0x1f930  adrp       x0, #0xe000
0x1f934  add        x0, x0, #0xed3
0x1f938  mov        w1, w22
0x1f93c  mov        w2, wzr
0x1f940  bl         #0x496c0    ; printf
0x1f944  mov        w0, #0x28
0x1f948  bl         #0x49500    ; _Znwm
0x1f94c  ldr        w8, [x19, #8]
0x1f950  mov        x23, x0
0x1f954  str        d8, [x0, #0x10]
0x1f958  lsl        w9, w8, #1
0x1f95c  mul        w22, w9, w8
0x1f960  stp        w9, w8, [x0, #0x18]
0x1f964  str        w22, [x0, #0x20]
0x1f968  str        w22, [x0]
0x1f96c  sbfiz      x1, x22, #2, #0x20
0x1f970  mov        w0, #0x40
0x1f974  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f978  str        x0, [x23, #8]
0x1f97c  ldr        d0, [x19]
0x1f980  str        x23, [x19, #0x38]
0x1f984  str        wzr, [x23, #0x20]
0x1f988  stp        d9, d0, [x23, #0x10]
0x1f98c  tbz        w22, #0x1f, #0x1f9a4
0x1f990  adrp       x0, #0xe000
0x1f994  add        x0, x0, #0xed3
0x1f998  mov        w1, w22
0x1f99c  mov        w2, wzr
0x1f9a0  bl         #0x496c0    ; printf
0x1f9a4  add        x2, sp, #0x38
0x1f9a8  mov        w1, #0x320
0x1f9ac  mov        x0, x21
0x1f9b0  mov        w23, #0x320
0x1f9b4  bl         #0x49930    ; _ZN16PositionEncoding5fetchEiRP6TensorIfE
0x1f9b8  mov        w0, #0x28
0x1f9bc  str        wzr, [x19, #0x10]
0x1f9c0  bl         #0x49500    ; _Znwm
0x1f9c4  ldr        w8, [x19]
0x1f9c8  adrp       x9, #0xe000
0x1f9cc  ldr        d0, [x9, #0x5c8]
0x1f9d0  mov        w10, #0x500
0x1f9d4  stp        w8, w10, [x0, #0x18]
0x1f9d8  add        w8, w8, w8, lsl #2
0x1f9dc  lsl        w8, w8, #0xc
0x1f9e0  mov        x21, x0
0x1f9e4  str        d0, [x0, #0x10]
0x1f9e8  str        w8, [x0, #0x20]
0x1f9ec  str        w8, [x0]
0x1f9f0  sbfiz      x1, x8, #2, #0x20
0x1f9f4  mov        w0, #0x40
0x1f9f8  bl         #0x49560    ; _Z14aligned_mallocmm
0x1f9fc  str        x0, [x21, #8]
0x1fa00  mov        w0, #0x28
0x1fa04  str        x21, [x19, #0x40]
0x1fa08  bl         #0x49500    ; _Znwm
0x1fa0c  ldrsw      x8, [x19, #8]
0x1fa10  movi       v8.2s, #1
0x1fa14  mov        w22, #0x10
0x1fa18  mov        x21, x0
0x1fa1c  lsl        w9, w8, #4
0x1fa20  str        d8, [x0, #0x10]
0x1fa24  stp        w22, w8, [x0, #0x18]
0x1fa28  str        w9, [x0, #0x20]
0x1fa2c  str        w9, [x0]
0x1fa30  lsl        x1, x8, #6
0x1fa34  mov        w0, #0x40
0x1fa38  bl         #0x49560    ; _Z14aligned_mallocmm
0x1fa3c  str        x0, [x21, #8]
0x1fa40  mov        w0, #0x28
0x1fa44  str        x21, [x19, #0x48]
0x1fa48  bl         #0x49500    ; _Znwm
0x1fa4c  ldrsw      x8, [x19, #8]
0x1fa50  mov        x21, x0
0x1fa54  str        d8, [x0, #0x10]
0x1fa58  lsl        w9, w8, #4
0x1fa5c  stp        w22, w8, [x0, #0x18]
0x1fa60  str        w9, [x0, #0x20]
0x1fa64  str        w9, [x0]
0x1fa68  lsl        x1, x8, #6
0x1fa6c  mov        w0, #0x40
0x1fa70  bl         #0x49560    ; _Z14aligned_mallocmm
0x1fa74  str        x0, [x21, #8]
0x1fa78  mov        w0, #0x28
0x1fa7c  str        x21, [x19, #0x50]
0x1fa80  bl         #0x49500    ; _Znwm
0x1fa84  ldrsw      x8, [x19, #8]
0x1fa88  mov        x21, x0
0x1fa8c  str        d8, [x0, #0x10]
0x1fa90  lsl        w9, w8, #4
0x1fa94  stp        w22, w8, [x0, #0x18]
0x1fa98  str        w9, [x0, #0x20]
0x1fa9c  str        w9, [x0]
0x1faa0  lsl        x1, x8, #6
0x1faa4  mov        w0, #0x40
0x1faa8  bl         #0x49560    ; _Z14aligned_mallocmm
0x1faac  str        x0, [x21, #8]
0x1fab0  mov        w0, #0x28
0x1fab4  str        x21, [x19, #0x58]
0x1fab8  bl         #0x49500    ; _Znwm
0x1fabc  ldrsw      x8, [x19, #8]
0x1fac0  mov        x21, x0
0x1fac4  str        d8, [x0, #0x10]
