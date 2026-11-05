// vc_probe.c ? ???????????
// ?????????? linker ??(dlopen/dlsym/open/mmap/calloc/write/close)
typedef unsigned long size_t_;
typedef long ssize_t_;
typedef int jint;

extern void* dlopen(const char*, int);
extern void* dlsym(void*, const char*);
extern void* calloc(size_t_, size_t_);
extern void free(void*);
extern int open(const char*, int, ...);
extern int close(int);
extern long lseek(int, long, int);
extern ssize_t_ write(int, const void*, size_t_);
extern void* mmap(void*, size_t_, int, int, int, long);
extern int munmap(void*, size_t_);
extern ssize_t_ read(int, void*, size_t_);
extern double sin(double);

#define O_RDONLY 0
#define PROT_READ 1
#define MAP_PRIVATE 2
#define SEEK_END 2
#define RTLD_NOW 2
#define RTLD_GLOBAL 0x100
#define RTLD_DEFAULT ((void*)0)
#define JNIEXPORT
#define JNICALL

typedef unsigned char u8;
typedef int (*GM)(void*);
typedef void (*C2)(void*, void*, int);

static u8* g_buf; static size_t_ g_len;
static int g_out;

static void W(const char* s) { int n = 0; while (s[n]) n++; write(g_out, s, n); }
static void WNUM(long v) {
    char b[24]; int i = 23; b[i--] = 0;
    int neg = v < 0; unsigned long x = neg ? -(long)v : (unsigned long)v;
    if (!x) b[i--] = '0';
    while (x) { b[i--] = '0' + x % 10; x /= 10; }
    if (neg) b[i--] = '-';
    write(g_out, b + i + 1, 22 - i);
}

static int mapf(const char* p) {
    int fd = open(p, O_RDONLY);
    if (fd < 0) return -1;
    g_len = (size_t_)lseek(fd, 0, SEEK_END);
    lseek(fd, 0, 0);
    g_buf = (u8*)calloc(1, g_len + 4096);   // ??! ???????
    if (!g_buf) { close(fd); return -1; }
    ssize_t_ total = 0;
    while (total < (ssize_t_)g_len) {
        ssize_t_ r = read(fd, g_buf + total, g_len - total);
        if (r <= 0) break;
        total += r;
    }
    close(fd);
    return total == (ssize_t_)g_len ? 0 : -1;
}

// JNI: env ???????????; GetStringUTFChars = ?[169]
typedef struct { const void** fns; } JNIEnv_;

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runProbe(JNIEnv_* env, void* clazz,
        void* jam, void* jbn, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 iscopy = 0;
    const char* am  = gch(env, jam,  &iscopy);
    const char* bn  = gch(env, jbn,  &iscopy);
    const char* voc = gch(env, jvoc, &iscopy);
    const char* out = gch(env, jout, &iscopy);

    void* h = dlopen("libdubbing_sdk_android.so", RTLD_NOW | RTLD_GLOBAL);
    if (!h) return -10;

    GM m_am  = (GM)dlsym(h, "_ZN8amengine11get_memsizeEv");
    C2 c_am  = (C2)dlsym(h, "_ZN8amengineC1EPvi");
    GM m_bn  = (GM)dlsym(h, "_ZN8bnengine11get_memsizeEv");
    C2 c_bn  = (C2)dlsym(h, "_ZN8bnengineC1EPvi");
    GM m_voc = (GM)dlsym(h, "_ZN9vocengine11get_memsizeEv");
    C2 c_voc = (C2)dlsym(h, "_ZN9vocengineC1EPvi");
    if (!m_am || !c_am || !m_bn || !c_bn || !m_voc || !c_voc) return -11;

    g_out = open(out, 0x41 /*O_WRONLY|O_CREAT*/, 0666);
    if (g_out < 0) return -12;

    // ??: voc_file(14.5MB float32)->amengine? am_file(34MB)->bnengine, voc(21.6MB)->amengine
    // ?? 6 ?????, ?????????
    struct { const char* path; const char* name; } fs[3] = {
        { am, "f34M_838e" }, { bn, "f14M_97a6" }, { voc, "f21M_a4d4" } };
    for (int i = 0; i < 3; i++) {
        if (mapf(fs[i].path) != 0) { W("MAPFAIL "); W(fs[i].name); W("\n"); continue; }
        // ????????????(???????)
        u8* backup = (u8*)calloc(1, g_len);
        for (size_t_ k = 0; k < g_len; k++) backup[k] = g_buf[k];
        for (int mode = 0; mode < 2; mode++) {
            long ra = -1, rb = -1, rv = -1;
            if (g_len >= 21647360) {   // amengine ??????
                void* o = calloc(1, 8192);
                c_am(o, g_buf, mode);  ra = m_am(o);  free(o);
                for (size_t_ k = 0; k < g_len; k++) g_buf[k] = backup[k];
            }
            if (g_len >= 34346176) {   // bnengine ??????
                void* o = calloc(1, 8192);
                c_bn(o, g_buf, mode);  rb = m_bn(o);  free(o);
                for (size_t_ k = 0; k < g_len; k++) g_buf[k] = backup[k];
            }
            {
                void* o = calloc(1, 8192);
                c_voc(o, g_buf, mode); rv = m_voc(o); free(o);
                for (size_t_ k = 0; k < g_len; k++) g_buf[k] = backup[k];
            }
            W(fs[i].name); W(" mode="); WNUM(mode); W(" size="); WNUM((long)g_len);
            W(" am="); WNUM(ra); W(" bn="); WNUM(rb); W(" voc="); WNUM(rv); W("\n");
        }
        free(backup); free(g_buf);
    }
    close(g_out);
    return 0;
}







// ============ ???? ============
typedef void (*C3)(void*, void*, int, int, int);
typedef void (*C2I)(void*, void*, int, int);
typedef void (*C4)(void*, void*, int, int, int, int);
typedef void (*C6)(void*, void*, int, int, int, int, int, int);
typedef void (*CPE)(void*, void*, int, void*, int, int, int, int);
typedef void (*CLN)(void*, void*, float, int);

static void* PE_;

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runLayers(JNIEnv_* env, void* clazz, void* jpath, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* path = gch(env, jpath, &ic);
    const char* outp = gch(env, jout, &ic);
    if (mapf(path) != 0) return -1;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) { W("NO_SDK\n"); return -3; }
    void* obj; long r;

    // PositionEncoding(this, a, b, c) ? ?? buffer
    void* peCtor = dlsym(h, "_ZN16PositionEncodingC1Eiii");
    PE_ = calloc(1, 4096);
    ((void(*)(void*,int,int,int))peCtor)(PE_, 360, 192, 0);

    // EmbedLayer(this, buf, dim)
    { void* ct = dlsym(h, "_ZN10EmbedLayerC1EPvi"); void* gm = dlsym(h, "_ZN10EmbedLayer11get_memsizeEv");
      int d[] = {192,256};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int))ct)(obj, g_buf, d[i]); r = ((GM)gm)(obj); free(obj);
        W("EmbedLayer_"); WNUM(d[i]); W("="); WNUM(r); W("\n"); } }
    // Prenet(this, buf, flag, a, b)
    { void* ct = dlsym(h, "_ZN6PrenetC1EPviii"); void* gm = dlsym(h, "_ZN6Prenet11get_memsizeEv");
      int cs[4][2] = {{513,256},{192,192},{60,192},{100,256}};
      for (int i = 0; i < 4; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int))ct)(obj, g_buf, 0, cs[i][0], cs[i][1]); r = ((GM)gm)(obj); free(obj);
        W("Prenet_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // Linear(this, buf, flag, in, out)
    { void* ct = dlsym(h, "_ZN6LinearC1EPviii"); void* gm = dlsym(h, "_ZN6Linear11get_memsizeEv");
      int cs[3][2] = {{1,192},{192,192},{100,1024}};
      for (int i = 0; i < 3; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int))ct)(obj, g_buf, 0, cs[i][0], cs[i][1]); r = ((GM)gm)(obj); free(obj);
        W("Linear_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // EncSelfAttn(this, buf, PE, h, hd, dim)
    { void* ct = dlsym(h, "_ZN11EncSelfAttnC1EPvP16PositionEncodingiii"); void* gm = dlsym(h, "_ZN11EncSelfAttn11get_memsizeEv");
      int cs[2][3] = {{2,96,192},{4,64,256}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,void*,int,int,int))ct)(obj, g_buf, PE_, cs[i][0], cs[i][1], cs[i][2]); r = ((GM)gm)(obj); free(obj);
        W("Attn_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // FeedForward(this, buf, flag, dim, ff)
    { void* ct = dlsym(h, "_ZN11FeedForwardC1EPviii"); void* gm = dlsym(h, "_ZN11FeedForward11get_memsizeEv");
      int cs[2][2] = {{192,1024},{256,2048}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int))ct)(obj, g_buf, 1, cs[i][0], cs[i][1]); r = ((GM)gm)(obj); free(obj);
        W("FF_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // ConvModule(this, buf, mode, dim)
    { void* ct = dlsym(h, "_ZN10ConvModuleC1EPvii"); void* gm = dlsym(h, "_ZN10ConvModule11get_memsizeEv");
      int d[2] = {192,256};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int))ct)(obj, g_buf, 0, d[i]); r = ((GM)gm)(obj); free(obj);
        W("CM_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // LayerNorm(this, buf, eps, dim) / StyleLayerNorm
    { void* ct = dlsym(h, "_ZN9LayerNormC1EPvfi"); void* gm = dlsym(h, "_ZN9LayerNorm11get_memsizeEv");
      int d[2] = {192,256};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,float,int))ct)(obj, g_buf, 1e-5f, d[i]); r = ((GM)gm)(obj); free(obj);
        W("LN_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    { void* ct = dlsym(h, "_ZN14StyleLayerNormC1EPvfi"); void* gm = dlsym(h, "_ZN14StyleLayerNorm11get_memsizeEv");
      int d[2] = {192,256};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,float,int))ct)(obj, g_buf, 1e-5f, d[i]); r = ((GM)gm)(obj); free(obj);
        W("SLN_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // SubEncoder / SubStyleEncoder(this, buf, mode, PE, h, hd, dim, ff)
    { void* ct = dlsym(h, "_ZN10SubEncoderC1EPviP16PositionEncodingiiii"); void* gm = dlsym(h, "_ZN10SubEncoder11get_memsizeEv");
      int cs[2][4] = {{2,96,192,1024},{4,64,256,2048}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,void*,int,int,int,int))ct)(obj, g_buf, 0, PE_, cs[i][0], cs[i][1], cs[i][2], cs[i][3]); r = ((GM)gm)(obj); free(obj);
        W("SE_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    { void* ct = dlsym(h, "_ZN15SubStyleEncoderC1EPviP16PositionEncodingiiii"); void* gm = dlsym(h, "_ZN15SubStyleEncoder11get_memsizeEv");
      int cs[2][4] = {{2,96,192,1024},{4,64,256,2048}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,void*,int,int,int,int))ct)(obj, g_buf, 0, PE_, cs[i][0], cs[i][1], cs[i][2], cs[i][3]); r = ((GM)gm)(obj); free(obj);
        W("SSE_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // voc: Conv1d(this, float* buf, a,b,c,d,e)
    { void* ct = dlsym(h, "_ZN6Conv1dC1EPfiiiii"); void* gm = dlsym(h, "_ZN6Conv1d11get_memsizeEv");
      int cs[3][5] = {{1,512,512,15,1},{1,256,256,15,1},{1,256,512,5,1}};
      for (int i = 0; i < 3; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int,int,int))ct)(obj, g_buf, cs[i][0],cs[i][1],cs[i][2],cs[i][3],cs[i][4]); r = ((GM)gm)(obj); free(obj);
        W("Conv1d_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // UpSampler(this, buf, a,b,c,d,e,f)
    { void* ct = dlsym(h, "_ZN9UpSamplerC1EPviiiiii"); void* gm = dlsym(h, "_ZN9UpSampler11get_memsizeEv");
      int cs[3][6] = {{256,256,4,1,1,1},{512,512,8,1,1,1},{256,512,2,1,1,1}};
      for (int i = 0; i < 3; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int,int,int,int))ct)(obj, g_buf, cs[i][0],cs[i][1],cs[i][2],cs[i][3],cs[i][4],cs[i][5]); r = ((GM)gm)(obj); free(obj);
        W("Up_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // ResBlock(this, buf, a,b,c,d,e)
    { void* ct = dlsym(h, "_ZN8ResBlockC1EPviiiii"); void* gm = dlsym(h, "_ZN8ResBlock11get_memsizeEv");
      int cs[2][5] = {{512,1,3,15,1},{256,1,3,15,1}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int,int,int))ct)(obj, g_buf, cs[i][0],cs[i][1],cs[i][2],cs[i][3],cs[i][4]); r = ((GM)gm)(obj); free(obj);
        W("RB_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    // DeConv1d(this, float* buf, a..f)
    { void* ct = dlsym(h, "_ZN8DeConv1dC1EPfiiiiii"); void* gm = dlsym(h, "_ZN8DeConv1d11get_memsizeEv");
      int cs[2][6] = {{1,256,1,15,4,1},{1,512,1,5,2,1}};
      for (int i = 0; i < 2; i++) { obj = calloc(1,8192);
        ((void(*)(void*,void*,int,int,int,int,int,int))ct)(obj, g_buf, cs[i][0],cs[i][1],cs[i][2],cs[i][3],cs[i][4],cs[i][5]); r = ((GM)gm)(obj); free(obj);
        W("DC_"); WNUM(i); W("="); WNUM(r); W("\n"); } }
    close(g_out);
    return 0;
}


// ============ ????????: ??????????????? ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runDump(JNIEnv_* env, void* clazz, void* jpath, void* jeng, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* path = gch(env, jpath, &ic);
    int which = 0; { const char* e = gch(env, jeng, &ic); if (e[0]=='b') which=1; if (e[0]=='v') which=2; }
    const char* outp = gch(env, jout, &ic);
    if (mapf(path) != 0) return -1;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;

    void* ctor; void* gm; const char* nm;
    if (which == 0) { ctor = dlsym(h, "_ZN8amengineC1EPvi"); gm = dlsym(h, "_ZN8amengine11get_memsizeEv"); nm = "AM"; }
    else if (which == 1) { ctor = dlsym(h, "_ZN8bnengineC1EPvi"); gm = dlsym(h, "_ZN8bnengine11get_memsizeEv"); nm = "BN"; }
    else { ctor = dlsym(h, "_ZN9vocengineC1EPvi"); gm = dlsym(h, "_ZN9vocengine11get_memsizeEv"); nm = "VOC"; }

    // ???? 0x2000 ??
    u8* eng = calloc(1, 0x2000);
    ((C2)ctor)(eng, g_buf, 0);
    long total = ((GM)gm)(eng);
    W(nm); W("_total="); WNUM(total); W("\n");

    // ???????? qword: ??? [buf, buf+len) ???????
    // ???????????: ???? 256 ????????
    unsigned long lo = (unsigned long)g_buf, hi = lo + g_len;
    for (int off = 0; off < 0x2000; off += 8) {
        unsigned long v = *(unsigned long*)(eng + off);
        if (v >= lo && v < hi) {
            W("eng["); WNUM(off); W("] -> file+"); WNUM((long)(v - lo)); W("\n");
            // ???????(??????): v ?????????? file ??
        }
    }
    // ??????? 0x38..0xE0, ?? 0x120 ??
    for (int off = 0x38; off <= 0xE0; off += 8) {
        unsigned long p = *(unsigned long*)(eng + off);
        if (p > 0x10000 && (p & 7) == 0 && !(p >= lo && p < hi)) {
            for (int q = 0; q < 0x120; q += 8) {
                unsigned long v = *(unsigned long*)(p + q);
                if (v >= lo && v < hi) {
                    W("eng["); WNUM(off); W("].obj["); WNUM(q); W("] -> file+"); WNUM((long)(v - lo)); W("\n");
                }
            }
        }
    }
    close(g_out);
    return 0;
}


// ============ GOT hook: ?? SDK ???? Gerzz/????? ============
extern int mprotect(void*, size_t_, int);
#define PROT_READ_W 3

typedef struct { void* dli_fbase; } Dl_info_;
extern int dladdr(void*, Dl_info_*);

static void* g_base; static size_t_ g_len2;
static void* g_realBs; static void* g_realBs1; static void* g_realWs;
static long g_seq; static int g_hookOut;

// GerzzPreWsBs: (buf, u8**, float**, float*, u8*, bool*, int*, int, int)
static void HookBs(void* buf, void** pp, void** fp, void* s, void* z, void* fl, int* cur, int a, int b) {
    (void)buf;(void)pp;(void)fp;(void)s;(void)z;(void)fl;
    g_hookOut = g_out;
    int c0 = *cur;
    ((void(*)(void*,void**,void**,void*,void*,void*,int*,int,int))g_realBs)(buf,pp,fp,s,z,fl,cur,a,b);
    // ?: seq, cursor_before, a, b, consumed
    W("BS "); WNUM(g_seq++); W(" cur="); WNUM(c0); W(" K="); WNUM(a); W(" N="); WNUM(b); W(" end="); WNUM(*cur); W("\n");
    g_out = g_hookOut;
}
static void HookBs1(void* buf, void** pp, void** fp, void* s, void* z, void* fl, int* cur, int a, int b) {
    (void)buf;(void)pp;(void)fp;(void)s;(void)z;(void)fl;
    g_hookOut = g_out;
    int c0 = *cur;
    ((void(*)(void*,void**,void**,void*,void*,void*,int*,int,int))g_realBs1)(buf,pp,fp,s,z,fl,cur,a,b);
    W("BS1 "); WNUM(g_seq++); W(" cur="); WNUM(c0); W(" K="); WNUM(a); W(" N="); WNUM(b); W(" end="); WNUM(*cur); W("\n");
    g_out = g_hookOut;
}
static void HookWs(void* buf, void** pp, void* s, void* z, void* fl, int* cur, int a, int b) {
    (void)buf;(void)pp;(void)s;(void)z;(void)fl;
    g_hookOut = g_out;
    int c0 = *cur;
    ((void(*)(void*,void**,void*,void*,void*,int*,int,int))g_realWs)(buf,pp,s,z,fl,cur,a,b);
    W("WS "); WNUM(g_seq++); W(" cur="); WNUM(c0); W(" K="); WNUM(a); W(" N="); WNUM(b); W(" end="); WNUM(*cur); W("\n");
    g_out = g_hookOut;
}

static void* find_got_slot(void* base, const char* symname) {
    unsigned char* e = (unsigned char*)base;
    unsigned long e_phoff = *(unsigned long*)(e + 0x20);
    unsigned short e_phentsize = *(unsigned short*)(e + 0x36);
    unsigned short e_phnum = *(unsigned short*)(e + 0x38);
    unsigned char* dynp = 0;
    for (int i = 0; i < e_phnum; i++) {
        unsigned char* ph = e + e_phoff + e_phentsize * (unsigned long)i;
        if (*(unsigned int*)(ph + 0) == 2) { dynp = e + *(unsigned long*)(ph + 0x10); break; } // PT_DYNAMIC
    }
    if (!dynp) return 0;
    unsigned long strtab = 0, symtab = 0, jmprel = 0, pltsz = 0, rela = 0, relasz = 0;
    for (unsigned char* d = dynp; ; d += 16) {
        unsigned long tag = *(unsigned long*)(d);
        unsigned long val = *(unsigned long*)(d + 8);
        if (!tag) break;
        if (tag == 5) strtab = val;
        else if (tag == 6) symtab = val;
        else if (tag == 23) { jmprel = val; }
        else if (tag == 2) pltsz = val;
        else if (tag == 7) rela = val;
        else if (tag == 8) relasz = val;
    }
    if (!strtab || !symtab) return 0;
    // vaddr ? ?????bionic ??? DT ?, ?? base; ????????
    unsigned char* strA = (strtab >= (unsigned long)base) ? (unsigned char*)strtab : e + strtab;
    unsigned char* symA = (symtab >= (unsigned long)base) ? (unsigned char*)symtab : e + symtab;
    struct Range { unsigned char* r; unsigned long sz; } rs[2];
    int nr = 0;
    if (jmprel) { rs[nr].r = (jmprel >= (unsigned long)base) ? (unsigned char*)jmprel : e + jmprel; rs[nr].sz = pltsz; nr++; }
    if (rela)  { rs[nr].r = (rela >= (unsigned long)base) ? (unsigned char*)rela : e + rela; rs[nr].sz = relasz; nr++; }
    for (int k = 0; k < nr; k++) {
        for (unsigned long off = 0; off + 24 <= rs[k].sz; off += 24) {
            unsigned char* rp = rs[k].r + off;
            unsigned long r_offset = *(unsigned long*)(rp);
            unsigned long r_info = *(unsigned long*)(rp + 8);
            unsigned long symidx = r_info >> 32;
            if (!symidx) continue;
            unsigned int st_name = *(unsigned int*)(symA + symidx * 24);
            const char* nm = (const char*)(strA + st_name);
            int m = 0;
            while (symname[m] && nm[m] == symname[m]) m++;
            if (symname[m] == 0 && nm[m] == 0) return (void*)(e + r_offset);
        }
    }
    return 0;
}
// ---- ??? GOT ??: x1 = buf+cursor ???? ----
static void* g_slotSave[16]; static void* g_slotAddr[16]; static int g_nHooks;
static const char* g_hookNames[16]; static int g_hookUnit; static unsigned long g_bufLo;

static void WH(int idx, void* buf, long a, long b, long cc, long d) {
    W("C "); W((char*)g_hookNames[idx]);
    W(" off="); WNUM((long)buf - (long)g_bufLo);
    W(" a="); WNUM(a); W(" b="); WNUM(b);
    W(" c="); WNUM(cc); W(" d="); WNUM(d); W("\n");
}
#define WRAP(nm, idx, ...) 
// ??? wrapper
static void W_Embed(void* t, void* buf, int dim) { WH(0, buf, dim, 0, 0, 0); ((void(*)(void*,void*,int))g_slotSave[0])(t, buf, dim); }
static void W_SE(void* t, void* buf, int mode, void* pe, int a, int b, int c, int d) { WH(1, buf, a, b, c, d); ((void(*)(void*,void*,int,void*,int,int,int,int))g_slotSave[1])(t, buf, mode, pe, a, b, c, d); }
static void W_SSE(void* t, void* buf, int mode, void* pe, int a, int b, int c, int d) { WH(2, buf, a, b, c, d); ((void(*)(void*,void*,int,void*,int,int,int,int))g_slotSave[2])(t, buf, mode, pe, a, b, c, d); }
static void W_LN(void* t, void* buf, float eps, int dim) { WH(3, buf, dim, 0, 0, 0); ((void(*)(void*,void*,float,int))g_slotSave[3])(t, buf, eps, dim); }
static void W_SLN(void* t, void* buf, float eps, int dim) { WH(4, buf, dim, 0, 0, 0); ((void(*)(void*,void*,float,int))g_slotSave[4])(t, buf, eps, dim); }
static void W_Prenet(void* t, void* buf, int f, int a, int b) { WH(5, buf, f, a, b, 0); ((void(*)(void*,void*,int,int,int))g_slotSave[5])(t, buf, f, a, b); }
static void W_Linear(void* t, void* buf, int f, int a, int b) { WH(6, buf, f, a, b, 0); ((void(*)(void*,void*,int,int,int))g_slotSave[6])(t, buf, f, a, b); }
static void W_Attn(void* t, void* buf, void* pe, int a, int b, int c) { WH(7, buf, a, b, c, 0); ((void(*)(void*,void*,void*,int,int,int))g_slotSave[7])(t, buf, pe, a, b, c); }
static void W_FF(void* t, void* buf, int f, int a, int b) { WH(8, buf, f, a, b, 0); ((void(*)(void*,void*,int,int,int))g_slotSave[8])(t, buf, f, a, b); }
static void W_CM(void* t, void* buf, int mode, int dim) { WH(9, buf, mode, dim, 0, 0); ((void(*)(void*,void*,int,int))g_slotSave[9])(t, buf, mode, dim); }
static void W_Conv1d(void* t, void* buf, int a, int b, int cc, int d, int e) { WH(10, buf, a, b, cc, d); ((void(*)(void*,void*,int,int,int,int,int))g_slotSave[10])(t, buf, a, b, cc, d, e); }
static void W_RB(void* t, void* buf, int a, int b, int cc, int d, int e) { WH(11, buf, a, b, cc, d); ((void(*)(void*,void*,int,int,int,int,int))g_slotSave[11])(t, buf, a, b, cc, d, e); }
static void W_Up(void* t, void* buf, int a, int b, int cc, int d, int e, int f) { WH(12, buf, a, b, cc, d); ((void(*)(void*,void*,int,int,int,int,int,int))g_slotSave[12])(t, buf, a, b, cc, d, e, f); }
static void W_DC(void* t, void* buf, int a, int b, int cc, int d, int e, int f) { WH(13, buf, a, b, cc, d); ((void(*)(void*,void*,int,int,int,int,int,int))g_slotSave[13])(t, buf, a, b, cc, d, e, f); }

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runTrace(JNIEnv_* env, void* clazz, void* jpath, void* jeng, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* path = gch(env, jpath, &ic);
    int which = 0; { const char* e2 = gch(env, jeng, &ic); if (e2[0]=='b') which=1; if (e2[0]=='v') which=2; }
    const char* outp = gch(env, jout, &ic);
    if (mapf(path) != 0) return -1;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;

    void* base_ = (void*)((unsigned long)dlsym(h, "_Z9alignsizeii") - 0x2adcc);
    if (*(unsigned int*)base_ != 0x464C457F) { W("BADMAGIC\n"); close(g_out); return -6; }
    g_bufLo = (unsigned long)g_buf;

    struct { const char* sym; const char* tag; void* wrap; } hooks[] = {
        {"_ZN10EmbedLayerC1EPvi","Embed",W_Embed},
        {"_ZN10SubEncoderC1EPviP16PositionEncodingiiii","SE",W_SE},
        {"_ZN15SubStyleEncoderC1EPviP16PositionEncodingiiii","SSE",W_SSE},
        {"_ZN9LayerNormC1EPvfi","LN",W_LN},
        {"_ZN14StyleLayerNormC1EPvfi","SLN",W_SLN},
        {"_ZN6PrenetC1EPviii","Prenet",W_Prenet},
        {"_ZN6LinearC1EPviii","Linear",W_Linear},
        {"_ZN11EncSelfAttnC1EPvP16PositionEncodingiii","Attn",W_Attn},
        {"_ZN11FeedForwardC1EPviii","FF",W_FF},
        {"_ZN10ConvModuleC1EPvii","CM",W_CM},
        {"_ZN6Conv1dC1EPfiiiii","Conv1d",W_Conv1d},
        {"_ZN8ResBlockC1EPviiiii","RB",W_RB},
        {"_ZN9UpSamplerC1EPviiiiii","Up",W_Up},
        {"_ZN8DeConv1dC1EPfiiiiii","DC",W_DC},
    };
    g_nHooks = 14;
    // ?? + ????
    unsigned long minSlot = ~0UL, maxSlot = 0;
    int nFound = 0;
    for (int i = 0; i < g_nHooks; i++) {
        g_hookNames[i] = hooks[i].tag;
        g_slotAddr[i] = find_got_slot(base_, hooks[i].sym);
        if (g_slotAddr[i]) {
            g_slotSave[i] = *(void**)g_slotAddr[i];
            unsigned long a = (unsigned long)g_slotAddr[i];
            if (a < minSlot) minSlot = a;
            if (a > maxSlot) maxSlot = a;
            nFound++;
        } else { g_slotSave[i] = dlsym(h, hooks[i].sym); }
    }
    W("found_slots="); WNUM(nFound); W("/14 min="); WNUM((long)minSlot); W(" max="); WNUM((long)maxSlot); W("\n");
    // RELRO ??: ???????
    if (nFound > 0) {
        unsigned long pg = minSlot & ~0xFFFUL;
        unsigned long span = (maxSlot - pg) + 0x1000;
        mprotect((void*)pg, span, 3);
        for (int i = 0; i < g_nHooks; i++) {
            if (g_slotAddr[i]) *(void**)g_slotAddr[i] = hooks[i].wrap;
        }
    }

    void* ctor; void* gm; const char* nm;
    if (which == 0) { ctor = dlsym(h, "_ZN8amengineC1EPvi"); gm = dlsym(h, "_ZN8amengine11get_memsizeEv"); nm = "AM"; }
    else if (which == 1) { ctor = dlsym(h, "_ZN8bnengineC1EPvi"); gm = dlsym(h, "_ZN8bnengine11get_memsizeEv"); nm = "BN"; }
    else { ctor = dlsym(h, "_ZN9vocengineC1EPvi"); gm = dlsym(h, "_ZN9vocengine11get_memsizeEv"); nm = "VOC"; }

    u8* eng = calloc(1, 0x2000);
    ((C2)ctor)(eng, g_buf, 0);
    long total = ((GM)gm)(eng);
    W(nm); W("_total="); WNUM(total); W("\n");
    // ????
    if (nFound > 0) {
        for (int i = 0; i < g_nHooks; i++) {
            if (g_slotAddr[i]) *(void**)g_slotAddr[i] = g_slotSave[i];
        }
    }
    close(g_out);
    return 0;
}


// ============ ???? ============
static void scanObj(const char* tag, void* obj, unsigned long lo, unsigned long hi, int unit) {
    if (!obj) return;
    unsigned long p = (unsigned long)obj;
    if (p < 0x10000 || (p & 7)) return;
    for (int q = 0; q < 0x180; q += 8) {
        unsigned long v = *(unsigned long*)(p + q);
        if (v >= lo && v < hi) {
            W(tag); W(".obj["); WNUM(q); W("] -> off="); WNUM((long)(v - lo));
            if (unit == 4) { W(" (float#"); WNUM((long)(v - lo) / 4); W(")"); }
            W("\n");
        }
    }
}

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runSlots(JNIEnv_* env, void* clazz, void* jpath, void* jeng, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* path = gch(env, jpath, &ic);
    int which = 0; { const char* e2 = gch(env, jeng, &ic); if (e2[0]=='b') which=1; if (e2[0]=='v') which=2; }
    const char* outp = gch(env, jout, &ic);
    if (mapf(path) != 0) return -1;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;

    void* ctor; void* gm; const char* nm; int unit = 1;
    if (which == 0) { ctor = dlsym(h, "_ZN8amengineC1EPvi"); gm = dlsym(h, "_ZN8amengine11get_memsizeEv"); nm = "AM"; }
    else if (which == 1) { ctor = dlsym(h, "_ZN8bnengineC1EPvi"); gm = dlsym(h, "_ZN8bnengine11get_memsizeEv"); nm = "BN"; }
    else { ctor = dlsym(h, "_ZN9vocengineC1EPvi"); gm = dlsym(h, "_ZN9vocengine11get_memsizeEv"); nm = "VOC"; unit = 4; }

    u8* eng = calloc(1, 0x2000);
    ((C2)ctor)(eng, g_buf, 0);
    long total = ((GM)gm)(eng);
    W(nm); W("_total="); WNUM(total); W(" filesize="); WNUM((long)g_len); W("\n");

    unsigned long lo = (unsigned long)g_buf, hi = lo + g_len;
    int loSlot = 0x38, hiSlot = 0xE0;
    if (which == 1) { loSlot = 0x28; hiSlot = 0xA0; }
    if (which == 2) { loSlot = 0x30; hiSlot = 0x78; }
    char tag[32]; int ti = 0;
    const char* src2 = nm; while (src2[ti]) { tag[ti] = src2[ti]; ti++; }
    scanObj(nm, eng, lo, hi, unit);
    for (int off = loSlot; off <= hiSlot; off += 8) {
        void* obj = *(void**)(eng + off);
        int n = ti;
        tag[n++]='.'; tag[n++]='s';
        if (off >= 100) { tag[n++] = '0'+off/100; tag[n++] = '0'+(off/10)%10; tag[n++]='0'+off%10; }
        else { tag[n++] = '0'+off/10; tag[n++]='0'+off%10; }
        tag[n] = 0;
        scanObj(tag, obj, lo, hi, unit);
    }
    close(g_out);
    return 0;
}

// ============ Forward ??: ????? ============
static void* g_F_voc; static void* g_F_am1; static void* g_F_am2; static void* g_F_bn;
static long g_capN;

static void dumpTensor(const char* tag, void* T, int cap) {
    if (!T) { W(tag); W(" NULL\n"); return; }
    int count = *(int*)T;
    float* data = *(float**)((char*)T + 8);
    int* sh = (int*)((char*)T + 0x10);
    W("T "); W(tag); W(" count="); WNUM(count);
    W(" sh=["); for (int i = 0; i < 5; i++) { if(i) W(","); WNUM(sh[i]); } W("]");
    if (data && count > 0) {
        int n = count < cap ? count : cap;
        W(" data0=");
        for (int i = 0; i < (n < 8 ? n : 8); i++) WNUM((long)(data[i] * 1000000.0f));
        W(" cap="); WNUM(n);
        // ????: tag+floats
        W(" BIN\n");
        int tl = 0; while (tag[tl]) tl++;
        write(g_out, "\x01T", 2); write(g_out, tag, tl); write(g_out, "\x00", 1);
        int cnt = n; write(g_out, &cnt, 4); write(g_out, data, n * 4);
    } else W(" NODATA\n");
}
static void dumpPcm(const char* tag, short* p, int n) {
    W("P "); W(tag); W(" n="); WNUM(n); W(" s0="); WNUM(p ? p[0] : 0); W(" BIN\n");
    int tl = 0; while (tag[tl]) tl++;
    write(g_out, "\x01P", 2); write(g_out, tag, tl); write(g_out, "\x00", 1);
    write(g_out, &n, 4); if (p && n > 0) write(g_out, p, n * 2);
}
// voc: forward(this, Tensor& a, Tensor& b, short* pcm)
static void* W_vocF(void* t, void* a, void* b, short* pcm) {
    dumpTensor("voc_in_a", a, 65536);
    dumpTensor("voc_in_b", b, 65536);
    void* r = ((void*(*)(void*,void*,void*,short*))g_F_voc)(t, a, b, pcm);
    dumpTensor("voc_out_a", a, 65536);
    dumpTensor("voc_out_b", b, 65536);
    if (pcm) dumpPcm("voc_pcm", pcm, 4096);
    return r;
}
// am v1: forward(this, Tensor&, Tensor&, Tensor&, int, int)
static void* W_am1(void* t, void* a, void* b, void* cc, int i1, int i2) {
    dumpTensor("am1_a", a, 65536); dumpTensor("am1_b", b, 65536); dumpTensor("am1_c", cc, 65536);
    void* r = ((void*(*)(void*,void*,void*,void*,int,int))g_F_am1)(t, a, b, cc, i1, i2);
    dumpTensor("am1out_a", a, 65536); dumpTensor("am1out_b", b, 65536); dumpTensor("am1out_c", cc, 65536);
    W("am1 ints="); WNUM(i1); W(","); WNUM(i2); W("\n");
    return r;
}
// am v2: forward(this, Tensor&, Tensor&, Tensor&, int, float*)
static void* W_am2(void* t, void* a, void* b, void* cc, int i1, float* f) {
    dumpTensor("am2_a", a, 65536); dumpTensor("am2_b", b, 65536); dumpTensor("am2_c", cc, 65536);
    void* r = ((void*(*)(void*,void*,void*,void*,int,float*))g_F_am2)(t, a, b, cc, i1, f);
    dumpTensor("am2out_a", a, 65536); dumpTensor("am2out_c", cc, 65536);
    W("am2 int="); WNUM(i1); W("\n");
    return r;
}
// bn: forward(this, Tensor&, Tensor&)
static void* W_bn(void* t, void* a, void* b) {
    dumpTensor("bn_a", a, 65536); dumpTensor("bn_b", b, 65536);
    void* r = ((void*(*)(void*,void*,void*))g_F_bn)(t, a, b);
    dumpTensor("bnout_a", a, 65536); dumpTensor("bnout_b", b, 65536);
    return r;
}

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runForward(JNIEnv_* env, void* clazz, void* jam, void* jbn, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* amP = gch(env, jam, &ic);
    const char* bnP = gch(env, jbn, &ic);
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;

    void* base_ = (void*)((unsigned long)dlsym(h, "_Z9alignsizeii") - 0x2adcc);
    // ????????
    if (mapf(amP) != 0) return -1;
    unsigned char* amBuf = g_buf; size_t_ amLen = g_len;
    if (mapf(bnP) != 0) return -1;
    unsigned char* bnBuf = g_buf; size_t_ bnLen = g_len;
    if (mapf(vocP) != 0) return -1;
    unsigned char* vocBuf = g_buf; size_t_ vocLen = g_len;
    W("files: am="); WNUM((long)amLen); W(" bn="); WNUM((long)bnLen); W(" voc="); WNUM((long)vocLen); W("\n");

    // hook forwards (???)
    void* sVoc = find_got_slot(base_, "_ZN9vocengine7forwardERP6TensorIfES3_Ps");
    void* sAm1 = find_got_slot(base_, "_ZN8amengine7forwardERP6TensorIfES3_S3_ii");
    void* sAm2 = find_got_slot(base_, "_ZN8amengine7forwardERP6TensorIfES3_S3_iPf");
    void* sBn  = find_got_slot(base_, "_ZN8bnengine7forwardERP6TensorIfES3_");
    W("fwslots voc="); WNUM((long)sVoc); W(" am1="); WNUM((long)sAm1); W(" am2="); WNUM((long)sAm2); W(" bn="); WNUM((long)sBn); W("\n");
    g_F_voc = dlsym(h, "_ZN9vocengine7forwardERP6TensorIfES3_Ps");
    g_F_am1 = dlsym(h, "_ZN8amengine7forwardERP6TensorIfES3_S3_ii");
    g_F_am2 = dlsym(h, "_ZN8amengine7forwardERP6TensorIfES3_S3_iPf");
    g_F_bn  = dlsym(h, "_ZN8bnengine7forwardERP6TensorIfES3_");
    unsigned long mn = ~0UL, mx = 0;
    void* slots[4] = {sVoc, sAm1, sAm2, sBn}; 
    for (int i = 0; i < 4; i++) if (slots[i]) { unsigned long a=(unsigned long)slots[i]; if(a<mn)mn=a; if(a>mx)mx=a; }
    if (mn != ~0UL) {
        mprotect((void*)(mn & ~0xFFFUL), (mx - (mn & ~0xFFFUL)) + 0x1000, 3);
        if (sVoc) *(void**)sVoc = W_vocF;
        if (sAm1) *(void**)sAm1 = W_am1;
        if (sAm2) *(void**)sAm2 = W_am2;
        if (sBn)  *(void**)sBn  = W_bn;
    }

    // Manual sub-pipeline: bypass resample_process
    void* amCtor = dlsym(h, "_ZN8amengineC1EPvi");
    void* bnCtor = dlsym(h, "_ZN8bnengineC1EPvi");
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* feCtor = dlsym(h, "_ZN14FeatureExtractC1Ei");
    void* feInit = dlsym(h, "_ZN14FeatureExtract4initEv");
    void* feInsert = dlsym(h, "_ZN14FeatureExtract6insertEPsii");
    void* feSize = dlsym(h, "_ZN14FeatureExtract4sizeEv");
    void* feFetch = dlsym(h, "_ZN14FeatureExtract5fetchERP6TensorIfE");
    void* bnF2 = dlsym(h, "_ZN8bnengine7forwardERP6TensorIfES3_");
    void* amF2 = dlsym(h, "_ZN8amengine7forwardERP6TensorIfES3_S3_ii");
    void* vocF2 = dlsym(h, "_ZN9vocengine7forwardERP6TensorIfES3_Ps");
    W("subsyms ok\n");
    unsigned char* amO = calloc(1, 0x2000); ((C2)amCtor)(amO, amBuf, 0);
    unsigned char* bnO = calloc(1, 0x2000); ((C2)bnCtor)(bnO, bnBuf, 0);
    unsigned char* vocO = calloc(1, 0x2000); ((C2)vocCtor)(vocO, vocBuf, 0);
    unsigned char* fe = calloc(1, 0x2000); ((void(*)(void*,int))feCtor)(fe, 16000); ((void(*)(void*))feInit)(fe);
    W("engines+fe built\n");
    unsigned char* melT = calloc(1, 0x40);
    unsigned char* tA = calloc(1, 0x40);
    unsigned char* tB = calloc(1, 0x40);
    int frames = 0;
    // ?? PCM: 440Hz ?? 2048 ??
    short pcmIn[2048];
    for (int i = 0; i < 2048; i++) {
        float ph = 6.283185f * 440.0f * i / 16000.0f;
        int v = (int)(sin(ph) * 12000);  // sin ??????
        pcmIn[i] = (short)v;
    }
    dumpPcm("pcm_in", pcmIn, 2048);
    short pcmOut[8192];
    for (int i = 0; i < 8192; i++) pcmOut[i] = 0;

    // ? PCM ? mel ? bn ? am ? voc
    // ???? 2 ???, ????????
    short* pcmBig = calloc(1, 65536 * 2);
    for (int i = 0; i < 32000; i++) {
        float ph = 6.283185f * 440.0f * i / 16000.0f;
        pcmBig[i] = (short)(int)(sin(ph) * 12000);
    }
    // ---- setstyle: 192-dim style vector ----
    {
        int fd = open("/sdcard/Android/data/com.vc.harness/files/vc_model/style.bin", 0);
        static float styleData[192];
        if (fd >= 0) { read(fd, styleData, 768); close(fd); }
        static unsigned char styleT[0x40];
        *(int*)(styleT + 0) = 192;
        *(float**)(styleT + 8) = styleData;
        *(int*)(styleT + 0x10) = 1; *(int*)(styleT + 0x14) = 1;
        *(int*)(styleT + 0x18) = 1; *(int*)(styleT + 0x1c) = 192;
        *(int*)(styleT + 0x20) = 192;
        void* amSS = dlsym(h, "_ZN8amengine8setstyleEP6TensorIfE");
        ((void(*)(void*,void*))amSS)(amO, styleT);
        W("setstyle done\n");
    }
    // ---- multi-chunk capture: 10 chunks x 4096 samples ----
    static char tagbuf[32];
    int gframe = 0;
    for (int chunk = 0; chunk < 10; chunk++) {
        ((void(*)(void*,short*,int,int))feInsert)(fe, pcmBig + chunk * 4096, 4096, 1);
        while (((int(*)(void*))feSize)(fe) >= 1 && gframe < 40) {
            ((void(*)(void*,void*))feFetch)(fe, melT);
            { int p=0; const char* s2="femel"; while(s2[p]){tagbuf[p]=s2[p];p++; }
              tagbuf[p++]='_'; tagbuf[p++]='0'+gframe/10; tagbuf[p++]='0'+gframe%10; tagbuf[p]=0;
              dumpTensor(tagbuf, *(void**)melT, 4096); }
            ((void(*)(void*,void*,void*))bnF2)(bnO, melT, tA);
            ((void(*)(void*,void*,void*,void*,int,int))amF2)(amO, melT, tA, tB, 0, 0);
            int r = ((int(*)(void*,void*,void*,short*))vocF2)(vocO, melT, tB, pcmOut);
            W("chunk="); WNUM(chunk); W(" frame="); WNUM(gframe); W(" vocret="); WNUM(r); W("\n");
            int ti2 = 0; (void)ti2;
            const char* pre[3]; pre[0]="mel"; pre[1]="bn"; pre[2]="am";
            void* objs[3]; objs[0] = *(void**)melT; objs[1] = *(void**)tA; objs[2] = *(void**)tB;
            for (int k = 0; k < 3; k++) {
                int p = 0; const char* s2 = pre[k];
                while (s2[p]) { tagbuf[p] = s2[p]; p++; }
                tagbuf[p++] = '_'; tagbuf[p++] = '0' + gframe / 10; tagbuf[p++] = '0' + gframe % 10; tagbuf[p] = 0;
                dumpTensor(tagbuf, objs[k], 8192);
            }
            tagbuf[0]='v';tagbuf[1]='p';tagbuf[2]='_';tagbuf[3]='0'+gframe/10;tagbuf[4]='0'+gframe%10;tagbuf[5]=0;
            dumpPcm(tagbuf, pcmOut, 2048);
            gframe++;
            for (int i = 0; i < 8192; i++) pcmOut[i] = 0;
        }
    }
    W("total_frames="); WNUM(gframe); W("\n");
    close(g_out);
    return 0;
}







// ============ mel ????: ????? ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runMelCalib(JNIEnv_* env, void* clazz, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    void* ms = dlsym(h, "_ZN14FeatureExtract8melspectEPfS0_");
    W("melspect="); WNUM((long)ms); W("\n");
    if (!ms) { close(g_out); return -4; }
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;

    // melspect ?????: ?? this
    void* feCtor2 = dlsym(h, "_ZN14FeatureExtractC1Ei");
    void* feInit2 = dlsym(h, "_ZN14FeatureExtract4initEv");
    unsigned char* fe = calloc(1, 0x2000);
    ((void(*)(void*,int))feCtor2)(fe, 16000);
    ((void(*)(void*))feInit2)(fe);
    float* in = calloc(1, 2048 * 4);
    float* outb = calloc(1, 512 * 4);
    void (*msf)(void*, float*, float*) = (void(*)(void*, float*, float*))ms;

    // 1) ?????? log ??: ??? k=16, A=1..10000
    float amps[6] = {1.0f, 10.0f, 100.0f, 1000.0f, 10000.0f, 100000.0f};
    for (int a = 0; a < 6; a++) {
        for (int i = 0; i < 2048; i++) in[i] = 0.0f;
        in[16] = amps[a];
        msf(fe, in, outb);
        W("AMP "); WNUM((long)amps[a]);
        for (int i = 0; i < 6; i++) { W(" "); WNUM((long)(outb[i] * 1000000.0f)); }
        W("\n");
    }
    // 2) ????? k=0..511 (?????, ??)
    for (int k = 0; k < 512; k++) {
        for (int i = 0; i < 2048; i++) in[i] = 0.0f;
        in[k] = 1000.0f;
        msf(fe, in, outb);
        // BIN ?: k + 80 floats
        W("\x01M"); int kl = k; write(g_out, &kl, 4);
        write(g_out, outb, 80 * 4);
        if (k % 64 == 0) { W("k="); WNUM(k); W(" m0="); WNUM((long)(outb[0]*1e6)); W("\n"); }
    }
    close(g_out);
    return 0;
}


// ============ FE ????: insert ? dump ???? ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runFeCalib(JNIEnv_* env, void* clazz, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    void* feCtor3 = dlsym(h, "_ZN14FeatureExtractC1Ei");
    void* feInit3 = dlsym(h, "_ZN14FeatureExtract4initEv");
    void* feInsert3 = dlsym(h, "_ZN14FeatureExtract6insertEPsii");
    void* feSize3 = dlsym(h, "_ZN14FeatureExtract4sizeEv");
    unsigned char* fe = calloc(1, 0x2000);
    ((void(*)(void*,int))feCtor3)(fe, 16000);
    ((void(*)(void*))feInit3)(fe);
    W("fe built\n");
    // ??1: ???? PCM (??0) ? ????
    short* pcm1 = calloc(1, 4096 * 2);
    pcm1[0] = 32767;
    ((void(*)(void*,short*,int,int))feInsert3)(fe, pcm1, 4096, 1);
    int sz = ((int(*)(void*))feSize3)(fe);
    W("impulse fe.size="); WNUM(sz); W("\n");
    // dump ??: [0x388]=2048f, [0x390]=2048f
    float* b1 = *(float**)(fe + 0x388);
    float* b2 = *(float**)(fe + 0x390);
    write(g_out, "\x01" "B1", 3); write(g_out, b1, 2048*4);
    write(g_out, "\x01" "B2", 3); write(g_out, b2, 2048*4);
    // ??2: 440Hz ??
    unsigned char* fe2 = calloc(1, 0x2000);
    ((void(*)(void*,int))feCtor3)(fe2, 16000);
    ((void(*)(void*))feInit3)(fe2);
    short* pcm2 = calloc(1, 8192 * 2);
    for (int i = 0; i < 8192; i++) {
        float ph = 6.283185f * 440.0f * i / 16000.0f;
        pcm2[i] = (short)(int)(sin(ph) * 12000);
    }
    ((void(*)(void*,short*,int,int))feInsert3)(fe2, pcm2, 4096, 1);
    b1 = *(float**)(fe2 + 0x388);
    b2 = *(float**)(fe2 + 0x390);
    write(g_out, "\x01" "S1", 3); write(g_out, b1, 2048*4);
    write(g_out, "\x01" "S2", 3); write(g_out, b2, 2048*4);
    W("sine fe.size="); WNUM(((int(*)(void*))feSize3)(fe2)); W("\n");
    close(g_out);
    return 0;
}


// ============ voc ????: hook Conv1d ?? + ?? voc ============
static void* g_C1F; static int g_c1n;
static void W_conv1dF(void* t, void* x1, int mode) {
    if (g_c1n < 12) {
        static char tg[16];
        tg[0]='c'; tg[1]='0'+g_c1n/10; tg[2]='0'+g_c1n%10; tg[3]='i'; tg[4]=0;
        dumpTensor(tg, x1, 16384);
    }
    ((void(*)(void*,void*,int))g_C1F)(t, x1, mode);
    if (g_c1n < 12) {
        static char tg2[16];
        tg2[0]='c'; tg2[1]='0'+g_c1n/10; tg2[2]='0'+g_c1n%10; tg2[3]='o'; tg2[4]=0;
        dumpTensor(tg2, x1, 16384);
        W("C1_"); WNUM(g_c1n); W(" mode="); WNUM(mode); W("\n");
        g_c1n++;
    }
}

// ============ sinegen/upsample hook ============
static void* g_SG; static void* g_UP; static int g_sgn;
static void W_sinegen(void* a, void* b, void* cc) {
    dumpTensor("sg_a", a, 4096);
    dumpTensor("sg_b", b, 4096);
    dumpTensor("sg_c", cc, 4096);
    ((void(*)(void*,void*,void*))g_SG)(a, b, cc);
    dumpTensor("sg_out", b, 4096);
    dumpTensor("sg_state", cc, 4096);
    g_sgn++;
}
static void* W_upsample(void* dst, void* src, int n) {
    dumpTensor("up_src", src, 4096);
    ((void*(*)(void*,void*,int))g_UP)(dst, src, n);
    dumpTensor("up_dst", dst, 8192);
    return dst;
}
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runVoc(JNIEnv_* env, void* clazz, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    unsigned char* vocBuf = g_buf;

    void* base_ = (void*)((unsigned long)dlsym(h, "_Z9alignsizeii") - 0x2adcc);
    // hook Conv1d::forward
    void* slot = find_got_slot(base_, "_ZN6Conv1d7forwardEP6TensorIfEi");
    W("c1slot="); WNUM((long)slot); W("\n");
    g_C1F = dlsym(h, "_ZN6Conv1d7forwardEP6TensorIfEi");
    g_c1n = 0;
    void* slotSG = find_got_slot(base_, "_Z7sinegenP6TensorIfES1_S1_");
    void* slotUP = find_got_slot(base_, "_ZN6TensorIfE8upsampleEPS0_i");
    W("sgslot="); WNUM((long)slotSG); W(" upslot="); WNUM((long)slotUP); W("\n");
    g_SG = dlsym(h, "_Z7sinegenP6TensorIfES1_S1_");
    g_UP = dlsym(h, "_ZN6TensorIfE8upsampleEPS0_i");
    if (slotSG) *(void**)slotSG = W_sinegen;
    if (slotUP) *(void**)slotUP = W_upsample;
    if (slot) {
        unsigned long pg = (unsigned long)slot & ~0xFFFUL;
        mprotect((void*)pg, 0x2000, 3);
        *(void**)slot = W_conv1dF;
    }

    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* vocF = dlsym(h, "_ZN9vocengine7forwardERP6TensorIfES3_Ps");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, vocBuf, 0);
    W("voc built\n");

    // ?? Tensor
    static float inData[1600]; static float in2Data[32];
    { int fd = open("/sdcard/Android/data/com.vc.harness/files/vc_model/voc_in1.bin", 0);
      if (fd>=0){read(fd,inData,6400);close(fd);} }
    { int fd = open("/sdcard/Android/data/com.vc.harness/files/vc_model/voc_in2.bin", 0);
      if (fd>=0){read(fd,in2Data,128);close(fd);} }
    static unsigned char T1[0x40]; static unsigned char T2[0x40];
    *(int*)(T1+0)=1600;  *(float**)(T1+8)=inData;
    *(int*)(T1+0x10)=1; *(int*)(T1+0x14)=1; *(int*)(T1+0x18)=16; *(int*)(T1+0x1c)=100; *(int*)(T1+0x20)=1600;
    *(int*)(T2+0)=32;   *(float**)(T2+8)=in2Data;
    *(int*)(T2+0x10)=1; *(int*)(T2+0x14)=1; *(int*)(T2+0x18)=16; *(int*)(T2+0x1c)=2;  *(int*)(T2+0x20)=32;
    // slot
    static void* S1; static void* S2;
    S1 = T1; S2 = T2;
    short pcmOut[8192];
    for (int i=0;i<8192;i++) pcmOut[i]=0;
    dumpTensor("vin1", T1, 1600);
    int r = ((int(*)(void*,void*,void*,short*))vocF)(vocO, &S1, &S2, pcmOut);
    W("vocret="); WNUM(r); W("\n");
    dumpPcm("vpcm", pcmOut, 3840);
    if (slot) *(void**)slot = g_C1F;
    close(g_out);
    return 0;
}



// ============ Conv1d delta ??? ============
// ============ Conv1d delta basis v2: ???????? ============
// ============ Conv1d full-delta matrix (1920 columns) ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runC1basis(JNIEnv_* env, void* clazz, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* c1fwd  = dlsym(h, "_ZN6Conv1d7forwardEP6TensorIfEi");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, g_buf, 0);
    void* c1obj = *(void**)(vocO + 0x40);
    static float xbuf[276480];
    static unsigned char T[0x40];
    // ?? + ??
    for (int pass = -1; pass < 1920; pass++) {
        for (int i = 0; i < 276480; i++) xbuf[i] = 0.0f;
        if (pass >= 0) xbuf[pass] = 1.0f;
        for (int st = 0x20; st <= 0x28; st += 8) {
            void* tobj = *(void**)((char*)c1obj + st);
            if (tobj) {
                int n2 = *(int*)((char*)tobj + 0x20);
                float* d2 = *(float**)((char*)tobj + 8);
                if (d2 && n2 > 0 && n2 < 16384) { int lim = n2 < 8192 ? n2 : 8192; for (int i = 0; i < lim; i++) d2[i] = 0.0f; }
            }
        }
        *(int*)(T+0)=276480;  *(float**)(T+8)=xbuf;
        *(int*)(T+0x10)=1; *(int*)(T+0x14)=1; *(int*)(T+0x18)=960; *(int*)(T+0x1c)=2; *(int*)(T+0x20)=1920;
        ((void(*)(void*,void*,int))c1fwd)(c1obj, T, 20);
        if (pass < 0) { W("warmup+base done\n"); continue; }
        W("\x01" "D"); write(g_out,&pass,4);
        write(g_out, xbuf, 12288*4);
    }
    W("all done\n");
    close(g_out);
    return 0;
}






// ============ Up#1 8x Conv1d delta ?? ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runUp1(JNIEnv_* env, void* clazz, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* c1fwd  = dlsym(h, "_ZN6Conv1d7forwardEP6TensorIfEi");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, g_buf, 0);
    void* up1 = *(void**)(vocO + 0x58);
    W("up1="); WNUM((long)up1); W("\n");
    // 8 ?: rb_i (0..3) ? conv1/conv2
    void* layers[8]; int dils[8];
    int dtab[4] = {1,3,9,27};  // rb0..rb3 dil
    for (int rb = 0; rb < 4; rb++) {
        void* rbo = *(void**)((char*)up1 + 0x28 + rb*8);
        layers[rb*2]   = *(void**)((char*)rbo + 0x20);
        layers[rb*2+1] = *(void**)((char*)rbo + 0x28);
        dils[rb*2] = dtab[rb]; dils[rb*2+1] = 1;  // ??conv??, ??conv dil=1
    }
    static float xbuf[131072];
    static unsigned char T[0x40];
    for (int L = 0; L < 8; L++) {
        int dil = dils[L];
        for (int pass = -1; pass < 768; pass++) {
            // 1. ????
            for (int i = 0; i < 131072; i++) xbuf[i] = 0.0f;
            // 2. ???? Tensor
            *(int*)(T+0)=131072;  *(float**)(T+8)=xbuf;
            *(int*)(T+0x10)=1; *(int*)(T+0x14)=1; *(int*)(T+0x18)=48; *(int*)(T+0x1c)=256; *(int*)(T+0x20)=12288;
            // 3. state-clear (flush ? no-op, diag ??)
            for (int st = 0x20; st <= 0x28; st += 8) {
                void* tobj = *(void**)((char*)layers[L] + st);
                if (tobj) {
                    int n2 = *(int*)((char*)tobj + 0x20);
                    float* d2 = *(float**)((char*)tobj + 8);
                    if (d2 && n2 > 0 && n2 < 200000) { int lim = n2 < 131072 ? n2 : 131072; for (int i = 0; i < lim; i++) d2[i] = 0.0f; }
                }
            }
            // 4. ?
            if (pass >= 0) {
                int fi = pass / 256;
                int ch = pass % 256;
                int frame = 54 - fi*dil;
                if (frame >= 0 && frame < 48) xbuf[frame*256 + ch] = 1.0f;
            }
            // 5. forward + dump
            ((void(*)(void*,void*,int))c1fwd)(layers[L], T, 1);
            int passDump = (pass < 0) ? -999 : pass;
            W("\x01" "U"); write(g_out,&L,1); write(g_out,&passDump,4);
            write(g_out, xbuf + 52*256, 1280*4);
        }
        W("layer"); WNUM(L); W(" dil="); WNUM(dil); W(" done\n");
    }
    W("up1 all done\n");
    close(g_out);
    return 0;
}



// ============ DeConv ?????? ============
// ============ DeConv v3: ??dump + Toeplitz?? ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runDeconv(JNIEnv_* env, void* clazz, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* dcFwd   = dlsym(h, "_ZN8DeConv1d7forwardEP6TensorIfE");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, g_buf, 0);
    void* up1 = *(void**)(vocO + 0x58);
    void* dc  = *(void**)((char*)up1 + 0x20);
    W("dc="); WNUM((long)dc); W("\n");
    static float xbuf[131072];
    static unsigned char T[0x40];
    // ??: ??, f=5?c=0..511, f=8?c=0..3, f=0?c=0..3, f=15?c=0..3
    int nq = 0;
    static int pf[530]; static int pc[530];
    pf[nq]=-1; pc[nq]=-1; nq++;
    for (int c2=0;c2<512;c2++){ pf[nq]=5;  pc[nq]=c2; nq++; }
    for (int c2=0;c2<4;c2++)  { pf[nq]=8;  pc[nq]=c2; nq++; }
    for (int c2=0;c2<4;c2++)  { pf[nq]=0;  pc[nq]=c2; nq++; }
    for (int c2=0;c2<4;c2++)  { pf[nq]=15; pc[nq]=c2; nq++; }
    for (int q = 0; q < nq; q++) {
        for (int i = 0; i < 131072; i++) xbuf[i] = 0.0f;
        // ???
        *(int*)(T+0)=131072;  *(float**)(T+8)=xbuf;
        *(int*)(T+0x10)=1; *(int*)(T+0x14)=1; *(int*)(T+0x18)=16; *(int*)(T+0x1c)=512; *(int*)(T+0x20)=8192;
        ((void(*)(void*,void*))dcFwd)(dc, T);
        if (pf[q] >= 0) xbuf[pf[q]*512 + pc[q]] = 1.0f;
        *(int*)(T+0x18)=16; *(int*)(T+0x1c)=512; *(int*)(T+0x20)=8192;
        ((void(*)(void*,void*))dcFwd)(dc, T);
        W("\x01" "R"); write(g_out,&q,4); write(g_out,&pf[q],4); write(g_out,&pc[q],4);
        write(g_out, xbuf, 12288*4);
    }
    W("deconv v3 done nq="); WNUM(nq); W("\n");
    close(g_out);
    return 0;
}





// ============ ??: Tensor??diff + buffer??diff ============
__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runDiag(JNIEnv_* env, void* clazz, void* jvoc, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* c1fwd   = dlsym(h, "_ZN6Conv1d7forwardEP6TensorIfEi");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, g_buf, 0);
    void* up1 = *(void**)(vocO + 0x58);
    void* rbo = *(void**)((char*)up1 + 0x28);
    void* c1obj = *(void**)((char*)rbo + 0x20);   // rb0.conv1 (L0)
    W("c1obj="); WNUM((long)c1obj); W("\n");
    static float xbuf[131072];
    static unsigned char T[0x40];
    // ---- ??1: ??? ----
    for (int i = 0; i < 131072; i++) xbuf[i] = 0.0f;
    *(int*)(T+0)=131072;  *(float**)(T+8)=xbuf;
    *(int*)(T+0x10)=1; *(int*)(T+0x14)=1; *(int*)(T+0x18)=48; *(int*)(T+0x1c)=256; *(int*)(T+0x20)=12288;
    ((void(*)(void*,void*,int))c1fwd)(c1obj, T, 1);
    // ---- ???: dump T??? + xbuf?? ----
    W("AFTER_FLUSH T_bytes=");
    for (int i = 0; i < 0x40; i += 4) { WNUM(*(int*)(T+i)); W(" "); }
    W("\n");
    W("AFTER_FLUSH xbuf_ptr_in_T="); WNUM(*(long*)(T+8)); W(" my_xbuf="); WNUM((long)xbuf); W("\n");
    W("AFTER_FLUSH xbuf[0..7]=");
    for (int i = 0; i < 8; i++) { WNUM((long)(xbuf[i]*1e6)); W(" "); }
    W("\n");
    W("AFTER_FLUSH xbuf[52*256..52*256+3]=");
    for (int i = 0; i < 4; i++) { WNUM((long)(xbuf[52*256+i]*1e6)); W(" "); }
    W("\n");
    // ??????dump
    W("LAYER_obj_bytes=");
    for (int i = 0; i < 0x30; i += 4) { WNUM(*(int*)((char*)c1obj+i)); W(" "); }
    W("\n");
    // ---- ??2: ? ? ----
    xbuf[54*256 + 0] = 1.0f;
    W("DELTA_SET xbuf[54*256]="); WNUM((long)xbuf[54*256]); W("\n");
    // ??T(???, ??+8)
    *(int*)(T+0x18)=48; *(int*)(T+0x1c)=256; *(int*)(T+0x20)=12288;
    W("BEFORE_FWD2 T+8="); WNUM(*(long*)(T+8)); W("\n");
    // ---- ??3: ??? forward ----
    ((void(*)(void*,void*,int))c1fwd)(c1obj, T, 1);
    // ---- forward?: dump ----
    W("AFTER_FWD2 T_bytes=");
    for (int i = 0; i < 0x40; i += 4) { WNUM(*(int*)(T+i)); W(" "); }
    W("\n");
    W("AFTER_FWD2 T+8="); WNUM(*(long*)(T+8)); W(" my_xbuf="); WNUM((long)xbuf); W("\n");
    W("AFTER_FWD2 frames52_56_energy=");
    for (int f = 52; f <= 56; f++) {
        float s = 0;
        for (int c = 0; c < 256; c++) s += (xbuf[f*256+c] < 0 ? -xbuf[f*256+c] : xbuf[f*256+c]);
        WNUM((long)(s*1000)); W(" ");
    }
    W("\n");
    W("AFTER_FWD2 xbuf[54*256..+3]=");
    for (int i = 0; i < 4; i++) { WNUM((long)(xbuf[54*256+i]*1e6)); W(" "); }
    W("\n");
    close(g_out);
    return 0;
}


// ============ ???????: hook Conv1d ??? ============
static void* g_MF_c1; static int g_mfIter; static int g_mfCall;
static void W_mf_conv1d(void* t, void* x1, int mode) {
    // ??: dump ??
    W("\x01" "M"); int v1=g_mfIter; write(g_out,&v1,4);
    int v2=g_mfCall; write(g_out,&v2,4);
    int v3=0; write(g_out,&v3,4);            // 0=pre
    int n=*(int*)(x1+0x20); int nn=n<16384?n:16384; write(g_out,&nn,4);
    write(g_out, *(float**)(x1+8), nn*4);
    ((void(*)(void*,void*,int))g_MF_c1)(t, x1, mode);
    // ??: dump ??
    W("\x01" "M"); write(g_out,&v1,4); write(g_out,&v2,4);
    int v4=1; write(g_out,&v4,4);            // 1=post
    n=*(int*)(x1+0x20); nn=n<16384?n:16384; write(g_out,&nn,4);
    write(g_out, *(float**)(x1+8), nn*4);
    g_mfCall++;
}

__attribute__((visibility("default"))) jint
Java_com_vc_harness_VcProbe_runVocMulti(JNIEnv_* env, void* clazz, void* jvoc, void* jin, void* jout) {
    (void)clazz;
    const char* (*gch)(JNIEnv_*, void*, u8*) = (const char* (*)(JNIEnv_*, void*, u8*))env->fns[169];
    u8 ic = 0;
    const char* vocP = gch(env, jvoc, &ic);
    const char* inP  = gch(env, jin, &ic);
    const char* outp = gch(env, jout, &ic);
    void* h = dlopen("libdubbing_sdk_android.so", 2 | 0x100);
    if (!h) return -3;
    g_out = open(outp, 0x41, 0666);
    if (g_out < 0) return -2;
    if (mapf(vocP) != 0) return -1;
    unsigned char* vocBuf = g_buf;
    void* base_ = (void*)((unsigned long)dlsym(h, "_Z9alignsizeii") - 0x2adcc);
    // hook Conv1d::forward
    void* slot = find_got_slot(base_, "_ZN6Conv1d7forwardEP6TensorIfEi");
    g_MF_c1 = dlsym(h, "_ZN6Conv1d7forwardEP6TensorIfEi");
    W("slot="); WNUM((long)slot); W("\n");
    if (slot) {
        unsigned long pg = (unsigned long)slot & ~0xFFFUL;
        mprotect((void*)pg, 0x2000, 3);
        *(void**)slot = W_mf_conv1d;
    }
    void* vocCtor = dlsym(h, "_ZN9vocengineC1EPvi");
    void* vocF = dlsym(h, "_ZN9vocengine7forwardERP6TensorIfES3_Ps");
    unsigned char* vocO = calloc(1, 0x2000);
    ((C2)vocCtor)(vocO, vocBuf, 0);
    W("voc built\n");
    // ??????
    static float inData[1600]; static float in2Data[32];
    { int fd=open(inP,0); if(fd>=0){read(fd,inData,6400);close(fd);} }
    { int fd2=open("/sdcard/Android/data/com.vc.harness/files/vc_model/voc_in2.bin",0);
      if(fd2>=0){read(fd2,in2Data,128);close(fd2);} }
    static float in2Orig[32];
    for (int i = 0; i < 32; i++) in2Orig[i] = in2Data[i];
    static unsigned char T1[0x40]; static unsigned char T2[0x40];
    static void* S1; static void* S2;
    short pcmOut[8192];
    // ??LCG??
    unsigned int seed = 12345;
    g_mfCall = 0;
    for (int iter = 0; iter < 24; iter++) {
        g_mfIter = iter;
        // ????: iter0=??, ??=??*scale+??
        float scale = 1.0f + 0.3f*(iter%5) - 0.6f*((iter/5)%2);
        for (int i = 0; i < 1600; i++) {
            seed = seed*1103515245+12345;
            float noise = ((seed>>16)&0xFFFF)/65535.0f - 0.5f;
            inData[i] = inData[i]*scale + (iter>0 ? noise*2.0f : 0.0f);
        }
        *(int*)(T1+0)=1600;  *(float**)(T1+8)=inData;
        *(int*)(T1+0x10)=1; *(int*)(T1+0x14)=1; *(int*)(T1+0x18)=16; *(int*)(T1+0x1c)=100; *(int*)(T1+0x20)=1600;
        *(int*)(T2+0)=32;   *(float**)(T2+8)=in2Data;
        *(int*)(T2+0x10)=1; *(int*)(T2+0x14)=1; *(int*)(T2+0x18)=16; *(int*)(T2+0x1c)=2;  *(int*)(T2+0x20)=32;
        S1=T1; S2=T2;
        int r = ((int(*)(void*,void*,void*,short*))vocF)(vocO, &S1, &S2, pcmOut);
        W("iter="); WNUM(iter); W(" ret="); WNUM(r); W(" calls="); WNUM(g_mfCall); W("\n");
    }
    if (slot) *(void**)slot = g_MF_c1;
    W("vocmulti done\n");
    close(g_out);
    return 0;
}

