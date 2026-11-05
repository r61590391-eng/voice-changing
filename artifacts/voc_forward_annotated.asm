   +0 sub       sp, sp, #0x90
   +4 stp       d9, d8, [sp, #0x20]
   +8 stp       x29, x30, [sp, #0x30]
  +12 stp       x28, x27, [sp, #0x40]
  +16 stp       x26, x25, [sp, #0x50]
  +20 stp       x24, x23, [sp, #0x60]
  +24 stp       x22, x21, [sp, #0x70]
  +28 stp       x20, x19, [sp, #0x80]
  +32 ldr       x22, [x0, #0x10]
  +36 ldr       x23, [x1]
  +40 mov       x19, x3
  +44 mov       x20, x0
  +48 ldr       w1, [x22]
  +52 ldr       w8, [x23, #0x20]
  +56 mov       x21, x2
  +60 cmp       w1, w8
  +64 b.ge      #0x2c4e4
  +68 ldr       w2, [x22, #0x20]
  +72 adrp      x0, #0xf000
  +76 add       x0, x0, #0x22f
  +80 bl        #0x496c0    ; printf
  +84 ldr       w8, [x23, #0x20]
  +88 ldr       x0, [x22, #8]
  +92 ldr       x1, [x23, #8]
  +96 sbfiz     x2, x8, #2, #0x20
 +100 bl        #0x496d0    ; memcpy
 +104 ldp       w8, w9, [x23, #0x10]
 +108 ldp       w10, w11, [x23, #0x18]
 +112 ldr       w1, [x22]
 +116 stp       w8, w9, [x22, #0x10]
 +120 mul       w8, w9, w8
 +124 mul       w8, w8, w10
 +128 mul       w2, w8, w11
 +132 cmp       w1, w2
 +136 stp       w10, w11, [x22, #0x18]
 +140 str       w2, [x22, #0x20]
 +144 b.ge      #0x2c52c
 +148 adrp      x0, #0xe000
 +152 add       x0, x0, #0xed3
 +156 bl        #0x496c0    ; printf
 +160 ldr       x0, [x20, #0x18]
 +164 ldr       x1, [x21]
 +168 mov       w2, #0x3c
 +172 bl        #0x4a0c0    ; Tensor::upsample
 +176 ldr       x0, [x20, #0x18]
 +180 ldr       x2, [x20, #0x28]
 +184 mov       x1, x0
 +188 bl        #0x4a0d0    ; sinegen
 +192 ldr       x0, [x20, #0x38]
 +196 ldr       x1, [x20, #0x10]
 +200 mov       w2, #1
 +204 bl        #0x49d20    ; Conv1d::forward
 +208 ldp       x22, x21, [x20, #0x18]
 +212 ldr       w1, [x21]
 +216 ldr       w8, [x22, #0x20]
 +220 cmp       w1, w8
 +224 b.ge      #0x2c584
 +228 ldr       w2, [x21, #0x20]
 +232 adrp      x0, #0xf000
 +236 add       x0, x0, #0x22f
 +240 bl        #0x496c0    ; printf
 +244 ldr       w8, [x22, #0x20]
 +248 ldr       x0, [x21, #8]
 +252 ldr       x1, [x22, #8]
 +256 sbfiz     x2, x8, #2, #0x20
 +260 bl        #0x496d0    ; memcpy
 +264 ldp       w8, w9, [x22, #0x10]
 +268 ldp       w10, w11, [x22, #0x18]
 +272 ldr       w1, [x21]
 +276 stp       w8, w9, [x21, #0x10]
 +280 mul       w8, w9, w8
 +284 mul       w8, w8, w10
 +288 mul       w2, w8, w11
 +292 cmp       w1, w2
 +296 stp       w10, w11, [x21, #0x18]
 +300 str       w2, [x21, #0x20]
 +304 b.ge      #0x2c5cc
 +308 adrp      x0, #0xe000
 +312 add       x0, x0, #0xed3
 +316 bl        #0x496c0    ; printf
 +320 ldr       x0, [x20, #0x40]
 +324 ldr       x1, [x20, #0x20]
 +328 mov       w2, #0x14
 +332 bl        #0x49d20    ; Conv1d::forward
 +336 ldr       x0, [x20, #0x58]
 +340 ldr       x1, [x20, #0x10]
 +344 ldr       x2, [x20, #0x20]
 +348 bl        #0x4a0e0    ; UpSampler::forward
 +352 ldp       x22, x21, [x20, #0x18]
 +356 ldr       w1, [x21]
 +360 ldr       w8, [x22, #0x20]
 +364 cmp       w1, w8
 +368 b.ge      #0x2c614
 +372 ldr       w2, [x21, #0x20]
 +376 adrp      x0, #0xf000
 +380 add       x0, x0, #0x22f
 +384 bl        #0x496c0    ; printf
 +388 ldr       w8, [x22, #0x20]
 +392 ldr       x0, [x21, #8]
 +396 ldr       x1, [x22, #8]
 +400 sbfiz     x2, x8, #2, #0x20
 +404 bl        #0x496d0    ; memcpy
 +408 ldp       w8, w9, [x22, #0x10]
 +412 ldp       w10, w11, [x22, #0x18]
 +416 ldr       w1, [x21]
 +420 stp       w8, w9, [x21, #0x10]
 +424 mul       w8, w9, w8
 +428 mul       w8, w8, w10
 +432 mul       w2, w8, w11
 +436 cmp       w1, w2
 +440 stp       w10, w11, [x21, #0x18]
 +444 str       w2, [x21, #0x20]
 +448 b.ge      #0x2c65c
 +452 adrp      x0, #0xe000
 +456 add       x0, x0, #0xed3
 +460 bl        #0x496c0    ; printf
 +464 ldr       x0, [x20, #0x48]
 +468 ldr       x1, [x20, #0x20]
 +472 mov       w2, #4
 +476 bl        #0x49d20    ; Conv1d::forward
 +480 ldr       x0, [x20, #0x60]
 +484 ldr       x1, [x20, #0x10]
 +488 ldr       x2, [x20, #0x20]
 +492 bl        #0x4a0e0    ; UpSampler::forward
 +496 ldp       x22, x21, [x20, #0x18]
 +500 ldr       w1, [x21]
 +504 ldr       w8, [x22, #0x20]
 +508 cmp       w1, w8
 +512 b.ge      #0x2c6a4
 +516 ldr       w2, [x21, #0x20]
 +520 adrp      x0, #0xf000
 +524 add       x0, x0, #0x22f
 +528 bl        #0x496c0    ; printf
 +532 ldr       w8, [x22, #0x20]
 +536 ldr       x0, [x21, #8]
 +540 ldr       x1, [x22, #8]
 +544 sbfiz     x2, x8, #2, #0x20
 +548 bl        #0x496d0    ; memcpy
 +552 ldp       w8, w9, [x22, #0x10]
 +556 ldp       w10, w11, [x22, #0x18]
 +560 ldr       w1, [x21]
 +564 stp       w8, w9, [x21, #0x10]
 +568 mul       w8, w9, w8
 +572 mul       w8, w8, w10
 +576 mul       w2, w8, w11
 +580 cmp       w1, w2
 +584 stp       w10, w11, [x21, #0x18]
 +588 str       w2, [x21, #0x20]
 +592 b.ge      #0x2c6ec
 +596 adrp      x0, #0xe000
 +600 add       x0, x0, #0xed3
 +604 bl        #0x496c0    ; printf
 +608 ldr       x0, [x20, #0x50]
 +612 ldr       x1, [x20, #0x20]
 +616 mov       w2, #1
 +620 bl        #0x49d20    ; Conv1d::forward
 +624 ldr       x0, [x20, #0x68]
 +628 ldr       x1, [x20, #0x10]
 +632 ldr       x2, [x20, #0x20]
 +636 bl        #0x4a0e0    ; UpSampler::forward
 +640 ldr       x8, [x20, #0x10]
 +644 ldr       w10, [x8, #0x20]
 +648 cmp       w10, #0
 +652 b.le      #0x2c75c
 +656 mov       w11, #0xcccd
 +660 mov       x9, xzr
 +664 movk      w11, #0x3e4c, lsl #16
 +668 b         #0x2c738
 +672 add       x9, x9, #1
 +676 cmp       x9, w10, sxtw
 +680 b.ge      #0x2c75c
 +684 ldr       x12, [x8, #8]
 +688 ldr       s0, [x12, x9, lsl #2]
 +692 fcmp      s0, #0.0
 +696 b.pl      #0x2c72c
 +700 fmov      s1, w11
 +704 fmul      s0, s0, s1
 +708 str       s0, [x12, x9, lsl #2]
 +712 ldr       w10, [x8, #0x20]
 +716 b         #0x2c72c
 +720 ldr       w8, [x20, #4]
 +724 ldr       x21, [x20, #8]
 +728 cbz       w8, #0x2c7dc
 +732 ldr       x22, [x20, #0x10]
 +736 ldr       w1, [x21]
 +740 ldr       w8, [x22, #0x20]
 +744 cmp       w1, w8
 +748 b.ge      #0x2c790
 +752 ldr       w2, [x21, #0x20]
 +756 adrp      x0, #0xf000
 +760 add       x0, x0, #0x22f
 +764 bl        #0x496c0    ; printf
 +768 ldr       w8, [x22, #0x20]
 +772 ldr       x0, [x21, #8]
 +776 ldr       x1, [x22, #8]
 +780 sbfiz     x2, x8, #2, #0x20
 +784 bl        #0x496d0    ; memcpy
 +788 ldp       w8, w9, [x22, #0x10]
 +792 ldp       w10, w11, [x22, #0x18]
 +796 ldr       w1, [x21]
 +800 stp       w8, w9, [x21, #0x10]
 +804 mul       w8, w9, w8
 +808 mul       w8, w8, w10
 +812 mul       w2, w8, w11
 +816 cmp       w1, w2
 +820 stp       w10, w11, [x21, #0x18]
 +824 str       w2, [x21, #0x20]
 +828 b.ge      #0x2c858
 +832 adrp      x0, #0xe000
 +836 add       x0, x0, #0xed3
 +840 bl        #0x496c0    ; printf
 +844 b         #0x2c858
 +848 ldr       x8, [x20, #0x10]
 +852 ldr       x0, [x21, #8]
 +856 ldrsw     x9, [x8, #0x1c]
 +860 ldr       x8, [x8, #8]
 +864 lsl       x2, x9, #2
 +868 add       x1, x8, x2
 +872 bl        #0x496d0    ; memcpy
 +876 ldp       x8, x9, [x20, #8]
 +880 ldr       x8, [x8, #8]
 +884 ldpsw     x10, x11, [x9, #0x1c]
 +888 ldr       x1, [x9, #8]
 +892 add       x0, x8, x10, lsl #2
 +896 lsl       x2, x11, #2
 +900 bl        #0x496d0    ; memcpy
 +904 ldp       x9, x8, [x20, #8]
 +908 ldp       w10, w11, [x8, #0x10]
 +912 ldp       w12, w8, [x8, #0x18]
 +916 ldr       w1, [x9]
 +920 stp       w10, w11, [x9, #0x10]
 +924 mul       w10, w11, w10
 +928 mul       w10, w10, w12
 +932 mul       w2, w10, w8
 +936 cmp       w1, w2
 +940 stp       w12, w8, [x9, #0x18]
 +944 str       w2, [x9, #0x20]
 +948 b.ge      #0x2c850
 +952 adrp      x0, #0xe000
 +956 add       x0, x0, #0xed3
 +960 bl        #0x496c0    ; printf
 +964 mov       w8, #1
 +968 str       w8, [x20, #4]
 +972 ldr       x0, [x20, #0x70]
 +976 ldr       x1, [x20, #8]
 +980 mov       w2, #1
 +984 bl        #0x49d20    ; Conv1d::forward
 +988 ldr       x21, [x20, #8]
 +992 ldp       w22, w23, [x21, #0x18]
 +996 cmp       w23, #0
+1000 cinc      w8, w23, lt
+1004 cmp       w22, #1
+1008 b.lt      #0x2c928
+1012 cmp       w23, #2
+1016 b.lt      #0x2c928
+1020 adrp      x9, #0xe000
+1024 ldr       d9, [x9, #0x580]
+1028 asr       w8, w8, #1
+1032 mov       x24, xzr
+1036 mov       x25, xzr
+1040 mov       w26, w8
+1044 stp       x20, x19, [sp, #8]
+1048 mov       x27, x24
+1052 mov       x28, x26
+1056 ldr       x29, [x21, #8]
+1060 lsl       x19, x27, #2
+1064 ldr       s0, [x29, x19]
+1068 bl        #0x497f0    ; expf
+1072 add       w8, w26, w27
+1076 sbfiz     x20, x8, #2, #0x20
+1080 ldr       s1, [x29, x20]
+1084 mov       v8.16b, v0.16b
+1088 mov       v0.16b, v1.16b
+1092 bl        #0x4a0a0    ; sinf
+1096 fcvt      d0, s0
+1100 fmul      d0, d0, d9
+1104 fcvt      s0, d0
+1108 add       x0, sp, #0x1c
+1112 add       x1, sp, #0x18
+1116 bl        #0x49c10    ; sincosf
+1120 ldp       s0, s1, [sp, #0x18]
+1124 subs      x28, x28, #1
+1128 add       x27, x27, #1
+1132 fmul      s0, s8, s0
+1136 str       s0, [x29, x19]
+1140 ldr       x8, [x21, #8]
+1144 fmul      s0, s8, s1
+1148 str       s0, [x8, x20]
+1152 b.ne      #0x2c8ac
+1156 add       x25, x25, #1
+1160 cmp       x25, x22
+1164 add       x24, x24, x23
+1168 b.ne      #0x2c8a4
+1172 ldp       w22, w23, [x21, #0x18]
+1176 ldp       x20, x19, [sp, #8]
+1180 ldp       w8, w9, [x21, #0x10]
+1184 ldr       w1, [x21]
+1188 mul       w10, w22, w23
+1192 stp       w22, w23, [x21, #0x18]
+1196 mul       w8, w10, w8
+1200 mul       w2, w8, w9
+1204 cmp       w1, w2
+1208 str       w2, [x21, #0x20]
+1212 b.ge      #0x2c958
+1216 adrp      x0, #0xe000
+1220 add       x0, x0, #0xed3
+1224 bl        #0x496c0    ; printf
+1228 ldr       x0, [x20, #0x78]
+1232 ldr       x1, [x20, #8]
+1236 bl        #0x49f30    ; DeConv1d::forward
+1240 ldr       x8, [x20, #8]
+1244 ldr       w0, [x8, #0x18]
+1248 cmp       w0, #1
+1252 b.lt      #0x2c9ac
+1256 adrp      x9, #0xe000
+1260 ldr       d0, [x9, #0x620]
+1264 mov       x9, xzr
+1268 ldr       x8, [x8, #8]
+1272 ldr       s1, [x8, x9, lsl #2]
+1276 fcvt      d1, s1
+1280 fmul      d1, d1, d0
+1284 fcvtzs    w8, d1
+1288 strh      w8, [x19, x9, lsl #1]
+1292 ldr       x8, [x20, #8]
+1296 add       x9, x9, #1
+1300 ldrsw     x0, [x8, #0x18]
+1304 cmp       x9, x0
+1308 b.lt      #0x2c980
+1312 ldp       x20, x19, [sp, #0x80]
+1316 ldp       x22, x21, [sp, #0x70]
+1320 ldp       x24, x23, [sp, #0x60]
+1324 ldp       x26, x25, [sp, #0x50]
+1328 ldp       x28, x27, [sp, #0x40]
+1332 ldp       x29, x30, [sp, #0x30]
+1336 ldp       d9, d8, [sp, #0x20]
+1340 add       sp, sp, #0x90
+1344 ret       