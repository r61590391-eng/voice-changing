_ZN9UpSampler7forwardEP6TensorIfES2_ 0x2a798
0x2a798  stp        x30, x21, [sp, #-0x20]!
0x2a79c  stp        x20, x19, [sp, #0x10]
0x2a7a0  ldr        w9, [x1, #0x20]
0x2a7a4  mov        x21, x2
0x2a7a8  mov        x19, x1
0x2a7ac  mov        x20, x0
0x2a7b0  cmp        w9, #1
0x2a7b4  b.lt       #0x2a7f8
0x2a7b8  mov        w10, #0xcccd
0x2a7bc  mov        x8, xzr
0x2a7c0  movk       w10, #0x3e4c, lsl #16
0x2a7c4  b          #0x2a7d4
0x2a7c8  add        x8, x8, #1
0x2a7cc  cmp        x8, w9, sxtw
0x2a7d0  b.ge       #0x2a7f8
0x2a7d4  ldr        x11, [x19, #8]
0x2a7d8  ldr        s0, [x11, x8, lsl #2]
0x2a7dc  fcmp       s0, #0.0
0x2a7e0  b.pl       #0x2a7c8
0x2a7e4  fmov       s1, w10
0x2a7e8  fmul       s0, s0, s1
0x2a7ec  str        s0, [x11, x8, lsl #2]
0x2a7f0  ldr        w9, [x19, #0x20]
0x2a7f4  b          #0x2a7c8
0x2a7f8  ldr        x0, [x20, #0x20]
0x2a7fc  mov        x1, x19
0x2a800  bl         #0x49f30    ; _ZN8DeConv1d7forwardEP6TensorIfE
0x2a804  ldr        w8, [x19, #0x20]
0x2a808  cmp        w8, #1
0x2a80c  b.lt       #0x2a840
0x2a810  mov        x8, xzr
0x2a814  ldr        x9, [x19, #8]
0x2a818  ldr        x10, [x21, #8]
0x2a81c  lsl        x11, x8, #2
0x2a820  add        x8, x8, #1
0x2a824  ldr        s0, [x9, x11]
0x2a828  ldr        s1, [x10, x11]
0x2a82c  fadd       s0, s0, s1
0x2a830  str        s0, [x9, x11]
0x2a834  ldrsw      x9, [x19, #0x20]
0x2a838  cmp        x8, x9
0x2a83c  b.lt       #0x2a814
0x2a840  ldr        x0, [x20, #0x28]
0x2a844  mov        x1, x19
0x2a848  bl         #0x49f40    ; _ZN8ResBlock7forwardEP6TensorIfE
0x2a84c  ldr        x0, [x20, #0x30]
0x2a850  mov        x1, x19
0x2a854  bl         #0x49f40    ; _ZN8ResBlock7forwardEP6TensorIfE
0x2a858  ldr        x0, [x20, #0x38]
0x2a85c  mov        x1, x19
0x2a860  bl         #0x49f40    ; _ZN8ResBlock7forwardEP6TensorIfE
0x2a864  ldr        x0, [x20, #0x40]
0x2a868  mov        x1, x19
0x2a86c  ldp        x20, x19, [sp, #0x10]
0x2a870  ldp        x30, x21, [sp], #0x20
0x2a874  b          #0x49f40    ; _ZN8ResBlock7forwardEP6TensorIfE
0x2a878  sub        sp, sp, #0xb0
0x2a87c  str        x30, [sp, #0xa0]
0x2a880  str        s0, [sp, #0xac]
0x2a884  stur       wzr, [sp, #0x97]
0x2a888  str        xzr, [sp, #0x90]
0x2a88c  strh       wzr, [sp, #0x98]
0x2a890  strh       wzr, [sp, #0x60]
0x2a894  str        x0, [sp, #0x20]
0x2a898  adrp       x17, #0x4f000
0x2a89c  ldr        x17, [x17, #0x3b8]
0x2a8a0  ldrsw      x9, [sp, #0xb8]
0x2a8a4  ldrb       w11, [sp, #0xd0]
0x2a8a8  ldrsw      x8, [sp, #0xb0]
0x2a8ac  ldrb       w10, [sp, #0xc0]
0x2a8b0  sxtw       x14, w6
0x2a8b4  sxtw       x12, w4
0x2a8b8  sxtw       x13, w5
0x2a8bc  str        x14, [sp, #0x90]
0x2a8c0  add        x14, x17, #0x10
0x2a8c4  sxtw       x15, w7
0x2a8c8  add        x16, sp, #0xc8
0x2a8cc  stp        x12, x13, [sp, #0x80]
0x2a8d0  add        x12, sp, #0xac
0x2a8d4  stp        xzr, x1, [sp, #0x28]
0x2a8d8  mov        x13, sp
0x2a8dc  stp        x14, x3, [sp]
0x2a8e0  and        w11, w11, #1
0x2a8e4  str        x2, [sp, #0x48]
0x2a8e8  stp        x3, x9, [sp, #0x68]
0x2a8ec  add        x0, sp, #0x80
0x2a8f0  add        x1, sp, #0x30
0x2a8f4  mov        w2, #1
0x2a8f8  mov        x3, xzr
0x2a8fc  stp        x8, x16, [sp, #0x50]
0x2a900  str        x15, [sp, #0x38]
0x2a904  strb       w10, [sp, #0x40]
0x2a908  stp        x9, x12, [sp, #0x10]
0x2a90c  strb       w11, [sp, #0x60]
0x2a910  str        x13, [sp, #0x78]
0x2a914  bl         #0x49f50    ; _Z13MlasGemmBatchRK28MLAS_GEMM_QUANT_SHAPE_PARAMSPK27MLAS_GEMM_QUANT_DATA_PARAMSmP15IMlasThreadPool
0x2a918  ldr        x30, [sp, #0xa0]
0x2a91c  add        sp, sp, #0xb0
0x2a920  ret        
0x2a924  stp        d9, d8, [sp, #-0x70]!
0x2a928  sub        x9, sp, #0xf4, lsl #12
0x2a92c  sub        x9, x9, #0x390
0x2a930  stp        x29, x30, [sp, #0x10]
0x2a934  stp        x28, x27, [sp, #0x20]
0x2a938  stp        x26, x25, [sp, #0x30]
0x2a93c  stp        x24, x23, [sp, #0x40]
0x2a940  stp        x22, x21, [sp, #0x50]
0x2a944  stp        x20, x19, [sp, #0x60]
0x2a948  add        x29, sp, #0x10
0x2a94c  and        sp, x9, #0xffffffffffffff00
0x2a950  stp        x5, x7, [sp, #0x30]
0x2a954  stp        x0, x2, [sp, #0x40]
0x2a958  mrs        x20, tpidr_el0
0x2a95c  ldr        x8, [x20, #0x28]
0x2a960  mul        w9, w6, w4
0x2a964  mov        x26, x1
0x2a968  add        x10, sp, #0xec, lsl #12
0x2a96c  sxtw       x27, w9
0x2a970  mov        x19, x3
0x2a974  add        x10, x10, #0x390
0x2a978  add        x1, sp, #0xfc
0x2a97c  add        x2, sp, #0xf8
0x2a980  mov        x0, x26
0x2a984  mov        x3, x27
0x2a988  mov        v8.16b, v0.16b
0x2a98c  mov        w23, w6
0x2a990  mov        w25, w4
0x2a994  str        x8, [x10, #0x7ff8]
0x2a998  bl         #0x49f60    ; _Z21MlasFindMinMaxElementPKfPfS1_m
0x2a99c  ldr        s0, [sp, #0xfc]
0x2a9a0  fcmp       s0, #0.0
0x2a9a4  b.le       #0x2a9b0
0x2a9a8  fmov       s0, wzr
0x2a9ac  str        wzr, [sp, #0xfc]
0x2a9b0  ldr        s1, [sp, #0xf8]
0x2a9b4  ldrb       w8, [x29, #0x78]
0x2a9b8  ldr        w22, [x29, #0x68]
0x2a9bc  ldr        w21, [x29, #0x60]
0x2a9c0  fcmp       s1, #0.0
0x2a9c4  b.pl       #0x2a9d0
0x2a9c8  fmov       s1, wzr
0x2a9cc  str        wzr, [sp, #0xf8]
0x2a9d0  mov        w9, #0x437f0000
0x2a9d4  fsub       s1, s1, s0
0x2a9d8  fmov       s3, w9
0x2a9dc  fdiv       s1, s1, s3
0x2a9e0  fmov       s2, #1.00000000
0x2a9e4  fcmp       s1, #0.0
0x2a9e8  fcsel      s9, s2, s1, eq
0x2a9ec  fmov       s1, wzr
0x2a9f0  fsub       s0, s1, s0
0x2a9f4  fdiv       s0, s0, s9
0x2a9f8  frinta     s0, s0
0x2a9fc  fmax       s0, s0, s1
0x2aa00  fmin       s0, s0, s3
0x2aa04  fcvtzs     w28, s0
0x2aa08  add        x1, sp, #0x100
0x2aa0c  mov        x0, x26
0x2aa10  mov        x2, x27
0x2aa14  mov        v0.16b, v9.16b
0x2aa18  mov        w3, w28
0x2aa1c  and        w24, w8, #1
0x2aa20  bl         #0x49f70    ; _Z18MlasQuantizeLinearIhEvPKfPT_mfS2_
0x2aa24  ldp        x9, x11, [sp, #0x30]
0x2aa28  stp        xzr, xzr, [sp, #0xd0]
0x2aa2c  stur       wzr, [sp, #0xe7]
0x2aa30  str        xzr, [sp, #0xe0]
0x2aa34  strh       wzr, [sp, #0xb0]
0x2aa38  sxtw       x8, w25
0x2aa3c  sxtw       x9, w9
0x2aa40  strh       wzr, [sp, #0xe8]
0x2aa44  strb       w28, [sp, #0x90]
0x2aa48  strb       w24, [sp, #0xb0]
0x2aa4c  adrp       x15, #0x4f000
0x2aa50  sxtw       x11, w11
0x2aa54  ldr        x15, [x15, #0x3b8]
0x2aa58  stp        x8, x9, [sp, #0xd0]
0x2aa5c  add        x8, sp, #0x100
0x2aa60  stp        x8, x11, [sp, #0x80]
0x2aa64  ldp        x17, x8, [sp, #0x40]
0x2aa68  fmul       s0, s9, s8
0x2aa6c  sxtw       x10, w23
0x2aa70  add        x12, x29, #0x70
0x2aa74  sxtw       x13, w22
0x2aa78  sxtw       x14, w21
0x2aa7c  add        x16, sp, #0xf4
0x2aa80  stp        x17, xzr, [sp, #0x70]
0x2aa84  add        x17, sp, #0x50
0x2aa88  str        x8, [sp, #0x98]
0x2aa8c  add        x8, x15, #0x10
0x2aa90  add        x0, sp, #0xd0
0x2aa94  add        x1, sp, #0x80
0x2aa98  mov        w2, #1
0x2aa9c  mov        x3, xzr
0x2aaa0  str        s0, [sp, #0xf4]
0x2aaa4  str        x10, [sp, #0xe0]
0x2aaa8  stp        x14, x12, [sp, #0xa0]
0x2aaac  stp        x19, x13, [sp, #0xb8]
0x2aab0  stp        x13, x16, [sp, #0x60]
0x2aab4  stp        x8, x19, [sp, #0x50]
0x2aab8  str        x17, [sp, #0xc8]
0x2aabc  bl         #0x49f50    ; _Z13MlasGemmBatchRK28MLAS_GEMM_QUANT_SHAPE_PARAMSPK27MLAS_GEMM_QUANT_DATA_PARAMSmP15IMlasThreadPool
0x2aac0  add        x9, sp, #0xec, lsl #12
0x2aac4  add        x9, x9, #0x390
0x2aac8  ldr        x8, [x20, #0x28]
0x2aacc  ldr        x9, [x9, #0x7ff8]
0x2aad0  cmp        x8, x9
0x2aad4  b.ne       #0x2aafc
0x2aad8  sub        sp, x29, #0x10
0x2aadc  ldp        x20, x19, [sp, #0x60]
0x2aae0  ldp        x22, x21, [sp, #0x50]
0x2aae4  ldp        x24, x23, [sp, #0x40]
0x2aae8  ldp        x26, x25, [sp, #0x30]
0x2aaec  ldp        x28, x27, [sp, #0x20]
0x2aaf0  ldp        x29, x30, [sp, #0x10]
0x2aaf4  ldp        d9, d8, [sp], #0x70
0x2aaf8  ret        
0x2aafc  bl         #0x49f80    ; __stack_chk_fail
0x2ab00  stp        d9, d8, [sp, #-0x70]!
0x2ab04  sub        x9, sp, #0xf4, lsl #12
0x2ab08  sub        x9, x9, #0x390
0x2ab0c  stp        x29, x30, [sp, #0x10]
0x2ab10  stp        x28, x27, [sp, #0x20]
0x2ab14  stp        x26, x25, [sp, #0x30]
0x2ab18  stp        x24, x23, [sp, #0x40]
0x2ab1c  stp        x22, x21, [sp, #0x50]
0x2ab20  stp        x20, x19, [sp, #0x60]
0x2ab24  add        x29, sp, #0x10
0x2ab28  and        sp, x9, #0xffffffffffffff00
0x2ab2c  stp        x0, x5, [sp, #0xb0]
0x2ab30  str        x2, [sp, #0xa8]
0x2ab34  mrs        x28, tpidr_el0
0x2ab38  ldr        x8, [x28, #0x28]
0x2ab3c  mul        w9, w6, w4
0x2ab40  mov        x25, x1
0x2ab44  add        x10, sp, #0xec, lsl #12
0x2ab48  sxtw       x26, w9
0x2ab4c  mov        x19, x3
0x2ab50  add        x10, x10, #0x390
0x2ab54  add        x1, sp, #0xfc
0x2ab58  add        x2, sp, #0xf8
0x2ab5c  mov        x0, x25
0x2ab60  mov        x3, x26
0x2ab64  mov        v8.16b, v0.16b
0x2ab68  mov        w23, w6
0x2ab6c  mov        w24, w4
0x2ab70  str        x8, [x10, #0x7ff8]
0x2ab74  bl         #0x49f60    ; _Z21MlasFindMinMaxElementPKfPfS1_m
0x2ab78  ldr        s0, [sp, #0xfc]
0x2ab7c  fcmp       s0, #0.0
0x2ab80  b.le       #0x2ab8c
0x2ab84  fmov       s0, wzr
0x2ab88  str        wzr, [sp, #0xfc]
0x2ab8c  ldr        s1, [sp, #0xf8]
0x2ab90  ldr        w21, [x29, #0x78]
0x2ab94  ldrb       w22, [x29, #0x70]
0x2ab98  ldr        w20, [x29, #0x68]
0x2ab9c  fcmp       s1, #0.0
0x2aba0  b.pl       #0x2abac
0x2aba4  fmov       s1, wzr
0x2aba8  str        wzr, [sp, #0xf8]
0x2abac  mov        w8, #0x437f0000
0x2abb0  fsub       s1, s1, s0
0x2abb4  fmov       s4, w8
0x2abb8  fdiv       s1, s1, s4
0x2abbc  fmov       s2, #1.00000000
0x2abc0  fmov       s3, wzr
0x2abc4  fcmp       s1, #0.0
0x2abc8  fcsel      s9, s2, s1, eq
0x2abcc  fsub       s0, s3, s0
0x2abd0  fdiv       s0, s0, s9
0x2abd4  frinta     s0, s0
0x2abd8  fmax       s0, s0, s3
0x2abdc  fmin       s0, s0, s4
0x2abe0  fcvtzs     w27, s0
0x2abe4  add        x1, sp, #0x100
0x2abe8  mov        x0, x25
0x2abec  mov        x2, x26
0x2abf0  mov        v0.16b, v9.16b
0x2abf4  mov        w3, w27
0x2abf8  bl         #0x49f70    ; _Z18MlasQuantizeLinearIhEvPKfPT_mfS2_
0x2abfc  ldr        x3, [sp, #0xa8]
0x2ac00  sub        w8, w24, w21
0x2ac04  add        w8, w8, #1
0x2ac08  fmul       s0, s9, s8
0x2ac0c  and        w4, w22, #0xff
0x2ac10  sxtw       x7, w23
0x2ac14  sxtw       x23, w8
0x2ac18  sxtw       x8, w21
0x2ac1c  add        x0, sp, #0x100
0x2ac20  mov        w1, w27
0x2ac24  mov        w2, wzr
0x2ac28  mov        w5, wzr
0x2ac2c  mov        x6, x19
0x2ac30  str        s0, [sp, #0xf4]
0x2ac34  stp        x23, x8, [sp]
0x2ac38  bl         #0x49f90    ; _Z17MlasConvDepthwisePKvibS0_ibPimmm
0x2ac3c  adrp       x8, #0x4f000
0x2ac40  ldr        x8, [x8, #0x3b8]
0x2ac44  sxtw       x6, w20
0x2ac48  add        x9, sp, #0xf4
0x2ac4c  add        x8, x8, #0x10
0x2ac50  stp        x8, x19, [sp, #0xc0]
0x2ac54  ldp        x10, x8, [sp, #0xb0]
0x2ac58  add        x0, sp, #0xc0
0x2ac5c  mov        x1, x19
0x2ac60  mov        x2, xzr
0x2ac64  sxtw       x5, w8
0x2ac68  mov        x3, xzr
0x2ac6c  mov        x4, x23
0x2ac70  stp        x10, xzr, [sp, #0xe0]
0x2ac74  stp        x6, x9, [sp, #0xd0]
0x2ac78  bl         #0x49fa0    ; _ZNK38MLAS_QGEMM_SCALE_BIAS_OUTPUT_PROCESSOR7ProcessEPKimmmmm
0x2ac7c  add        x9, sp, #0xec, lsl #12
0x2ac80  add        x9, x9, #0x390
0x2ac84  ldr        x8, [x28, #0x28]
0x2ac88  ldr        x9, [x9, #0x7ff8]
0x2ac8c  cmp        x8, x9
0x2ac90  b.ne       #0x2acb8
0x2ac94  sub        sp, x29, #0x10
0x2ac98  ldp        x20, x19, [sp, #0x60]
0x2ac9c  ldp        x22, x21, [sp, #0x50]
0x2aca0  ldp        x24, x23, [sp, #0x40]
0x2aca4  ldp        x26, x25, [sp, #0x30]
0x2aca8  ldp        x28, x27, [sp, #0x20]
0x2acac  ldp        x29, x30, [sp, #0x10]
0x2acb0  ldp        d9, d8, [sp], #0x70
0x2acb4  ret        
0x2acb8  bl         #0x49f80    ; __stack_chk_fail
0x2acbc  stp        x30, x27, [sp, #-0x50]!
0x2acc0  stp        x26, x25, [sp, #0x10]
0x2acc4  stp        x24, x23, [sp, #0x20]
0x2acc8  stp        x22, x21, [sp, #0x30]
0x2accc  stp        x20, x19, [sp, #0x40]
0x2acd0  ldrsw      x9, [x6]
0x2acd4  ldrsw      x8, [sp, #0x50]
0x2acd8  add        w10, w7, #0xf
0x2acdc  mov        w20, w7
0x2ace0  add        x9, x0, x9
0x2ace4  str        x9, [x1]
0x2ace8  add        w9, w8, #0x3f
0x2acec  ldr        w11, [x6]
0x2acf0  and        w9, w9, #0xffffffc0
0x2acf4  and        w10, w10, #0xfffffff0
0x2acf8  orr        w9, w9, #4
0x2acfc  mul        w27, w9, w10
0x2ad00  sxtw       x26, w20
0x2ad04  mov        x23, x3
0x2ad08  mov        x22, x2
0x2ad0c  mov        x25, x0
0x2ad10  add        w9, w11, w27
0x2ad14  mov        x0, x26
0x2ad18  mov        x1, x8
0x2ad1c  mov        w2, wzr
0x2ad20  mov        w3, wzr
0x2ad24  mov        x19, x6
0x2ad28  mov        x24, x5
0x2ad2c  mov        x21, x4
0x2ad30  str        w9, [x6]
0x2ad34  bl         #0x49fb0    ; _Z17MlasGemmPackBSizemmbb
0x2ad38  cmp        w0, #1
0x2ad3c  b.lt       #0x2ad54
0x2ad40  cmp        w27, w0
0x2ad44  b.ge       #0x2ad54
0x2ad48  adrp       x0, #0xe000
0x2ad4c  add        x0, x0, #0x9c5
0x2ad50  bl         #0x49b50    ; puts
0x2ad54  strb       wzr, [x24]
0x2ad58  ldrsw      x8, [x19]
0x2ad5c  lsl        x9, x26, #2
0x2ad60  add        x8, x25, x8
0x2ad64  str        x8, [x22]
0x2ad68  ldr        s0, [x8, x9]
0x2ad6c  ldp        x26, x25, [sp, #0x10]
0x2ad70  str        s0, [x23]
0x2ad74  ldr        x8, [x22]
0x2ad78  ldp        x24, x23, [sp, #0x20]
0x2ad7c  add        x8, x8, x9
0x2ad80  ldrb       w8, [x8, #4]
0x2ad84  lsl        w9, w20, #2
0x2ad88  add        w9, w9, #0x44
0x2ad8c  and        w9, w9, #0xffffffc0
0x2ad90  strb       w8, [x21]
0x2ad94  ldr        w8, [x19]
0x2ad98  ldp        x22, x21, [sp, #0x30]
0x2ad9c  add        w8, w8, w9
0x2ada0  str        w8, [x19]
0x2ada4  ldp        x20, x19, [sp, #0x40]
0x2ada8  ldp        x30, x27, [sp], #0x50
0x2adac  ret        
0x2adb0  add        x9, x1, #0x3f
0x2adb4  add        x8, x0, #0xf
0x2adb8  and        x9, x9, #0xffffffffffffffc0
0x2adbc  and        x8, x8, #0xfffffffffffffff0
0x2adc0  orr        x9, x9, #4
0x2adc4  mul        x0, x9, x8
0x2adc8  ret        
0x2adcc  add        w8, w0, w1
0x2add0  sub        w8, w8, #1
0x2add4  neg        w9, w1
0x2add8  and        w0, w8, w9
0x2addc  ret        
0x2ade0  sub        sp, sp, #0x70
0x2ade4  stp        x29, x30, [sp, #0x10]
0x2ade8  stp        x28, x27, [sp, #0x20]
0x2adec  stp        x26, x25, [sp, #0x30]
0x2adf0  stp        x24, x23, [sp, #0x40]
0x2adf4  stp        x22, x21, [sp, #0x50]
0x2adf8  stp        x20, x19, [sp, #0x60]
0x2adfc  ldrsw      x8, [x6]
0x2ae00  ldrsw      x27, [sp, #0x70]
0x2ae04  add        w9, w7, #0xf
0x2ae08  mov        w20, w7
0x2ae0c  add        x8, x0, x8
0x2ae10  add        w10, w27, #0x3f
0x2ae14  str        x8, [x1]
0x2ae18  and        w8, w10, #0xffffffc0
0x2ae1c  ldr        w10, [x6]
0x2ae20  and        w9, w9, #0xfffffff0
0x2ae24  orr        w8, w8, #4
0x2ae28  mul        w21, w8, w9
0x2ae2c  sxtw       x25, w20
0x2ae30  str        x3, [sp, #8]
0x2ae34  mov        x22, x2
0x2ae38  mov        x26, x1
0x2ae3c  mov        x24, x0
0x2ae40  add        w8, w10, w21
0x2ae44  mov        x0, x25
0x2ae48  mov        x1, x27
0x2ae4c  mov        w2, wzr
0x2ae50  mov        w3, wzr
0x2ae54  mov        x19, x6
0x2ae58  mov        x28, x5
0x2ae5c  mov        x23, x4
0x2ae60  str        w8, [x6]
0x2ae64  bl         #0x49fb0    ; _Z17MlasGemmPackBSizemmbb
0x2ae68  mov        x29, x0
0x2ae6c  cmp        w29, #1
0x2ae70  b.lt       #0x2aee4
0x2ae74  cmp        w21, w29
0x2ae78  b.ge       #0x2ae88
0x2ae7c  adrp       x0, #0xe000
0x2ae80  add        x0, x0, #0x9c5
0x2ae84  bl         #0x49b50    ; puts
0x2ae88  mov        w8, #1
0x2ae8c  strb       w8, [x28]
0x2ae90  sxtw       x28, w29
0x2ae94  mov        w0, #0x40
0x2ae98  mov        x1, x28
0x2ae9c  bl         #0x49560    ; _Z14aligned_mallocmm
0x2aea0  cbz        x0, #0x2af2c
0x2aea4  ldr        x2, [x26]
0x2aea8  mov        x29, x0
0x2aeac  mov        x0, x25
0x2aeb0  mov        x1, x27
0x2aeb4  mov        x3, x25
0x2aeb8  mov        w4, wzr
0x2aebc  mov        w5, wzr
0x2aec0  mov        x6, x29
0x2aec4  bl         #0x49fc0    ; _Z13MlasGemmPackBmmPKhmbbPv
0x2aec8  ldr        x0, [x26]
0x2aecc  mov        x1, x29
0x2aed0  mov        x2, x28
0x2aed4  bl         #0x496d0    ; memcpy
0x2aed8  mov        x0, x29
0x2aedc  bl         #0x49630    ; _Z12aligned_freePv
0x2aee0  b          #0x2aee8
0x2aee4  strb       wzr, [x28]
0x2aee8  ldrsw      x8, [x19]
0x2aeec  lsl        x9, x25, #2
0x2aef0  ldr        x10, [sp, #8]
0x2aef4  add        x8, x24, x8
0x2aef8  str        x8, [x22]
0x2aefc  ldr        s0, [x8, x9]
0x2af00  str        s0, [x10]
0x2af04  ldr        x8, [x22]
0x2af08  add        x8, x8, x9
0x2af0c  ldrb       w8, [x8, #4]
0x2af10  lsl        w9, w20, #2
0x2af14  add        w9, w9, #0x44
0x2af18  and        w9, w9, #0xffffffc0
0x2af1c  strb       w8, [x23]
0x2af20  ldr        w8, [x19]
0x2af24  add        w8, w8, w9
0x2af28  str        w8, [x19]
0x2af2c  ldp        x20, x19, [sp, #0x60]
0x2af30  ldp        x22, x21, [sp, #0x50]
0x2af34  ldp        x24, x23, [sp, #0x40]
0x2af38  ldp        x26, x25, [sp, #0x30]
0x2af3c  ldp        x28, x27, [sp, #0x20]
0x2af40  ldp        x29, x30, [sp, #0x10]
0x2af44  add        sp, sp, #0x70
0x2af48  ret        
0x2af4c  str        x30, [sp, #-0x60]!
0x2af50  stp        x28, x27, [sp, #0x10]
0x2af54  stp        x26, x25, [sp, #0x20]
0x2af58  stp        x24, x23, [sp, #0x30]
0x2af5c  stp        x22, x21, [sp, #0x40]
0x2af60  stp        x20, x19, [sp, #0x50]
0x2af64  ldrsw      x8, [x5]
0x2af68  add        w10, w7, #0x3f
0x2af6c  and        w10, w10, #0xffffffc0
0x2af70  add        w9, w6, #0xf
0x2af74  add        x8, x0, x8
0x2af78  str        x8, [x1]
0x2af7c  orr        w8, w10, #4
0x2af80  ldr        w10, [x5]
0x2af84  and        w9, w9, #0xfffffff0
0x2af88  mul        w28, w8, w9
0x2af8c  sxtw       x24, w6
0x2af90  sxtw       x26, w7
0x2af94  mov        x20, x3
0x2af98  mov        x21, x2
0x2af9c  mov        x23, x1
0x2afa0  mov        x22, x0
0x2afa4  add        w8, w10, w28
0x2afa8  mov        x0, x24
0x2afac  mov        x1, x26
0x2afb0  mov        w2, wzr
0x2afb4  mov        w3, wzr
0x2afb8  mov        x19, x5
0x2afbc  mov        x25, x4
0x2afc0  str        w8, [x5]
0x2afc4  bl         #0x49fb0    ; _Z17MlasGemmPackBSizemmbb
0x2afc8  mov        x27, x0
0x2afcc  cmp        w27, #1
0x2afd0  b.lt       #0x2b044
0x2afd4  cmp        w28, w27
0x2afd8  b.ge       #0x2afe8
0x2afdc  adrp       x0, #0xe000
0x2afe0  add        x0, x0, #0x9c5
0x2afe4  bl         #0x49b50    ; puts
0x2afe8  mov        w8, #1
0x2afec  strb       w8, [x25]
0x2aff0  sxtw       x25, w27
0x2aff4  mov        w0, #0x40
0x2aff8  mov        x1, x25
0x2affc  bl         #0x49560    ; _Z14aligned_mallocmm
0x2b000  cbz        x0, #0x2b06c
0x2b004  ldr        x2, [x23]
0x2b008  mov        x27, x0
0x2b00c  mov        x0, x24
0x2b010  mov        x1, x26
0x2b014  mov        x3, x24
0x2b018  mov        w4, wzr
0x2b01c  mov        w5, wzr
0x2b020  mov        x6, x27
0x2b024  bl         #0x49fc0    ; _Z13MlasGemmPackBmmPKhmbbPv
0x2b028  ldr        x0, [x23]
0x2b02c  mov        x1, x27
0x2b030  mov        x2, x25
0x2b034  bl         #0x496d0    ; memcpy
0x2b038  mov        x0, x27
0x2b03c  bl         #0x49630    ; _Z12aligned_freePv
0x2b040  b          #0x2b048
0x2b044  strb       wzr, [x25]
0x2b048  ldrsw      x8, [x19]
0x2b04c  add        x8, x22, x8
0x2b050  ldr        s0, [x8]
0x2b054  str        s0, [x21]
0x2b058  ldrb       w8, [x8, #4]
0x2b05c  strb       w8, [x20]
0x2b060  ldr        w8, [x19]
0x2b064  add        w8, w8, #0x40
0x2b068  str        w8, [x19]
0x2b06c  ldp        x20, x19, [sp, #0x50]
0x2b070  ldp        x22, x21, [sp, #0x40]
0x2b074  ldp        x24, x23, [sp, #0x30]
0x2b078  ldp        x26, x25, [sp, #0x20]
0x2b07c  ldp        x28, x27, [sp, #0x10]
0x2b080  ldr        x30, [sp], #0x60
0x2b084  ret        
0x2b088  stp        x30, x21, [sp, #-0x20]!
0x2b08c  stp        x20, x19, [sp, #0x10]
0x2b090  mov        x20, x1
0x2b094  adrp       x1, #0xe000
0x2b098  add        x1, x1, #0xa1b
0x2b09c  mov        w19, w2
0x2b0a0  bl         #0x49fd0    ; fopen
0x2b0a4  mov        x21, x0
0x2b0a8  mov        w2, w19
0x2b0ac  mov        w1, #1
0x2b0b0  mov        x0, x20
0x2b0b4  mov        x3, x21
0x2b0b8  bl         #0x49fe0    ; fwrite
0x2b0bc  ldp        x20, x19, [sp, #0x10]
0x2b0c0  mov        x0, x21
0x2b0c4  ldp        x30, x21, [sp], #0x20
0x2b0c8  b          #0x49ff0    ; fclose
0x2b0cc  sub        sp, sp, #0x70
0x2b0d0  str        x30, [sp, #0x20]
0x2b0d4  stp        x26, x25, [sp, #0x30]
0x2b0d8  stp        x24, x23, [sp, #0x40]
0x2b0dc  stp        x22, x21, [sp, #0x50]
0x2b0e0  stp        x20, x19, [sp, #0x60]
0x2b0e4  mov        x21, x0
0x2b0e8  mov        x20, x1
0x2b0ec  add        x0, sp, #8
0x2b0f0  mov        x1, x21
0x2b0f4  mov        x19, x8
0x2b0f8  add        x24, sp, #8
0x2b0fc  bl         #0x4a000    ; _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_
0x2b100  ldrb       w8, [x21]
0x2b104  ldp        x9, x10, [x21, #8]
0x2b108  lsr        x11, x8, #1
0x2b10c  tst        w8, #1
0x2b110  csel       x22, x11, x9, eq
0x2b114  csinc      x23, x10, x21, ne
0x2b118  ldrb       w8, [x23, x22]
0x2b11c  cmp        w8, #0x2f
0x2b120  b.ne       #0x2b180
0x2b124  stp        xzr, xzr, [x19]
0x2b128  str        xzr, [x19, #0x10]
0x2b12c  ldrb       w8, [x20]
0x2b130  ldr        x9, [x20, #8]
0x2b134  tst        w8, #1
0x2b138  lsr        x8, x8, #1
0x2b13c  csel       x21, x8, x9, eq
0x2b140  add        x8, x21, x22
0x2b144  cset       w26, eq
0x2b148  cmn        x8, #0x10
0x2b14c  b.hs       #0x2b248
0x2b150  cmp        x8, #0x16
0x2b154  b.ls       #0x2b1dc
0x2b158  add        x8, x8, #0x10
0x2b15c  and        x25, x8, #0xfffffffffffffff0
0x2b160  mov        x0, x25
0x2b164  bl         #0x49500    ; _Znwm
0x2b168  mov        x24, x0
0x2b16c  orr        x8, x25, #1
0x2b170  stp        x22, x0, [x19, #8]
0x2b174  str        x8, [x19]
0x2b178  cbnz       x22, #0x2b1ec
0x2b17c  b          #0x2b1fc
0x2b180  add        x0, sp, #8
0x2b184  mov        w1, #0x2f
0x2b188  bl         #0x4a010    ; _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9push_backEc
0x2b18c  stp        xzr, xzr, [x19]
0x2b190  str        xzr, [x19, #0x10]
0x2b194  ldrb       w11, [x20]
0x2b198  ldrb       w8, [sp, #8]
0x2b19c  ldr        x13, [x20, #8]
0x2b1a0  ldp        x9, x10, [sp, #0x10]
0x2b1a4  tst        w11, #1
0x2b1a8  lsr        x11, x11, #1
0x2b1ac  lsr        x14, x8, #1
0x2b1b0  csel       x21, x11, x13, eq
0x2b1b4  cset       w26, eq
0x2b1b8  tst        w8, #1
0x2b1bc  csel       x22, x14, x9, eq
0x2b1c0  orr        x12, x24, #1
0x2b1c4  add        x8, x21, x22
0x2b1c8  csel       x23, x12, x10, eq
0x2b1cc  cmn        x8, #0x10
0x2b1d0  b.hs       #0x2b248
0x2b1d4  cmp        x8, #0x16
0x2b1d8  b.hi       #0x2b158
0x2b1dc  lsl        w8, w22, #1
0x2b1e0  mov        x24, x19
0x2b1e4  strb       w8, [x24], #1
0x2b1e8  cbz        x22, #0x2b1fc
0x2b1ec  mov        x0, x24
0x2b1f0  mov        x1, x23
0x2b1f4  mov        x2, x22
0x2b1f8  bl         #0x496d0    ; memcpy
0x2b1fc  add        x8, x24, x22
0x2b200  strb       wzr, [x8]
0x2b204  ldr        x8, [x20, #0x10]
0x2b208  cmp        w26, #0
0x2b20c  mov        x0, x19
0x2b210  mov        x2, x21
0x2b214  csinc      x1, x8, x20, eq
0x2b218  bl         #0x4a020    ; _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm
0x2b21c  ldrb       w8, [sp, #8]
0x2b220  tbz        w8, #0, #0x2b22c
0x2b224  ldr        x0, [sp, #0x18]
0x2b228  bl         #0x49600    ; _ZdlPv
0x2b22c  ldp        x20, x19, [sp, #0x60]
0x2b230  ldp        x22, x21, [sp, #0x50]
0x2b234  ldp        x24, x23, [sp, #0x40]
0x2b238  ldp        x26, x25, [sp, #0x30]
0x2b23c  ldr        x30, [sp, #0x20]
0x2b240  add        sp, sp, #0x70
0x2b244  ret        
0x2b248  mov        x0, x19
0x2b24c  bl         #0x4a030    ; _ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv
0x2b250  ldr        w8, [x0, #0x20]
0x2b254  cmp        w8, #1
0x2b258  b.lt       #0x2b288
0x2b25c  mov        x8, xzr
0x2b260  fmov       s0, wzr
0x2b264  ldr        x9, [x0, #8]
0x2b268  lsl        x10, x8, #2
0x2b26c  add        x8, x8, #1
0x2b270  ldr        s1, [x9, x10]
0x2b274  fmax       s1, s1, s0
0x2b278  str        s1, [x9, x10]
0x2b27c  ldrsw      x9, [x0, #0x20]
0x2b280  cmp        x8, x9
0x2b284  b.lt       #0x2b264
0x2b288  ret        
0x2b28c  ldr        w8, [x0, #0x20]
0x2b290  cmp        w8, #1
0x2b294  b.lt       #0x2b2c8
0x2b298  mov        x8, xzr
0x2b29c  fmov       s0, wzr
0x2b2a0  ldr        x9, [x0, #8]
0x2b2a4  lsl        x10, x8, #2
0x2b2a8  add        x8, x8, #1
0x2b2ac  ldr        s1, [x9, x10]
0x2b2b0  ldr        x9, [x1, #8]
0x2b2b4  fmax       s1, s1, s0
0x2b2b8  str        s1, [x9, x10]
0x2b2bc  ldrsw      x9, [x0, #0x20]
0x2b2c0  cmp        x8, x9
0x2b2c4  b.lt       #0x2b2a0
0x2b2c8  ret        
0x2b2cc  stp        d9, d8, [sp, #-0x40]!
0x2b2d0  str        x30, [sp, #0x10]
0x2b2d4  stp        x22, x21, [sp, #0x20]
0x2b2d8  stp        x20, x19, [sp, #0x30]
0x2b2dc  ldr        w8, [x0, #0x20]
0x2b2e0  cmp        w8, #1
0x2b2e4  b.lt       #0x2b324
0x2b2e8  mov        x19, x0
0x2b2ec  mov        x20, xzr
0x2b2f0  fmov       s8, #1.00000000
0x2b2f4  ldr        x21, [x19, #8]
0x2b2f8  lsl        x22, x20, #2
0x2b2fc  ldr        s9, [x21, x22]
0x2b300  fneg       s0, s9
0x2b304  bl         #0x497f0    ; expf
0x2b308  fadd       s0, s0, s8
0x2b30c  fdiv       s0, s9, s0
0x2b310  str        s0, [x21, x22]
0x2b314  ldrsw      x8, [x19, #0x20]
0x2b318  add        x20, x20, #1
0x2b31c  cmp        x20, x8
0x2b320  b.lt       #0x2b2f4
0x2b324  ldp        x20, x19, [sp, #0x30]
0x2b328  ldp        x22, x21, [sp, #0x20]
0x2b32c  ldr        x30, [sp, #0x10]
0x2b330  ldp        d9, d8, [sp], #0x40
0x2b334  ret        
0x2b338  str        x30, [sp, #-0x20]!
0x2b33c  stp        x20, x19, [sp, #0x10]
0x2b340  mov        x20, x0
0x2b344  mov        x19, x1
0x2b348  ldr        x0, [x0, #8]
0x2b34c  ldr        x1, [x1, #8]
0x2b350  ldrsw      x2, [x20, #0x20]
0x2b354  bl         #0x4a040    ; _Z19MlasComputeLogisticPKfPfm
0x2b358  ldr        w8, [x20, #0x20]
0x2b35c  cmp        w8, #1
0x2b360  b.lt       #0x2b394
0x2b364  mov        x8, xzr
0x2b368  ldr        x9, [x20, #8]
0x2b36c  ldr        x10, [x19, #8]
0x2b370  lsl        x11, x8, #2
0x2b374  add        x8, x8, #1
0x2b378  ldr        s0, [x9, x11]
0x2b37c  ldr        s1, [x10, x11]
0x2b380  fmul       s0, s0, s1
0x2b384  str        s0, [x10, x11]
0x2b388  ldrsw      x9, [x20, #0x20]
0x2b38c  cmp        x8, x9
0x2b390  b.lt       #0x2b368
0x2b394  ldp        x20, x19, [sp, #0x10]
0x2b398  ldr        x30, [sp], #0x20
0x2b39c  ret        
0x2b3a0  stp        x30, x21, [sp, #-0x20]!
0x2b3a4  stp        x20, x19, [sp, #0x10]
0x2b3a8  mov        w21, w2
0x2b3ac  mov        x19, x0
0x2b3b0  sxtw       x2, w21
0x2b3b4  add        x0, x0, w21, sxtw #2
0x2b3b8  mov        x20, x1
0x2b3bc  bl         #0x4a040    ; _Z19MlasComputeLogisticPKfPfm
0x2b3c0  cmp        w21, #1
0x2b3c4  b.lt       #0x2b41c
0x2b3c8  cmp        w21, #8
0x2b3cc  mov        w8, w21
0x2b3d0  b.lo       #0x2b3f0
0x2b3d4  lsl        x9, x8, #2
0x2b3d8  add        x10, x19, x9
0x2b3dc  cmp        x10, x20
0x2b3e0  b.ls       #0x2b428
0x2b3e4  add        x9, x20, x9
0x2b3e8  cmp        x9, x19
0x2b3ec  b.ls       #0x2b428
0x2b3f0  mov        x9, xzr
0x2b3f4  lsl        x11, x9, #2
0x2b3f8  add        x10, x20, x11
0x2b3fc  add        x11, x19, x11
0x2b400  sub        x8, x8, x9
0x2b404  ldr        s0, [x11], #4
0x2b408  ldr        s1, [x10]
0x2b40c  subs       x8, x8, #1
0x2b410  fmul       s0, s0, s1
0x2b414  str        s0, [x10], #4
0x2b418  b.ne       #0x2b404
0x2b41c  ldp        x20, x19, [sp, #0x10]
0x2b420  ldp        x30, x21, [sp], #0x20
0x2b424  ret        
0x2b428  and        x9, x8, #0xfffffff8
0x2b42c  add        x10, x19, #0x10
0x2b430  add        x11, x20, #0x10
0x2b434  mov        x12, x9
0x2b438  ldp        q0, q1, [x10, #-0x10]
0x2b43c  ldp        q2, q3, [x11, #-0x10]
0x2b440  add        x10, x10, #0x20
0x2b444  subs       x12, x12, #8
0x2b448  fmul       v0.4s, v0.4s, v2.4s
0x2b44c  fmul       v1.4s, v1.4s, v3.4s
0x2b450  stp        q0, q1, [x11, #-0x10]
0x2b454  add        x11, x11, #0x20
0x2b458  b.ne       #0x2b438
0x2b45c  cmp        x9, x8
0x2b460  b.eq       #0x2b41c
0x2b464  b          #0x2b3f4
0x2b468  sub        sp, sp, #0x50
0x2b46c  str        d8, [sp, #0x10]
0x2b470  str        x30, [sp, #0x18]
0x2b474  stp        x24, x23, [sp, #0x20]
0x2b478  stp        x22, x21, [sp, #0x30]
0x2b47c  stp        x20, x19, [sp, #0x40]
0x2b480  mov        w19, w2
0x2b484  mov        w20, w1
0x2b488  cmp        w1, #1
0x2b48c  mov        x21, x0
0x2b490  b.lt       #0x2b55c
0x2b494  mov        w22, w20
0x2b498  mov        w8, #-0x800000
0x2b49c  fmov       s8, w8
0x2b4a0  mov        x8, x22
0x2b4a4  mov        x9, x21
0x2b4a8  ldr        s0, [x9], #4
0x2b4ac  fcmp       s8, s0
0x2b4b0  fcsel      s8, s0, s8, mi
0x2b4b4  subs       x8, x8, #1
0x2b4b8  b.ne       #0x2b4a8
0x2b4bc  cmp        w20, #1
0x2b4c0  b.lt       #0x2b55c
0x2b4c4  fmov       s3, wzr
0x2b4c8  mov        x23, x22
0x2b4cc  mov        x24, x21
0x2b4d0  ldr        s0, [x24]
0x2b4d4  str        q3, [sp]
0x2b4d8  fsub       s0, s0, s8
0x2b4dc  bl         #0x497f0    ; expf
0x2b4e0  ldr        q3, [sp]
0x2b4e4  str        s0, [x24], #4
0x2b4e8  subs       x23, x23, #1
0x2b4ec  fadd       s3, s3, s0
0x2b4f0  b.ne       #0x2b4d0
0x2b4f4  cmp        w20, #1
0x2b4f8  b.lt       #0x2b55c
0x2b4fc  cmp        w20, #8
0x2b500  b.hs       #0x2b50c
0x2b504  mov        x8, xzr
0x2b508  b          #0x2b540
0x2b50c  and        x8, x22, #0xfffffff8
0x2b510  dup        v0.4s, v3.s[0]
0x2b514  add        x9, x21, #0x10
0x2b518  mov        x10, x8
0x2b51c  ldp        q1, q2, [x9, #-0x10]
0x2b520  subs       x10, x10, #8
0x2b524  fdiv       v1.4s, v1.4s, v0.4s
0x2b528  fdiv       v2.4s, v2.4s, v0.4s
0x2b52c  stp        q1, q2, [x9, #-0x10]
0x2b530  add        x9, x9, #0x20
0x2b534  b.ne       #0x2b51c
0x2b538  cmp        x8, x22
0x2b53c  b.eq       #0x2b55c
0x2b540  add        x9, x21, x8, lsl #2
0x2b544  sub        x8, x22, x8
0x2b548  ldr        s0, [x9]
0x2b54c  subs       x8, x8, #1
0x2b550  fdiv       s0, s0, s3
0x2b554  str        s0, [x9], #4
0x2b558  b.ne       #0x2b548
0x2b55c  cmp        w20, w19
0x2b560  b.ge       #0x2b580
0x2b564  mvn        w8, w20
0x2b568  add        w8, w8, w19
0x2b56c  lsl        x8, x8, #2
0x2b570  add        x0, x21, w20, sxtw #2
0x2b574  add        x2, x8, #4
0x2b578  mov        w1, wzr
0x2b57c  bl         #0x49680    ; memset
0x2b580  ldp        x20, x19, [sp, #0x40]
0x2b584  ldp        x22, x21, [sp, #0x30]
0x2b588  ldp        x24, x23, [sp, #0x20]
0x2b58c  ldr        x30, [sp, #0x18]
0x2b590  ldr        d8, [sp, #0x10]
0x2b594  add        sp, sp, #0x50
0x2b598  ret        
0x2b59c  sub        sp, sp, #0x80
0x2b5a0  str        d8, [sp, #0x30]
0x2b5a4  stp        x30, x25, [sp, #0x40]
0x2b5a8  stp        x24, x23, [sp, #0x50]
0x2b5ac  stp        x22, x21, [sp, #0x60]
0x2b5b0  stp        x20, x19, [sp, #0x70]
0x2b5b4  mov        w21, w1
0x2b5b8  mov        x20, x0
0x2b5bc  sbfiz      x0, x21, #2, #0x20
0x2b5c0  bl         #0x494e0    ; malloc
0x2b5c4  cbz        x0, #0x2b620
0x2b5c8  mov        x19, x0
0x2b5cc  cmp        w21, #1
0x2b5d0  b.lt       #0x2b6bc
0x2b5d4  mov        w22, w21
0x2b5d8  fmov       s1, wzr
0x2b5dc  mov        x23, x22
0x2b5e0  mov        x24, x20
0x2b5e4  mov        x25, x19
0x2b5e8  str        q1, [sp, #0x20]
0x2b5ec  ldr        s0, [x24], #4
0x2b5f0  bl         #0x497f0    ; expf
0x2b5f4  ldr        q1, [sp, #0x20]
0x2b5f8  str        s0, [x25], #4
0x2b5fc  subs       x23, x23, #1
0x2b600  fadd       s1, s1, s0
0x2b604  b.ne       #0x2b5e8
0x2b608  cmp        w21, #1
0x2b60c  b.lt       #0x2b6bc
0x2b610  str        q1, [sp, #0x20]
0x2b614  b.ne       #0x2b63c
0x2b618  mov        x21, xzr
0x2b61c  b          #0x2b690
0x2b620  ldp        x20, x19, [sp, #0x70]
0x2b624  ldp        x22, x21, [sp, #0x60]
0x2b628  ldp        x24, x23, [sp, #0x50]
0x2b62c  ldp        x30, x25, [sp, #0x40]
0x2b630  ldr        d8, [sp, #0x30]
0x2b634  add        sp, sp, #0x80
0x2b638  ret        
0x2b63c  and        x21, x22, #0xfffffffe
0x2b640  dup        v8.2s, v1.s[0]
0x2b644  mov        x23, x21
0x2b648  mov        x24, x20
0x2b64c  mov        x25, x19
0x2b650  ldr        d0, [x25], #8
0x2b654  fdiv       v0.2s, v0.2s, v8.2s
0x2b658  str        q0, [sp]
0x2b65c  mov        s0, v0.s[1]
0x2b660  bl         #0x49c70    ; logf
0x2b664  str        d0, [sp, #0x10]
0x2b668  ldr        q0, [sp]
0x2b66c  bl         #0x49c70    ; logf
0x2b670  ldr        q1, [sp, #0x10]
0x2b674  subs       x23, x23, #2
0x2b678  mov        v0.s[1], v1.s[0]
0x2b67c  str        d0, [x24], #8
0x2b680  b.ne       #0x2b650
0x2b684  ldr        q1, [sp, #0x20]
0x2b688  cmp        x21, x22
0x2b68c  b.eq       #0x2b6bc
0x2b690  lsl        x8, x21, #2
0x2b694  add        x20, x20, x8
0x2b698  add        x23, x19, x8
0x2b69c  sub        x21, x22, x21
0x2b6a0  ldr        s0, [x23], #4
0x2b6a4  fdiv       s0, s0, s1
0x2b6a8  bl         #0x49c70    ; logf
0x2b6ac  ldr        q1, [sp, #0x20]
0x2b6b0  subs       x21, x21, #1
0x2b6b4  str        s0, [x20], #4
0x2b6b8  b.ne       #0x2b6a0
0x2b6bc  mov        x0, x19
0x2b6c0  ldp        x20, x19, [sp, #0x70]
0x2b6c4  ldp        x22, x21, [sp, #0x60]
0x2b6c8  ldp        x24, x23, [sp, #0x50]
0x2b6cc  ldp        x30, x25, [sp, #0x40]
0x2b6d0  ldr        d8, [sp, #0x30]
0x2b6d4  add        sp, sp, #0x80
0x2b6d8  b          #0x494f0    ; free
0x2b6dc  sub        sp, sp, #0x70
0x2b6e0  stp        x29, x30, [sp, #0x10]
0x2b6e4  stp        x28, x27, [sp, #0x20]
0x2b6e8  stp        x26, x25, [sp, #0x30]
0x2b6ec  stp        x24, x23, [sp, #0x40]
0x2b6f0  stp        x22, x21, [sp, #0x50]
0x2b6f4  stp        x20, x19, [sp, #0x60]
0x2b6f8  ldrsw      x27, [sp, #0x70]
0x2b6fc  ldr        w8, [sp, #0x78]
0x2b700  sub        w9, w5, #1
0x2b704  mul        w9, w9, w7
0x2b708  ldr        x26, [sp, #0x80]
0x2b70c  mvn        w9, w9
0x2b710  add        w11, w27, w3
0x2b714  mov        x19, x0
0x2b718  smull      x10, w3, w4
0x2b71c  add        w9, w11, w9
0x2b720  mul        w11, w27, w4
0x2b724  mov        x25, x1
0x2b728  add        x0, x0, w11, sxtw #2
0x2b72c  add        w8, w9, w8
0x2b730  lsl        x2, x10, #2
0x2b734  mov        x1, x19
0x2b738  mov        w24, w7
0x2b73c  mov        w22, w6
0x2b740  mov        w21, w5
0x2b744  mov        w23, w4
0x2b748  sdiv       w28, w8, w6
0x2b74c  bl         #0x49890    ; memmove
0x2b750  sbfiz      x20, x23, #2, #0x20
0x2b754  mul        x2, x20, x27
0x2b758  mov        x0, x19
0x2b75c  mov        x1, x25
0x2b760  bl         #0x496d0    ; memcpy
0x2b764  cmp        w24, #1
0x2b768  str        w28, [sp, #4]
0x2b76c  b.ne       #0x2b7b8
0x2b770  tbnz       w28, #0x1f, #0x2b840
0x2b774  ldr        w9, [sp, #4]
0x2b778  sxtw       x8, w21
0x2b77c  mov        w24, wzr
0x2b780  mov        w25, wzr
0x2b784  add        w27, w9, #1
0x2b788  mul        w22, w22, w23
0x2b78c  mul        x20, x20, x8
0x2b790  mul        w21, w21, w23
0x2b794  add        x0, x26, w24, sxtw #2
0x2b798  add        x1, x19, w25, sxtw #2
0x2b79c  mov        x2, x20
0x2b7a0  bl         #0x496d0    ; memcpy
0x2b7a4  add        w25, w25, w22
0x2b7a8  subs       x27, x27, #1
0x2b7ac  add        w24, w24, w21
0x2b7b0  b.ne       #0x2b794
0x2b7b4  b          #0x2b840
0x2b7b8  tbnz       w28, #0x1f, #0x2b840
0x2b7bc  cmp        w21, #1
0x2b7c0  b.lt       #0x2b840
0x2b7c4  ldr        w11, [sp, #4]
0x2b7c8  sxtw       x8, w23
0x2b7cc  sxtw       x9, w24
0x2b7d0  sxtw       x10, w22
0x2b7d4  mov        w24, w21
0x2b7d8  add        w11, w11, #1
0x2b7dc  str        x11, [sp, #8]
0x2b7e0  mul        x11, x8, x24
0x2b7e4  mul        x10, x10, x8
0x2b7e8  mul        x8, x9, x8
0x2b7ec  mov        x25, xzr
0x2b7f0  lsl        x28, x11, #2
0x2b7f4  lsl        x29, x10, #2
0x2b7f8  lsl        x27, x8, #2
0x2b7fc  mov        x23, x24
0x2b800  mov        x21, x19
0x2b804  mov        x22, x26
0x2b808  mov        x0, x22
0x2b80c  mov        x1, x21
0x2b810  mov        x2, x20
0x2b814  bl         #0x496d0    ; memcpy
0x2b818  add        x22, x22, x20
0x2b81c  subs       x23, x23, #1
0x2b820  add        x21, x21, x27
0x2b824  b.ne       #0x2b808
0x2b828  ldr        x8, [sp, #8]
0x2b82c  add        x25, x25, #1
0x2b830  add        x26, x26, x28
0x2b834  add        x19, x19, x29
0x2b838  cmp        x25, x8
0x2b83c  b.ne       #0x2b7fc
0x2b840  ldr        w8, [sp, #4]
0x2b844  ldp        x20, x19, [sp, #0x60]
0x2b848  ldp        x22, x21, [sp, #0x50]
0x2b84c  ldp        x24, x23, [sp, #0x40]
0x2b850  ldp        x26, x25, [sp, #0x30]
0x2b854  ldp        x28, x27, [sp, #0x20]
0x2b858  ldp        x29, x30, [sp, #0x10]
0x2b85c  add        w0, w8, #1
0x2b860  add        sp, sp, #0x70
0x2b864  ret        
0x2b868  sub        sp, sp, #0x30
0x2b86c  stp        x30, x21, [sp, #0x10]
0x2b870  stp        x20, x19, [sp, #0x20]
0x2b874  mov        x19, x0
0x2b878  str        x1, [x0, #0x30]
0x2b87c  str        wzr, [x0, #4]
0x2b880  mov        w0, #0x30
0x2b884  mov        x20, x1
0x2b888  bl         #0x49500    ; _Znwm
0x2b88c  mov        w2, #7
0x2b890  mov        w3, #1
0x2b894  mov        w4, #0x64
0x2b898  mov        w5, #0x200
0x2b89c  mov        x1, x20
0x2b8a0  mov        x21, x0
0x2b8a4  bl         #0x49cd0    ; _ZN6Conv1dC1EP12Conv1dParamsiiii
0x2b8a8  mov        w0, #0x30
0x2b8ac  str        x21, [x19, #0x38]
0x2b8b0  bl         #0x49500    ; _Znwm
0x2b8b4  add        x1, x20, #0x10
0x2b8b8  mov        w2, #0x28
0x2b8bc  mov        w3, #1
0x2b8c0  mov        w4, #1
0x2b8c4  mov        w5, #0x100
0x2b8c8  mov        x21, x0
0x2b8cc  bl         #0x49cd0    ; _ZN6Conv1dC1EP12Conv1dParamsiiii
0x2b8d0  mov        w0, #0x48
0x2b8d4  str        x21, [x19, #0x40]
0x2b8d8  bl         #0x49500    ; _Znwm
0x2b8dc  add        x1, x20, #0x40
0x2b8e0  mov        w2, #6
0x2b8e4  mov        w3, #1
0x2b8e8  mov        w4, #0x100
0x2b8ec  mov        w5, #0x200
0x2b8f0  mov        w6, #1
0x2b8f4  mov        x21, x0
0x2b8f8  bl         #0x4a050    ; _ZN9UpSamplerC1EP15UpSamplerParamsiiiii
0x2b8fc  mov        w0, #0x30
0x2b900  str        x21, [x19, #0x58]
0x2b904  bl         #0x49500    ; _Znwm
0x2b908  add        x1, x20, #0x20
0x2b90c  mov        w2, #8
0x2b910  mov        w3, #1
0x2b914  mov        w4, #1
0x2b918  mov        w5, #0x80
0x2b91c  mov        x21, x0
0x2b920  bl         #0x49cd0    ; _ZN6Conv1dC1EP12Conv1dParamsiiii
0x2b924  mov        w0, #0x48
0x2b928  str        x21, [x19, #0x48]
0x2b92c  bl         #0x49500    ; _Znwm
0x2b930  add        x1, x20, #0xd0
0x2b934  mov        w2, #0xa
0x2b938  mov        w3, #1
0x2b93c  mov        w4, #0x80
0x2b940  mov        w5, #0x100
0x2b944  mov        w6, #3
0x2b948  mov        x21, x0
0x2b94c  bl         #0x4a050    ; _ZN9UpSamplerC1EP15UpSamplerParamsiiiii
0x2b950  mov        w0, #0x30
0x2b954  str        x21, [x19, #0x60]
0x2b958  bl         #0x49500    ; _Znwm
0x2b95c  add        x1, x20, #0x30
0x2b960  mov        w2, #1
0x2b964  mov        w3, #1
0x2b968  mov        w4, #1
0x2b96c  mov        w5, #0x40
0x2b970  mov        x21, x0
0x2b974  bl         #0x49cd0    ; _ZN6Conv1dC1EP12Conv1dParamsiiii
0x2b978  mov        w0, #0x48
0x2b97c  str        x21, [x19, #0x50]
0x2b980  bl         #0x49500    ; _Znwm
0x2b984  add        x1, x20, #0x160
0x2b988  mov        w2, #8
0x2b98c  mov        w3, #1
0x2b990  mov        w4, #0x40
0x2b994  mov        w5, #0x80
0x2b998  mov        w6, #0xf
0x2b99c  mov        x21, x0
0x2b9a0  bl         #0x4a050    ; _ZN9UpSamplerC1EP15UpSamplerParamsiiiii
0x2b9a4  mov        w0, #0x30
0x2b9a8  str        x21, [x19, #0x68]
0x2b9ac  bl         #0x49500    ; _Znwm
0x2b9b0  mov        w2, #7
0x2b9b4  mov        w3, #1
0x2b9b8  mov        w4, #0x40
0x2b9bc  mov        w5, #0x12
0x2b9c0  mov        x1, x20
0x2b9c4  mov        x21, x0
0x2b9c8  bl         #0x49cd0    ; _ZN6Conv1dC1EP12Conv1dParamsiiii
0x2b9cc  mov        w0, #0x30
0x2b9d0  str        x21, [x19, #0x70]
0x2b9d4  bl         #0x49500    ; _Znwm
0x2b9d8  add        x1, x20, #0x200
0x2b9dc  mov        w2, #0x10
0x2b9e0  mov        w3, #1
0x2b9e4  mov        w4, #1
0x2b9e8  mov        w5, #0x12
0x2b9ec  mov        w6, #1
0x2b9f0  mov        w7, #0x10
0x2b9f4  mov        x21, x0
0x2b9f8  bl         #0x49e90    ; _ZN8DeConv1dC1EP14DeConv1dParamsiiiiii
0x2b9fc  ldr        x0, [x19, #0x38]
0x2ba00  str        x21, [x19, #0x78]
0x2ba04  str        wzr, [x19]
0x2ba08  bl         #0x49ce0    ; _ZN6Conv1d11get_memsizeEv
0x2ba0c  ldr        w9, [x19]
0x2ba10  ldr        x8, [x19, #0x58]
0x2ba14  add        w9, w9, w0
0x2ba18  mov        x0, x8
0x2ba1c  str        w9, [x19]
0x2ba20  bl         #0x4a060    ; _ZN9UpSampler11get_memsizeEv
0x2ba24  ldr        w9, [x19]
0x2ba28  ldr        x8, [x19, #0x60]
0x2ba2c  add        w9, w9, w0
0x2ba30  mov        x0, x8
0x2ba34  str        w9, [x19]
0x2ba38  bl         #0x4a060    ; _ZN9UpSampler11get_memsizeEv
0x2ba3c  ldr        w9, [x19]
0x2ba40  ldr        x8, [x19, #0x68]
0x2ba44  add        w9, w9, w0
0x2ba48  mov        x0, x8
0x2ba4c  str        w9, [x19]
0x2ba50  bl         #0x4a060    ; _ZN9UpSampler11get_memsizeEv
0x2ba54  ldr        w9, [x19]
0x2ba58  ldr        x8, [x19, #0x70]
0x2ba5c  add        w9, w9, w0
0x2ba60  mov        x0, x8
0x2ba64  str        w9, [x19]
0x2ba68  bl         #0x49ce0    ; _ZN6Conv1d11get_memsizeEv
0x2ba6c  ldr        w9, [x19]
0x2ba70  ldr        x8, [x19, #0x78]
0x2ba74  add        w9, w9, w0
0x2ba78  mov        x0, x8
0x2ba7c  str        w9, [x19]
0x2ba80  bl         #0x49ea0    ; _ZN8DeConv1d11get_memsizeEv
0x2ba84  ldr        w8, [x19]
0x2ba88  add        w8, w8, w0
0x2ba8c  mov        w0, #0x28
0x2ba90  str        w8, [x19]
0x2ba94  bl         #0x49500    ; _Znwm
0x2ba98  adrp       x8, #0xe000
0x2ba9c  ldr        q0, [x8, #0x6c0]
0x2baa0  mov        w21, #0xf040
0x2baa4  mov        w1, #0xc100
0x2baa8  mov        x20, x0
0x2baac  str        w21, [x0, #0x20]
0x2bab0  str        q0, [x0, #0x10]
0x2bab4  str        w21, [x0]
0x2bab8  mov        w0, #0x40
0x2babc  movk       w1, #3, lsl #16
0x2bac0  str        q0, [sp]
0x2bac4  bl         #0x49560    ; _Z14aligned_mallocmm
0x2bac8  str        x0, [x20, #8]
0x2bacc  mov        w0, #0x28
0x2bad0  str        x20, [x19, #8]
0x2bad4  bl         #0x49500    ; _Znwm
0x2bad8  ldr        q0, [sp]
0x2badc  mov        w1, #0xc100
0x2bae0  mov        x20, x0
0x2bae4  str        w21, [x0, #0x20]
0x2bae8  str        q0, [x0, #0x10]
0x2baec  str        w21, [x0]
0x2baf0  mov        w0, #0x40
0x2baf4  movk       w1, #3, lsl #16
0x2baf8  bl         #0x49560    ; _Z14aligned_mallocmm
0x2bafc  str        x0, [x20, #8]
0x2bb00  mov        w0, #0x28
0x2bb04  str        x20, [x19, #0x10]
0x2bb08  bl         #0x49500    ; _Znwm
0x2bb0c  adrp       x8, #0xe000
0x2bb10  ldr        q0, [x8, #0x7e0]
0x2bb14  mov        w8, #0x25f8
0x2bb18  mov        x20, x0
0x2bb1c  str        w8, [x0, #0x20]
0x2bb20  str        q0, [x0, #0x10]
0x2bb24  str        w8, [x0]
0x2bb28  mov        w0, #0x40
0x2bb2c  mov        w1, #0x97e0
0x2bb30  bl         #0x49560    ; _Z14aligned_mallocmm
0x2bb34  str        x0, [x20, #8]
0x2bb38  mov        w0, #0x28
0x2bb3c  str        x20, [x19, #0x18]
0x2bb40  bl         #0x49500    ; _Znwm
0x2bb44  adrp       x8, #0xe000
0x2bb48  ldr        q0, [x8, #0x6a0]
0x2bb4c  mov        w8, #0x3800
0x2bb50  movk       w8, #4, lsl #16
0x2bb54  mov        w1, #0xe000
0x2bb58  mov        x20, x0
0x2bb5c  str        w8, [x0, #0x20]
0x2bb60  str        q0, [x0, #0x10]
0x2bb64  str        w8, [x0]
0x2bb68  mov        w0, #0x40
0x2bb6c  movk       w1, #0x10, lsl #16
0x2bb70  bl         #0x49560    ; _Z14aligned_mallocmm
0x2bb74  str        x0, [x20, #8]
0x2bb78  mov        w0, #0x28
0x2bb7c  str        x20, [x19, #0x20]
0x2bb80  bl         #0x49500    ; _Znwm
0x2bb84  adrp       x8, #0xe000
0x2bb88  ldr        q0, [x8, #0x710]
0x2bb8c  mov        w8, #9
0x2bb90  mov        x20, x0
0x2bb94  str        w8, [x0, #0x20]
