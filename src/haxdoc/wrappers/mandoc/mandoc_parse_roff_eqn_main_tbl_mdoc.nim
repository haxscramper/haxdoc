
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / stddef, file, hmisc / wrappers / wraphelp



export
  wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `roff_tok`
  # Declared in roff.h:73
  RoffTokC* {.importc: "enum roff_tok", header: allHeaders.} = enum ## @import{[[code:enum!roff_tok]]}
    roffTok_ROFF_br = 0, roffTok_ROFF_ce = 1, roffTok_ROFF_fi = 2,
    roffTok_ROFF_ft = 3, roffTok_ROFF_ll = 4, roffTok_ROFF_mc = 5,
    roffTok_ROFF_nf = 6, roffTok_ROFF_po = 7, roffTok_ROFF_rj = 8,
    roffTok_ROFF_sp = 9, roffTok_ROFF_ta = 10, roffTok_ROFF_ti = 11,
    roffTok_ROFF_MAX = 12, roffTok_ROFF_ab = 13, roffTok_ROFF_ad = 14,
    roffTok_ROFF_af = 15, roffTok_ROFF_aln = 16, roffTok_ROFF_als = 17,
    roffTok_ROFF_am = 18, roffTok_ROFF_am1 = 19, roffTok_ROFF_ami = 20,
    roffTok_ROFF_ami1 = 21, roffTok_ROFF_as = 22, roffTok_ROFF_as1 = 23,
    roffTok_ROFF_asciify = 24, roffTok_ROFF_backtrace = 25, roffTok_ROFF_bd = 26,
    roffTok_ROFF_bleedat = 27, roffTok_ROFF_blm = 28, roffTok_ROFF_box = 29,
    roffTok_ROFF_boxa = 30, roffTok_ROFF_bp = 31, roffTok_ROFF_BP1 = 32,
    roffTok_ROFF_break = 33, roffTok_ROFF_breakchar = 34, roffTok_ROFF_brnl = 35,
    roffTok_ROFF_brp = 36, roffTok_ROFF_brpnl = 37, roffTok_ROFF_c2 = 38,
    roffTok_ROFF_cc = 39, roffTok_ROFF_cf = 40, roffTok_ROFF_cflags = 41,
    roffTok_ROFF_ch = 42, roffTok_ROFF_char = 43, roffTok_ROFF_chop = 44,
    roffTok_ROFF_class = 45, roffTok_ROFF_close = 46, roffTok_ROFF_CL = 47,
    roffTok_ROFF_color = 48, roffTok_ROFF_composite = 49,
    roffTok_ROFF_continue = 50, roffTok_ROFF_cp = 51, roffTok_ROFF_cropat = 52,
    roffTok_ROFF_cs = 53, roffTok_ROFF_cu = 54, roffTok_ROFF_da = 55,
    roffTok_ROFF_dch = 56, roffTok_ROFF_Dd = 57, roffTok_ROFF_de = 58,
    roffTok_ROFF_de1 = 59, roffTok_ROFF_defcolor = 60, roffTok_ROFF_dei = 61,
    roffTok_ROFF_dei1 = 62, roffTok_ROFF_device = 63, roffTok_ROFF_devicem = 64,
    roffTok_ROFF_di = 65, roffTok_ROFF_do = 66, roffTok_ROFF_ds = 67,
    roffTok_ROFF_ds1 = 68, roffTok_ROFF_dwh = 69, roffTok_ROFF_dt = 70,
    roffTok_ROFF_ec = 71, roffTok_ROFF_ecr = 72, roffTok_ROFF_ecs = 73,
    roffTok_ROFF_el = 74, roffTok_ROFF_em = 75, roffTok_ROFF_EN = 76,
    roffTok_ROFF_eo = 77, roffTok_ROFF_EP = 78, roffTok_ROFF_EQ = 79,
    roffTok_ROFF_errprint = 80, roffTok_ROFF_ev = 81, roffTok_ROFF_evc = 82,
    roffTok_ROFF_ex = 83, roffTok_ROFF_fallback = 84, roffTok_ROFF_fam = 85,
    roffTok_ROFF_fc = 86, roffTok_ROFF_fchar = 87, roffTok_ROFF_fcolor = 88,
    roffTok_ROFF_fdeferlig = 89, roffTok_ROFF_feature = 90,
    roffTok_ROFF_fkern = 91, roffTok_ROFF_fl = 92, roffTok_ROFF_flig = 93,
    roffTok_ROFF_fp = 94, roffTok_ROFF_fps = 95, roffTok_ROFF_fschar = 96,
    roffTok_ROFF_fspacewidth = 97, roffTok_ROFF_fspecial = 98,
    roffTok_ROFF_ftr = 99, roffTok_ROFF_fzoom = 100, roffTok_ROFF_gcolor = 101,
    roffTok_ROFF_hc = 102, roffTok_ROFF_hcode = 103, roffTok_ROFF_hidechar = 104,
    roffTok_ROFF_hla = 105, roffTok_ROFF_hlm = 106, roffTok_ROFF_hpf = 107,
    roffTok_ROFF_hpfa = 108, roffTok_ROFF_hpfcode = 109, roffTok_ROFF_hw = 110,
    roffTok_ROFF_hy = 111, roffTok_ROFF_hylang = 112, roffTok_ROFF_hylen = 113,
    roffTok_ROFF_hym = 114, roffTok_ROFF_hypp = 115, roffTok_ROFF_hys = 116,
    roffTok_ROFF_ie = 117, roffTok_ROFF_if = 118, roffTok_ROFF_ig = 119,
    roffTok_ROFF_index = 120, roffTok_ROFF_it = 121, roffTok_ROFF_itc = 122,
    roffTok_ROFF_IX = 123, roffTok_ROFF_kern = 124, roffTok_ROFF_kernafter = 125,
    roffTok_ROFF_kernbefore = 126, roffTok_ROFF_kernpair = 127,
    roffTok_ROFF_lc = 128, roffTok_ROFF_lc_ctype = 129, roffTok_ROFF_lds = 130,
    roffTok_ROFF_length = 131, roffTok_ROFF_letadj = 132, roffTok_ROFF_lf = 133,
    roffTok_ROFF_lg = 134, roffTok_ROFF_lhang = 135, roffTok_ROFF_linetabs = 136,
    roffTok_ROFF_lnr = 137, roffTok_ROFF_lnrf = 138, roffTok_ROFF_lpfx = 139,
    roffTok_ROFF_ls = 140, roffTok_ROFF_lsm = 141, roffTok_ROFF_lt = 142,
    roffTok_ROFF_mediasize = 143, roffTok_ROFF_minss = 144, roffTok_ROFF_mk = 145,
    roffTok_ROFF_mso = 146, roffTok_ROFF_na = 147, roffTok_ROFF_ne = 148,
    roffTok_ROFF_nh = 149, roffTok_ROFF_nhychar = 150, roffTok_ROFF_nm = 151,
    roffTok_ROFF_nn = 152, roffTok_ROFF_nop = 153, roffTok_ROFF_nr = 154,
    roffTok_ROFF_nrf = 155, roffTok_ROFF_nroff = 156, roffTok_ROFF_ns = 157,
    roffTok_ROFF_nx = 158, roffTok_ROFF_open = 159, roffTok_ROFF_opena = 160,
    roffTok_ROFF_os = 161, roffTok_ROFF_output = 162, roffTok_ROFF_padj = 163,
    roffTok_ROFF_papersize = 164, roffTok_ROFF_pc = 165, roffTok_ROFF_pev = 166,
    roffTok_ROFF_pi = 167, roffTok_ROFF_PI1 = 168, roffTok_ROFF_pl = 169,
    roffTok_ROFF_pm = 170, roffTok_ROFF_pn = 171, roffTok_ROFF_pnr = 172,
    roffTok_ROFF_ps = 173, roffTok_ROFF_psbb = 174, roffTok_ROFF_pshape = 175,
    roffTok_ROFF_pso = 176, roffTok_ROFF_ptr = 177, roffTok_ROFF_pvs = 178,
    roffTok_ROFF_rchar = 179, roffTok_ROFF_rd = 180,
    roffTok_ROFF_recursionlimit = 181, roffTok_ROFF_return = 182,
    roffTok_ROFF_rfschar = 183, roffTok_ROFF_rhang = 184, roffTok_ROFF_rm = 185,
    roffTok_ROFF_rn = 186, roffTok_ROFF_rnn = 187, roffTok_ROFF_rr = 188,
    roffTok_ROFF_rs = 189, roffTok_ROFF_rt = 190, roffTok_ROFF_schar = 191,
    roffTok_ROFF_sentchar = 192, roffTok_ROFF_shc = 193, roffTok_ROFF_shift = 194,
    roffTok_ROFF_sizes = 195, roffTok_ROFF_so = 196,
    roffTok_ROFF_spacewidth = 197, roffTok_ROFF_special = 198,
    roffTok_ROFF_spreadwarn = 199, roffTok_ROFF_ss = 200, roffTok_ROFF_sty = 201,
    roffTok_ROFF_substring = 202, roffTok_ROFF_sv = 203, roffTok_ROFF_sy = 204,
    roffTok_ROFF_T = 205, roffTok_ROFF_tc = 206, roffTok_ROFF_TE = 207,
    roffTok_ROFF_TH = 208, roffTok_ROFF_tkf = 209, roffTok_ROFF_tl = 210,
    roffTok_ROFF_tm = 211, roffTok_ROFF_tm1 = 212, roffTok_ROFF_tmc = 213,
    roffTok_ROFF_tr = 214, roffTok_ROFF_track = 215, roffTok_ROFF_transchar = 216,
    roffTok_ROFF_trf = 217, roffTok_ROFF_trimat = 218, roffTok_ROFF_trin = 219,
    roffTok_ROFF_trnt = 220, roffTok_ROFF_troff = 221, roffTok_ROFF_TS = 222,
    roffTok_ROFF_uf = 223, roffTok_ROFF_ul = 224, roffTok_ROFF_unformat = 225,
    roffTok_ROFF_unwatch = 226, roffTok_ROFF_unwatchn = 227,
    roffTok_ROFF_vpt = 228, roffTok_ROFF_vs = 229, roffTok_ROFF_warn = 230,
    roffTok_ROFF_warnscale = 231, roffTok_ROFF_watch = 232,
    roffTok_ROFF_watchlength = 233, roffTok_ROFF_watchn = 234,
    roffTok_ROFF_wh = 235, roffTok_ROFF_while = 236, roffTok_ROFF_write = 237,
    roffTok_ROFF_writec = 238, roffTok_ROFF_writem = 239,
    roffTok_ROFF_xflag = 240, roffTok_ROFF_cblock = 241,
    roffTok_ROFF_RENAMED = 242, roffTok_ROFF_USERDEF = 243,
    roffTok_TOKEN_NONE = 244, roffTok_MDOC_Dd = 245, roffTok_MDOC_Dt = 246,
    roffTok_MDOC_Os = 247, roffTok_MDOC_Sh = 248, roffTok_MDOC_Ss = 249,
    roffTok_MDOC_Pp = 250, roffTok_MDOC_D1 = 251, roffTok_MDOC_Dl = 252,
    roffTok_MDOC_Bd = 253, roffTok_MDOC_Ed = 254, roffTok_MDOC_Bl = 255,
    roffTok_MDOC_El = 256, roffTok_MDOC_It = 257, roffTok_MDOC_Ad = 258,
    roffTok_MDOC_An = 259, roffTok_MDOC_Ap = 260, roffTok_MDOC_Ar = 261,
    roffTok_MDOC_Cd = 262, roffTok_MDOC_Cm = 263, roffTok_MDOC_Dv = 264,
    roffTok_MDOC_Er = 265, roffTok_MDOC_Ev = 266, roffTok_MDOC_Ex = 267,
    roffTok_MDOC_Fa = 268, roffTok_MDOC_Fd = 269, roffTok_MDOC_Fl = 270,
    roffTok_MDOC_Fn = 271, roffTok_MDOC_Ft = 272, roffTok_MDOC_Ic = 273,
    roffTok_MDOC_In = 274, roffTok_MDOC_Li = 275, roffTok_MDOC_Nd = 276,
    roffTok_MDOC_Nm = 277, roffTok_MDOC_Op = 278, roffTok_MDOC_Ot = 279,
    roffTok_MDOC_Pa = 280, roffTok_MDOC_Rv = 281, roffTok_MDOC_St = 282,
    roffTok_MDOC_Va = 283, roffTok_MDOC_Vt = 284, roffTok_MDOC_Xr = 285,
    roffTok_MDOC_A = 286, roffTok_MDOC_B = 287, roffTok_MDOC_D = 288,
    roffTok_MDOC_I = 289, roffTok_MDOC_J = 290, roffTok_MDOC_N = 291,
    roffTok_MDOC_O = 292, roffTok_MDOC_P = 293, roffTok_MDOC_R = 294,
    roffTok_MDOC_T = 295, roffTok_MDOC_V = 296, roffTok_MDOC_Ac = 297,
    roffTok_MDOC_Ao = 298, roffTok_MDOC_Aq = 299, roffTok_MDOC_At = 300,
    roffTok_MDOC_Bc = 301, roffTok_MDOC_Bf = 302, roffTok_MDOC_Bo = 303,
    roffTok_MDOC_Bq = 304, roffTok_MDOC_Bsx = 305, roffTok_MDOC_Bx = 306,
    roffTok_MDOC_Db = 307, roffTok_MDOC_Dc = 308, roffTok_MDOC_Do = 309,
    roffTok_MDOC_Dq = 310, roffTok_MDOC_Ec = 311, roffTok_MDOC_Ef = 312,
    roffTok_MDOC_Em = 313, roffTok_MDOC_Eo = 314, roffTok_MDOC_Fx = 315,
    roffTok_MDOC_Ms = 316, roffTok_MDOC_No = 317, roffTok_MDOC_Ns = 318,
    roffTok_MDOC_Nx = 319, roffTok_MDOC_Ox = 320, roffTok_MDOC_Pc = 321,
    roffTok_MDOC_Pf = 322, roffTok_MDOC_Po = 323, roffTok_MDOC_Pq = 324,
    roffTok_MDOC_Qc = 325, roffTok_MDOC_Ql = 326, roffTok_MDOC_Qo = 327,
    roffTok_MDOC_Qq = 328, roffTok_MDOC_Re = 329, roffTok_MDOC_Rs = 330,
    roffTok_MDOC_Sc = 331, roffTok_MDOC_So = 332, roffTok_MDOC_Sq = 333,
    roffTok_MDOC_Sm = 334, roffTok_MDOC_Sx = 335, roffTok_MDOC_Sy = 336,
    roffTok_MDOC_Tn = 337, roffTok_MDOC_Ux = 338, roffTok_MDOC_Xc = 339,
    roffTok_MDOC_Xo = 340, roffTok_MDOC_Fo = 341, roffTok_MDOC_Fc = 342,
    roffTok_MDOC_Oo = 343, roffTok_MDOC_Oc = 344, roffTok_MDOC_Bk = 345,
    roffTok_MDOC_Ek = 346, roffTok_MDOC_Bt = 347, roffTok_MDOC_Hf = 348,
    roffTok_MDOC_Fr = 349, roffTok_MDOC_Ud = 350, roffTok_MDOC_Lb = 351,
    roffTok_MDOC_Lp = 352, roffTok_MDOC_Lk = 353, roffTok_MDOC_Mt = 354,
    roffTok_MDOC_Brq = 355, roffTok_MDOC_Bro = 356, roffTok_MDOC_Brc = 357,
    roffTok_MDOC_C = 358, roffTok_MDOC_Es = 359, roffTok_MDOC_En = 360,
    roffTok_MDOC_Dx = 361, roffTok_MDOC_Q = 362, roffTok_MDOC_U = 363,
    roffTok_MDOC_Ta = 364, roffTok_MDOC_MAX = 365, roffTok_MAN_TH = 366,
    roffTok_MAN_SH = 367, roffTok_MAN_SS = 368, roffTok_MAN_TP = 369,
    roffTok_MAN_TQ = 370, roffTok_MAN_LP = 371, roffTok_MAN_PP = 372,
    roffTok_MAN_P = 373, roffTok_MAN_IP = 374, roffTok_MAN_HP = 375,
    roffTok_MAN_SM = 376, roffTok_MAN_SB = 377, roffTok_MAN_BI = 378,
    roffTok_MAN_IB = 379, roffTok_MAN_BR = 380, roffTok_MAN_RB = 381,
    roffTok_MAN_R = 382, roffTok_MAN_B = 383, roffTok_MAN_I = 384,
    roffTok_MAN_IR = 385, roffTok_MAN_RI = 386, roffTok_MAN_RE = 387,
    roffTok_MAN_RS = 388, roffTok_MAN_DT = 389, roffTok_MAN_UC = 390,
    roffTok_MAN_PD = 391, roffTok_MAN_AT = 392, roffTok_MAN_in = 393,
    roffTok_MAN_SY = 394, roffTok_MAN_YS = 395, roffTok_MAN_OP = 396,
    roffTok_MAN_EX = 397, roffTok_MAN_EE = 398, roffTok_MAN_UR = 399,
    roffTok_MAN_UE = 400, roffTok_MAN_MT = 401, roffTok_MAN_ME = 402,
    roffTok_MAN_MAX = 403



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  Mdocargt* = enum
    mSplit,                   ## @import{[[code:enum!mdocargt.enumField!MDOC_Split]]}
    mNosplit,                 ## @import{[[code:enum!mdocargt.enumField!MDOC_Nosplit]]}
    mRagged,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Ragged]]}
    mUnfilled,                ## @import{[[code:enum!mdocargt.enumField!MDOC_Unfilled]]}
    mLiteral,                 ## @import{[[code:enum!mdocargt.enumField!MDOC_Literal]]}
    mFile,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_File]]}
    mOffset,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Offset]]}
    mBullet,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Bullet]]}
    mDash,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_Dash]]}
    mHyphen,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Hyphen]]}
    mItem,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_Item]]}
    mEnum,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_Enum]]}
    mTag,                     ## @import{[[code:enum!mdocargt.enumField!MDOC_Tag]]}
    mDiag,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_Diag]]}
    mHang,                    ## @import{[[code:enum!mdocargt.enumField!MDOC_Hang]]}
    mOhang,                   ## @import{[[code:enum!mdocargt.enumField!MDOC_Ohang]]}
    mInset,                   ## @import{[[code:enum!mdocargt.enumField!MDOC_Inset]]}
    mColumn,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Column]]}
    mWidth,                   ## @import{[[code:enum!mdocargt.enumField!MDOC_Width]]}
    mCompact,                 ## @import{[[code:enum!mdocargt.enumField!MDOC_Compact]]}
    mStd,                     ## @import{[[code:enum!mdocargt.enumField!MDOC_Std]]}
    mFilled,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Filled]]}
    mWords,                   ## @import{[[code:enum!mdocargt.enumField!MDOC_Words]]}
    mEmphasis,                ## @import{[[code:enum!mdocargt.enumField!MDOC_Emphasis]]}
    mSymbolic,                ## @import{[[code:enum!mdocargt.enumField!MDOC_Symbolic]]}
    mNested,                  ## @import{[[code:enum!mdocargt.enumField!MDOC_Nested]]}
    mCentred,                 ## @import{[[code:enum!mdocargt.enumField!MDOC_Centred]]}
    mArgMax                    ## @import{[[code:enum!mdocargt.enumField!MDOC_ARG_MAX]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_bd`
  # Declared in mdoc.h:113
  MdocBd* {.bycopy, importc: "struct mdoc_bd", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_bd]]}
    offs* {.importc: "offs".}: cstring ## @import{[[code:struct!mdoc_bd.field!offs]]}
    cxType* {.importc: "type".}: MdocDispC ## @import{[[code:struct!mdoc_bd.field!type]]}
    comp* {.importc: "comp".}: cint ## @import{[[code:struct!mdoc_bd.field!comp]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `eqn_post`
  # Declared in eqn.h:37
  EqnPostC* {.importc: "enum eqn_post", header: allHeaders.} = enum ## @import{[[code:enum!eqn_post]]}
    eqnPost_EQNPOS_NONE = 0, eqnPost_EQNPOS_SUP = 1, eqnPost_EQNPOS_SUBSUP = 2,
    eqnPost_EQNPOS_SUB = 3, eqnPost_EQNPOS_TO = 4, eqnPost_EQNPOS_FROM = 5,
    eqnPost_EQNPOS_FROMTO = 6, eqnPost_EQNPOS_OVER = 7, eqnPost_EQNPOS_SQRT = 8,
    eqnPost_EQNPOS_MAX = 9



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `tbl_cellt`
  # Declared in tbl.h:36
  TblCelltC* {.importc: "enum tbl_cellt", header: allHeaders.} = enum ## @import{[[code:enum!tbl_cellt]]}
    tblCellt_TBL_CELL_CENTRE = 0, tblCellt_TBL_CELL_RIGHT = 1,
    tblCellt_TBL_CELL_LEFT = 2, tblCellt_TBL_CELL_NUMBER = 3,
    tblCellt_TBL_CELL_SPAN = 4, tblCellt_TBL_CELL_LONG = 5,
    tblCellt_TBL_CELL_DOWN = 6, tblCellt_TBL_CELL_HORIZ = 7,
    tblCellt_TBL_CELL_DHORIZ = 8, tblCellt_TBL_CELL_MAX = 9



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `eqn_boxt`
  # Declared in eqn.h:20
  EqnBoxtC* {.importc: "enum eqn_boxt", header: allHeaders.} = enum ## @import{[[code:enum!eqn_boxt]]}
    eqnBoxt_EQN_TEXT = 0, eqnBoxt_EQN_SUBEXPR = 1, eqnBoxt_EQN_LIST = 2,
    eqnBoxt_EQN_PILE = 3, eqnBoxt_EQN_MATRIX = 4



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_data`
  # Declared in mdoc.h:146
  MdocData* {.bycopy, importc: "struct mdoc_data", header: allHeaders, union.} = object
    ## @import{[[code:union!mdoc_data]]}
    an* {.importc: "An".}: MdocAn ## @import{[[code:union!mdoc_data.field!An]]}
    bd* {.importc: "Bd".}: MdocBd ## @import{[[code:union!mdoc_data.field!Bd]]}
    bf* {.importc: "Bf".}: MdocBf ## @import{[[code:union!mdoc_data.field!Bf]]}
    bl* {.importc: "Bl".}: MdocBl ## @import{[[code:union!mdoc_data.field!Bl]]}
    es* {.importc: "Es".}: ptr RoffNode ## @import{[[code:union!mdoc_data.field!Es]]}
    rs* {.importc: "Rs".}: MdocRs ## @import{[[code:union!mdoc_data.field!Rs]]}
    



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MdocList* = enum
    mlNone,                   ## @import{[[code:enum!mdoc_list.enumField!LIST__NONE]]}
    mlBullet,                 ## @import{[[code:enum!mdoc_list.enumField!LIST_bullet]]}
    mlColumn,                 ## @import{[[code:enum!mdoc_list.enumField!LIST_column]]}
    mlDash,                   ## @import{[[code:enum!mdoc_list.enumField!LIST_dash]]}
    mlDiag,                   ## @import{[[code:enum!mdoc_list.enumField!LIST_diag]]}
    mlEnum,                   ## @import{[[code:enum!mdoc_list.enumField!LIST_enum]]}
    mlHang,                   ## @import{[[code:enum!mdoc_list.enumField!LIST_hang]]}
    mlHyphen,                 ## @import{[[code:enum!mdoc_list.enumField!LIST_hyphen]]}
    mlInset,                  ## @import{[[code:enum!mdoc_list.enumField!LIST_inset]]}
    mlItem,                   ## @import{[[code:enum!mdoc_list.enumField!LIST_item]]}
    mlOhang,                  ## @import{[[code:enum!mdoc_list.enumField!LIST_ohang]]}
    mlTag,                    ## @import{[[code:enum!mdoc_list.enumField!LIST_tag]]}
    mlMax1                     ## @import{[[code:enum!mdoc_list.enumField!LIST_MAX]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdoc_list`
  # Declared in mdoc.h:75
  MdocListC* {.importc: "enum mdoc_list", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_list]]}
    mdocList_LIST_NONE = 0, mdocList_LIST_bullet = 1, mdocList_LIST_column = 2,
    mdocList_LIST_dash = 3, mdocList_LIST_diag = 4, mdocList_LIST_enum = 5,
    mdocList_LIST_hang = 6, mdocList_LIST_hyphen = 7, mdocList_LIST_inset = 8,
    mdocList_LIST_item = 9, mdocList_LIST_ohang = 10, mdocList_LIST_tag = 11,
    mdocList_LIST_MAX = 12



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MandocOs* = enum
    mdosOther,                ## @import{[[code:enum!mandoc_os.enumField!MANDOC_OS_OTHER]]}
    mdosNetbsd,               ## @import{[[code:enum!mandoc_os.enumField!MANDOC_OS_NETBSD]]}
    mdosOpenbsd                ## @import{[[code:enum!mandoc_os.enumField!MANDOC_OS_OPENBSD]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  RoffSec* = enum
    rsNone,                   ## @import{[[code:enum!roff_sec.enumField!SEC_NONE]]}
    rsName,                   ## @import{[[code:enum!roff_sec.enumField!SEC_NAME]]}
    rsLibrary,                ## @import{[[code:enum!roff_sec.enumField!SEC_LIBRARY]]}
    rsSynopsis,               ## @import{[[code:enum!roff_sec.enumField!SEC_SYNOPSIS]]}
    rsDescription,            ## @import{[[code:enum!roff_sec.enumField!SEC_DESCRIPTION]]}
    rsContext,                ## @import{[[code:enum!roff_sec.enumField!SEC_CONTEXT]]}
    rsImplementation,         ## @import{[[code:enum!roff_sec.enumField!SEC_IMPLEMENTATION]]}
    rsReturnValues,           ## @import{[[code:enum!roff_sec.enumField!SEC_RETURN_VALUES]]}
    rsEnvironment,            ## @import{[[code:enum!roff_sec.enumField!SEC_ENVIRONMENT]]}
    rsFiles,                  ## @import{[[code:enum!roff_sec.enumField!SEC_FILES]]}
    rsExitStatus,             ## @import{[[code:enum!roff_sec.enumField!SEC_EXIT_STATUS]]}
    rsExamples,               ## @import{[[code:enum!roff_sec.enumField!SEC_EXAMPLES]]}
    rsDiagnostics,            ## @import{[[code:enum!roff_sec.enumField!SEC_DIAGNOSTICS]]}
    rsCompatibility,          ## @import{[[code:enum!roff_sec.enumField!SEC_COMPATIBILITY]]}
    rsErrors,                 ## @import{[[code:enum!roff_sec.enumField!SEC_ERRORS]]}
    rsSeeAlso,                ## @import{[[code:enum!roff_sec.enumField!SEC_SEE_ALSO]]}
    rsStandards,              ## @import{[[code:enum!roff_sec.enumField!SEC_STANDARDS]]}
    rsHistory,                ## @import{[[code:enum!roff_sec.enumField!SEC_HISTORY]]}
    rsAuthors,                ## @import{[[code:enum!roff_sec.enumField!SEC_AUTHORS]]}
    rsCaveats,                ## @import{[[code:enum!roff_sec.enumField!SEC_CAVEATS]]}
    rsBugs,                   ## @import{[[code:enum!roff_sec.enumField!SEC_BUGS]]}
    rsSecurity,               ## @import{[[code:enum!roff_sec.enumField!SEC_SECURITY]]}
    rsCustom,                 ## @import{[[code:enum!roff_sec.enumField!SEC_CUSTOM]]}
    rsMax                      ## @import{[[code:enum!roff_sec.enumField!SEC__MAX]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  EqnBoxt* = enum
    ebText,                   ## @import{[[code:enum!eqn_boxt.enumField!EQN_TEXT]]}
    ebSubexpr,                ## @import{[[code:enum!eqn_boxt.enumField!EQN_SUBEXPR]]}
    ebList,                   ## @import{[[code:enum!eqn_boxt.enumField!EQN_LIST]]}
    ebPile,                   ## @import{[[code:enum!eqn_boxt.enumField!EQN_PILE]]}
    ebMatrix                   ## @import{[[code:enum!eqn_boxt.enumField!EQN_MATRIX]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_bl`
  # Declared in mdoc.h:119
  MdocBl* {.bycopy, importc: "struct mdoc_bl", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_bl]]}
    width* {.importc: "width".}: cstring ## @import{[[code:struct!mdoc_bl.field!width]]}
    offs* {.importc: "offs".}: cstring ## @import{[[code:struct!mdoc_bl.field!offs]]}
    cxType* {.importc: "type".}: MdocListC ## @import{[[code:struct!mdoc_bl.field!type]]}
    comp* {.importc: "comp".}: cint ## @import{[[code:struct!mdoc_bl.field!comp]]}
    ncols* {.importc: "ncols".}: SizeT ## @import{[[code:struct!mdoc_bl.field!ncols]]}
    cols* {.importc: "cols".}: cstringArray ## @import{[[code:struct!mdoc_bl.field!cols]]}
    count* {.importc: "count".}: cint ## @import{[[code:struct!mdoc_bl.field!count]]}
    



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_an`
  # Declared in mdoc.h:133
  MdocAn* {.bycopy, importc: "struct mdoc_an", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_an]]}
    auth* {.importc: "auth".}: MdocAuthC ## @import{[[code:struct!mdoc_an.field!auth]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `roff_type`
  # Declared in roff.h:60
  RoffTypeC* {.importc: "enum roff_type", header: allHeaders.} = enum ## @import{[[code:enum!roff_type]]}
    roffType_ROFFT_ROOT = 0, roffType_ROFFT_BLOCK = 1, roffType_ROFFT_HEAD = 2,
    roffType_ROFFT_BODY = 3, roffType_ROFFT_TAIL = 4, roffType_ROFFT_ELEM = 5,
    roffType_ROFFT_TEXT = 6, roffType_ROFFT_COMMENT = 7, roffType_ROFFT_TBL = 8,
    roffType_ROFFT_EQN = 9



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MdocEndbody* = enum
    meNot,                    ## @import{[[code:enum!mdoc_endbody.enumField!ENDBODY_NOT]]}
    meSpace                    ## @import{[[code:enum!mdoc_endbody.enumField!ENDBODY_SPACE]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `eqn_fontt`
  # Declared in eqn.h:28
  EqnFonttC* {.importc: "enum eqn_fontt", header: allHeaders.} = enum ## @import{[[code:enum!eqn_fontt]]}
    eqnFontt_EQNFONT_NONE = 0, eqnFontt_EQNFONT_ROMAN = 1,
    eqnFontt_EQNFONT_BOLD = 2, eqnFontt_EQNFONT_FAT = 3,
    eqnFontt_EQNFONT_ITALIC = 4, eqnFontt_EQNFONT_MAX = 5



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `tbl_datt`
  # Declared in tbl.h:81
  TblDattC* {.importc: "enum tbl_datt", header: allHeaders.} = enum ## @import{[[code:enum!tbl_datt]]}
    tblDatt_TBL_DATA_NONE = 0, tblDatt_TBL_DATA_DATA = 1,
    tblDatt_TBL_DATA_HORIZ = 2, tblDatt_TBL_DATA_DHORIZ = 3,
    tblDatt_TBL_DATA_NHORIZ = 4, tblDatt_TBL_DATA_NDHORIZ = 5



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MdocDisp* = enum
    mdNone,                   ## @import{[[code:enum!mdoc_disp.enumField!DISP__NONE]]}
    mdCentered,               ## @import{[[code:enum!mdoc_disp.enumField!DISP_centered]]}
    mdRagged,                 ## @import{[[code:enum!mdoc_disp.enumField!DISP_ragged]]}
    mdUnfilled,               ## @import{[[code:enum!mdoc_disp.enumField!DISP_unfilled]]}
    mdFilled,                 ## @import{[[code:enum!mdoc_disp.enumField!DISP_filled]]}
    mdLiteral                  ## @import{[[code:enum!mdoc_disp.enumField!DISP_literal]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdoc_font`
  # Declared in mdoc.h:106
  MdocFontC* {.importc: "enum mdoc_font", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_font]]}
    mdocFont_FONT_NONE = 0, mdocFont_FONT_Em = 1, mdocFont_FONT_Li = 2,
    mdocFont_FONT_Sy = 3



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  EqnFontt* = enum
    efNone,                   ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT_NONE]]}
    efRoman,                  ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT_ROMAN]]}
    efBold,                   ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT_BOLD]]}
    efFat,                    ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT_FAT]]}
    efItalic,                 ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT_ITALIC]]}
    efMax                      ## @import{[[code:enum!eqn_fontt.enumField!EQNFONT__MAX]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `tbl_spant`
  # Declared in tbl.h:104
  TblSpantC* {.importc: "enum tbl_spant", header: allHeaders.} = enum ## @import{[[code:enum!tbl_spant]]}
    tblSpant_TBL_SPAN_DATA = 0, tblSpant_TBL_SPAN_HORIZ = 1,
    tblSpant_TBL_SPAN_DHORIZ = 2



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MdocFont* = enum
    mfNone,                   ## @import{[[code:enum!mdoc_font.enumField!FONT__NONE]]}
    mfEm,                     ## @import{[[code:enum!mdoc_font.enumField!FONT_Em]]}
    mfLi,                     ## @import{[[code:enum!mdoc_font.enumField!FONT_Li]]}
    mfSy                       ## @import{[[code:enum!mdoc_font.enumField!FONT_Sy]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `tbl_span`
  # Declared in tbl.h:113
  TblSpan* {.bycopy, importc: "struct tbl_span", header: allHeaders.} = object
    ## @import{[[code:struct!tbl_span]]}
    opts* {.importc: "opts".}: ptr TblOpts ## @import{[[code:struct!tbl_span.field!opts]]}
    prev* {.importc: "prev".}: ptr TblSpan ## @import{[[code:struct!tbl_span.field!prev]]}
    next* {.importc: "next".}: ptr TblSpan ## @import{[[code:struct!tbl_span.field!next]]}
    layout* {.importc: "layout".}: ptr TblRow ## @import{[[code:struct!tbl_span.field!layout]]}
    first* {.importc: "first".}: ptr TblDat ## @import{[[code:struct!tbl_span.field!first]]}
    last* {.importc: "last".}: ptr TblDat ## @import{[[code:struct!tbl_span.field!last]]}
    line* {.importc: "line".}: cint ## @import{[[code:struct!tbl_span.field!line]]}
    pos* {.importc: "pos".}: TblSpantC ## @import{[[code:struct!tbl_span.field!pos]]}
    



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `roff_meta`
  # Declared in roff.h:532
  RoffMeta* {.bycopy, importc: "struct roff_meta", header: allHeaders.} = object
    ## @import{[[code:struct!roff_meta]]}
    first* {.importc: "first".}: ptr RoffNode ## @import{[[code:struct!roff_meta.field!first]]}
    msec* {.importc: "msec".}: cstring ## @import{[[code:struct!roff_meta.field!msec]]}
    vol* {.importc: "vol".}: cstring ## @import{[[code:struct!roff_meta.field!vol]]}
    os* {.importc: "os".}: cstring ## @import{[[code:struct!roff_meta.field!os]]}
    arch* {.importc: "arch".}: cstring ## @import{[[code:struct!roff_meta.field!arch]]}
    title* {.importc: "title".}: cstring ## @import{[[code:struct!roff_meta.field!title]]}
    name* {.importc: "name".}: cstring ## @import{[[code:struct!roff_meta.field!name]]}
    date* {.importc: "date".}: cstring ## @import{[[code:struct!roff_meta.field!date]]}
    sodest* {.importc: "sodest".}: cstring ## @import{[[code:struct!roff_meta.field!sodest]]}
    hasbody* {.importc: "hasbody".}: cint ## @import{[[code:struct!roff_meta.field!hasbody]]}
    rcsids* {.importc: "rcsids".}: cint ## @import{[[code:struct!roff_meta.field!rcsids]]}
    osE* {.importc: "os_e".}: MandocOsC ## @import{[[code:struct!roff_meta.field!os_e]]}
    macroset* {.importc: "macroset".}: RoffMacrosetC ## @import{[[code:struct!roff_meta.field!macroset]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdoc_auth`
  # Declared in mdoc.h:100
  MdocAuthC* {.importc: "enum mdoc_auth", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_auth]]}
    mdocAuth_AUTH_NONE = 0, mdocAuth_AUTH_split = 1, mdocAuth_AUTH_nosplit = 2



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `tbl_row`
  # Declared in tbl.h:74
  TblRow* {.bycopy, importc: "struct tbl_row", header: allHeaders.} = object
    ## @import{[[code:struct!tbl_row]]}
    next* {.importc: "next".}: ptr TblRow ## @import{[[code:struct!tbl_row.field!next]]}
    first* {.importc: "first".}: ptr TblCell ## @import{[[code:struct!tbl_row.field!first]]}
    last* {.importc: "last".}: ptr TblCell ## @import{[[code:struct!tbl_row.field!last]]}
    vert* {.importc: "vert".}: cint ## @import{[[code:struct!tbl_row.field!vert]]}
    



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `tbl_opts`
  # Declared in tbl.h:19
  TblOpts* {.bycopy, importc: "struct tbl_opts", header: allHeaders.} = object
    ## @import{[[code:struct!tbl_opts]]}
    opts* {.importc: "opts".}: cint ## @import{[[code:struct!tbl_opts.field!opts]]}
    cols* {.importc: "cols".}: cint ## @import{[[code:struct!tbl_opts.field!cols]]}
    lvert* {.importc: "lvert".}: cint ## @import{[[code:struct!tbl_opts.field!lvert]]}
    rvert* {.importc: "rvert".}: cint ## @import{[[code:struct!tbl_opts.field!rvert]]}
    tab* {.importc: "tab".}: cchar ## @import{[[code:struct!tbl_opts.field!tab]]}
    decimal* {.importc: "decimal".}: cchar ## @import{[[code:struct!tbl_opts.field!decimal]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdoc_disp`
  # Declared in mdoc.h:91
  MdocDispC* {.importc: "enum mdoc_disp", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_disp]]}
    mdocDisp_DISP_NONE = 0, mdocDisp_DISP_centered = 1, mdocDisp_DISP_ragged = 2,
    mdocDisp_DISP_unfilled = 3, mdocDisp_DISP_filled = 4,
    mdocDisp_DISP_literal = 5



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  RoffTok* = enum
    rtRoffBr,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_br]]}
    rtRoffCe,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ce]]}
    rtRoffFi,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_fi]]}
    rtRoffFt,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ft]]}
    rtRoffLl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ll]]}
    rtRoffMc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_mc]]}
    rtRoffNf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nf]]}
    rtRoffPo,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_po]]}
    rtRoffRj,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rj]]}
    rtRoffSp,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_sp]]}
    rtRoffTa,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ta]]}
    rtRoffTi,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ti]]}
    rtRoffMax,                ## @import{[[code:enum!roff_tok.enumField!ROFF_MAX]]}
    rtRoffAb,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ab]]}
    rtRoffAd,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ad]]}
    rtRoffAf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_af]]}
    rtRoffAln,                ## @import{[[code:enum!roff_tok.enumField!ROFF_aln]]}
    rtRoffAls,                ## @import{[[code:enum!roff_tok.enumField!ROFF_als]]}
    rtRoffAm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_am]]}
    rtRoffAm1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_am1]]}
    rtRoffAmi,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ami]]}
    rtRoffAmi1,               ## @import{[[code:enum!roff_tok.enumField!ROFF_ami1]]}
    rtRoffAs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_as]]}
    rtRoffAs1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_as1]]}
    rtRoffAsciify,            ## @import{[[code:enum!roff_tok.enumField!ROFF_asciify]]}
    rtRoffBacktrace,          ## @import{[[code:enum!roff_tok.enumField!ROFF_backtrace]]}
    rtRoffBd,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_bd]]}
    rtRoffBleedat,            ## @import{[[code:enum!roff_tok.enumField!ROFF_bleedat]]}
    rtRoffBlm,                ## @import{[[code:enum!roff_tok.enumField!ROFF_blm]]}
    rtRoffBox,                ## @import{[[code:enum!roff_tok.enumField!ROFF_box]]}
    rtRoffBoxa,               ## @import{[[code:enum!roff_tok.enumField!ROFF_boxa]]}
    rtRoffBp,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_bp]]}
    rtRoffBp1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_BP]]}
    rtRoffBreak,              ## @import{[[code:enum!roff_tok.enumField!ROFF_break]]}
    rtRoffBreakchar,          ## @import{[[code:enum!roff_tok.enumField!ROFF_breakchar]]}
    rtRoffBrnl,               ## @import{[[code:enum!roff_tok.enumField!ROFF_brnl]]}
    rtRoffBrp,                ## @import{[[code:enum!roff_tok.enumField!ROFF_brp]]}
    rtRoffBrpnl,              ## @import{[[code:enum!roff_tok.enumField!ROFF_brpnl]]}
    rtRoffC2,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_c2]]}
    rtRoffCc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_cc]]}
    rtRoffCf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_cf]]}
    rtRoffCflags,             ## @import{[[code:enum!roff_tok.enumField!ROFF_cflags]]}
    rtRoffCh,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ch]]}
    rtRoffChar,               ## @import{[[code:enum!roff_tok.enumField!ROFF_char]]}
    rtRoffChop,               ## @import{[[code:enum!roff_tok.enumField!ROFF_chop]]}
    rtRoffClass,              ## @import{[[code:enum!roff_tok.enumField!ROFF_class]]}
    rtRoffClose,              ## @import{[[code:enum!roff_tok.enumField!ROFF_close]]}
    rtRoffCl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_CL]]}
    rtRoffColor,              ## @import{[[code:enum!roff_tok.enumField!ROFF_color]]}
    rtRoffComposite,          ## @import{[[code:enum!roff_tok.enumField!ROFF_composite]]}
    rtRoffContinue,           ## @import{[[code:enum!roff_tok.enumField!ROFF_continue]]}
    rtRoffCp,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_cp]]}
    rtRoffCropat,             ## @import{[[code:enum!roff_tok.enumField!ROFF_cropat]]}
    rtRoffCs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_cs]]}
    rtRoffCu,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_cu]]}
    rtRoffDa,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_da]]}
    rtRoffDch,                ## @import{[[code:enum!roff_tok.enumField!ROFF_dch]]}
    rtRoffDd,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_Dd]]}
    rtRoffDe,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_de]]}
    rtRoffDe1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_de1]]}
    rtRoffDefcolor,           ## @import{[[code:enum!roff_tok.enumField!ROFF_defcolor]]}
    rtRoffDei,                ## @import{[[code:enum!roff_tok.enumField!ROFF_dei]]}
    rtRoffDei1,               ## @import{[[code:enum!roff_tok.enumField!ROFF_dei1]]}
    rtRoffDevice,             ## @import{[[code:enum!roff_tok.enumField!ROFF_device]]}
    rtRoffDevicem,            ## @import{[[code:enum!roff_tok.enumField!ROFF_devicem]]}
    rtRoffDi,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_di]]}
    rtRoffDo,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_do]]}
    rtRoffDs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ds]]}
    rtRoffDs1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ds1]]}
    rtRoffDwh,                ## @import{[[code:enum!roff_tok.enumField!ROFF_dwh]]}
    rtRoffDt,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_dt]]}
    rtRoffEc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ec]]}
    rtRoffEcr,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ecr]]}
    rtRoffEcs,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ecs]]}
    rtRoffEl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_el]]}
    rtRoffEm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_em]]}
    rtRoffEn,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_EN]]}
    rtRoffEo,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_eo]]}
    rtRoffEp,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_EP]]}
    rtRoffEq,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_EQ]]}
    rtRoffErrprint,           ## @import{[[code:enum!roff_tok.enumField!ROFF_errprint]]}
    rtRoffEv,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ev]]}
    rtRoffEvc,                ## @import{[[code:enum!roff_tok.enumField!ROFF_evc]]}
    rtRoffEx,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ex]]}
    rtRoffFallback,           ## @import{[[code:enum!roff_tok.enumField!ROFF_fallback]]}
    rtRoffFam,                ## @import{[[code:enum!roff_tok.enumField!ROFF_fam]]}
    rtRoffFc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_fc]]}
    rtRoffFchar,              ## @import{[[code:enum!roff_tok.enumField!ROFF_fchar]]}
    rtRoffFcolor,             ## @import{[[code:enum!roff_tok.enumField!ROFF_fcolor]]}
    rtRoffFdeferlig,          ## @import{[[code:enum!roff_tok.enumField!ROFF_fdeferlig]]}
    rtRoffFeature,            ## @import{[[code:enum!roff_tok.enumField!ROFF_feature]]}
    rtRoffFkern,              ## @import{[[code:enum!roff_tok.enumField!ROFF_fkern]]}
    rtRoffFl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_fl]]}
    rtRoffFlig,               ## @import{[[code:enum!roff_tok.enumField!ROFF_flig]]}
    rtRoffFp,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_fp]]}
    rtRoffFps,                ## @import{[[code:enum!roff_tok.enumField!ROFF_fps]]}
    rtRoffFschar,             ## @import{[[code:enum!roff_tok.enumField!ROFF_fschar]]}
    rtRoffFspacewidth,        ## @import{[[code:enum!roff_tok.enumField!ROFF_fspacewidth]]}
    rtRoffFspecial,           ## @import{[[code:enum!roff_tok.enumField!ROFF_fspecial]]}
    rtRoffFtr,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ftr]]}
    rtRoffFzoom,              ## @import{[[code:enum!roff_tok.enumField!ROFF_fzoom]]}
    rtRoffGcolor,             ## @import{[[code:enum!roff_tok.enumField!ROFF_gcolor]]}
    rtRoffHc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_hc]]}
    rtRoffHcode,              ## @import{[[code:enum!roff_tok.enumField!ROFF_hcode]]}
    rtRoffHidechar,           ## @import{[[code:enum!roff_tok.enumField!ROFF_hidechar]]}
    rtRoffHla,                ## @import{[[code:enum!roff_tok.enumField!ROFF_hla]]}
    rtRoffHlm,                ## @import{[[code:enum!roff_tok.enumField!ROFF_hlm]]}
    rtRoffHpf,                ## @import{[[code:enum!roff_tok.enumField!ROFF_hpf]]}
    rtRoffHpfa,               ## @import{[[code:enum!roff_tok.enumField!ROFF_hpfa]]}
    rtRoffHpfcode,            ## @import{[[code:enum!roff_tok.enumField!ROFF_hpfcode]]}
    rtRoffHw,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_hw]]}
    rtRoffHy,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_hy]]}
    rtRoffHylang,             ## @import{[[code:enum!roff_tok.enumField!ROFF_hylang]]}
    rtRoffHylen,              ## @import{[[code:enum!roff_tok.enumField!ROFF_hylen]]}
    rtRoffHym,                ## @import{[[code:enum!roff_tok.enumField!ROFF_hym]]}
    rtRoffHypp,               ## @import{[[code:enum!roff_tok.enumField!ROFF_hypp]]}
    rtRoffHys,                ## @import{[[code:enum!roff_tok.enumField!ROFF_hys]]}
    rtRoffIe,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ie]]}
    rtRoffIf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_if]]}
    rtRoffIg,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ig]]}
    rtRoffIndex,              ## @import{[[code:enum!roff_tok.enumField!ROFF_index]]}
    rtRoffIt,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_it]]}
    rtRoffItc,                ## @import{[[code:enum!roff_tok.enumField!ROFF_itc]]}
    rtRoffIx,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_IX]]}
    rtRoffKern,               ## @import{[[code:enum!roff_tok.enumField!ROFF_kern]]}
    rtRoffKernafter,          ## @import{[[code:enum!roff_tok.enumField!ROFF_kernafter]]}
    rtRoffKernbefore,         ## @import{[[code:enum!roff_tok.enumField!ROFF_kernbefore]]}
    rtRoffKernpair,           ## @import{[[code:enum!roff_tok.enumField!ROFF_kernpair]]}
    rtRoffLc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_lc]]}
    rtRoffLcCtype,            ## @import{[[code:enum!roff_tok.enumField!ROFF_lc_ctype]]}
    rtRoffLds,                ## @import{[[code:enum!roff_tok.enumField!ROFF_lds]]}
    rtRoffLength,             ## @import{[[code:enum!roff_tok.enumField!ROFF_length]]}
    rtRoffLetadj,             ## @import{[[code:enum!roff_tok.enumField!ROFF_letadj]]}
    rtRoffLf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_lf]]}
    rtRoffLg,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_lg]]}
    rtRoffLhang,              ## @import{[[code:enum!roff_tok.enumField!ROFF_lhang]]}
    rtRoffLinetabs,           ## @import{[[code:enum!roff_tok.enumField!ROFF_linetabs]]}
    rtRoffLnr,                ## @import{[[code:enum!roff_tok.enumField!ROFF_lnr]]}
    rtRoffLnrf,               ## @import{[[code:enum!roff_tok.enumField!ROFF_lnrf]]}
    rtRoffLpfx,               ## @import{[[code:enum!roff_tok.enumField!ROFF_lpfx]]}
    rtRoffLs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ls]]}
    rtRoffLsm,                ## @import{[[code:enum!roff_tok.enumField!ROFF_lsm]]}
    rtRoffLt,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_lt]]}
    rtRoffMediasize,          ## @import{[[code:enum!roff_tok.enumField!ROFF_mediasize]]}
    rtRoffMinss,              ## @import{[[code:enum!roff_tok.enumField!ROFF_minss]]}
    rtRoffMk,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_mk]]}
    rtRoffMso,                ## @import{[[code:enum!roff_tok.enumField!ROFF_mso]]}
    rtRoffNa,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_na]]}
    rtRoffNe,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ne]]}
    rtRoffNh,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nh]]}
    rtRoffNhychar,            ## @import{[[code:enum!roff_tok.enumField!ROFF_nhychar]]}
    rtRoffNm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nm]]}
    rtRoffNn,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nn]]}
    rtRoffNop,                ## @import{[[code:enum!roff_tok.enumField!ROFF_nop]]}
    rtRoffNr,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nr]]}
    rtRoffNrf,                ## @import{[[code:enum!roff_tok.enumField!ROFF_nrf]]}
    rtRoffNroff,              ## @import{[[code:enum!roff_tok.enumField!ROFF_nroff]]}
    rtRoffNs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ns]]}
    rtRoffNx,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_nx]]}
    rtRoffOpen,               ## @import{[[code:enum!roff_tok.enumField!ROFF_open]]}
    rtRoffOpena,              ## @import{[[code:enum!roff_tok.enumField!ROFF_opena]]}
    rtRoffOs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_os]]}
    rtRoffOutput,             ## @import{[[code:enum!roff_tok.enumField!ROFF_output]]}
    rtRoffPadj,               ## @import{[[code:enum!roff_tok.enumField!ROFF_padj]]}
    rtRoffPapersize,          ## @import{[[code:enum!roff_tok.enumField!ROFF_papersize]]}
    rtRoffPc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_pc]]}
    rtRoffPev,                ## @import{[[code:enum!roff_tok.enumField!ROFF_pev]]}
    rtRoffPi,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_pi]]}
    rtRoffPi1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_PI]]}
    rtRoffPl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_pl]]}
    rtRoffPm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_pm]]}
    rtRoffPn,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_pn]]}
    rtRoffPnr,                ## @import{[[code:enum!roff_tok.enumField!ROFF_pnr]]}
    rtRoffPs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ps]]}
    rtRoffPsbb,               ## @import{[[code:enum!roff_tok.enumField!ROFF_psbb]]}
    rtRoffPshape,             ## @import{[[code:enum!roff_tok.enumField!ROFF_pshape]]}
    rtRoffPso,                ## @import{[[code:enum!roff_tok.enumField!ROFF_pso]]}
    rtRoffPtr,                ## @import{[[code:enum!roff_tok.enumField!ROFF_ptr]]}
    rtRoffPvs,                ## @import{[[code:enum!roff_tok.enumField!ROFF_pvs]]}
    rtRoffRchar,              ## @import{[[code:enum!roff_tok.enumField!ROFF_rchar]]}
    rtRoffRd,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rd]]}
    rtRoffRecursionlimit,     ## @import{[[code:enum!roff_tok.enumField!ROFF_recursionlimit]]}
    rtRoffReturn,             ## @import{[[code:enum!roff_tok.enumField!ROFF_return]]}
    rtRoffRfschar,            ## @import{[[code:enum!roff_tok.enumField!ROFF_rfschar]]}
    rtRoffRhang,              ## @import{[[code:enum!roff_tok.enumField!ROFF_rhang]]}
    rtRoffRm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rm]]}
    rtRoffRn,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rn]]}
    rtRoffRnn,                ## @import{[[code:enum!roff_tok.enumField!ROFF_rnn]]}
    rtRoffRr,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rr]]}
    rtRoffRs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rs]]}
    rtRoffRt,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_rt]]}
    rtRoffSchar,              ## @import{[[code:enum!roff_tok.enumField!ROFF_schar]]}
    rtRoffSentchar,           ## @import{[[code:enum!roff_tok.enumField!ROFF_sentchar]]}
    rtRoffShc,                ## @import{[[code:enum!roff_tok.enumField!ROFF_shc]]}
    rtRoffShift,              ## @import{[[code:enum!roff_tok.enumField!ROFF_shift]]}
    rtRoffSizes,              ## @import{[[code:enum!roff_tok.enumField!ROFF_sizes]]}
    rtRoffSo,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_so]]}
    rtRoffSpacewidth,         ## @import{[[code:enum!roff_tok.enumField!ROFF_spacewidth]]}
    rtRoffSpecial,            ## @import{[[code:enum!roff_tok.enumField!ROFF_special]]}
    rtRoffSpreadwarn,         ## @import{[[code:enum!roff_tok.enumField!ROFF_spreadwarn]]}
    rtRoffSs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ss]]}
    rtRoffSty,                ## @import{[[code:enum!roff_tok.enumField!ROFF_sty]]}
    rtRoffSubstring,          ## @import{[[code:enum!roff_tok.enumField!ROFF_substring]]}
    rtRoffSv,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_sv]]}
    rtRoffSy,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_sy]]}
    rtRoffT,                  ## @import{[[code:enum!roff_tok.enumField!ROFF_T_]]}
    rtRoffTc,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_tc]]}
    rtRoffTe,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_TE]]}
    rtRoffTh,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_TH]]}
    rtRoffTkf,                ## @import{[[code:enum!roff_tok.enumField!ROFF_tkf]]}
    rtRoffTl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_tl]]}
    rtRoffTm,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_tm]]}
    rtRoffTm1,                ## @import{[[code:enum!roff_tok.enumField!ROFF_tm1]]}
    rtRoffTmc,                ## @import{[[code:enum!roff_tok.enumField!ROFF_tmc]]}
    rtRoffTr,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_tr]]}
    rtRoffTrack,              ## @import{[[code:enum!roff_tok.enumField!ROFF_track]]}
    rtRoffTranschar,          ## @import{[[code:enum!roff_tok.enumField!ROFF_transchar]]}
    rtRoffTrf,                ## @import{[[code:enum!roff_tok.enumField!ROFF_trf]]}
    rtRoffTrimat,             ## @import{[[code:enum!roff_tok.enumField!ROFF_trimat]]}
    rtRoffTrin,               ## @import{[[code:enum!roff_tok.enumField!ROFF_trin]]}
    rtRoffTrnt,               ## @import{[[code:enum!roff_tok.enumField!ROFF_trnt]]}
    rtRoffTroff,              ## @import{[[code:enum!roff_tok.enumField!ROFF_troff]]}
    rtRoffTs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_TS]]}
    rtRoffUf,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_uf]]}
    rtRoffUl,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_ul]]}
    rtRoffUnformat,           ## @import{[[code:enum!roff_tok.enumField!ROFF_unformat]]}
    rtRoffUnwatch,            ## @import{[[code:enum!roff_tok.enumField!ROFF_unwatch]]}
    rtRoffUnwatchn,           ## @import{[[code:enum!roff_tok.enumField!ROFF_unwatchn]]}
    rtRoffVpt,                ## @import{[[code:enum!roff_tok.enumField!ROFF_vpt]]}
    rtRoffVs,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_vs]]}
    rtRoffWarn,               ## @import{[[code:enum!roff_tok.enumField!ROFF_warn]]}
    rtRoffWarnscale,          ## @import{[[code:enum!roff_tok.enumField!ROFF_warnscale]]}
    rtRoffWatch,              ## @import{[[code:enum!roff_tok.enumField!ROFF_watch]]}
    rtRoffWatchlength,        ## @import{[[code:enum!roff_tok.enumField!ROFF_watchlength]]}
    rtRoffWatchn,             ## @import{[[code:enum!roff_tok.enumField!ROFF_watchn]]}
    rtRoffWh,                 ## @import{[[code:enum!roff_tok.enumField!ROFF_wh]]}
    rtRoffWhile,              ## @import{[[code:enum!roff_tok.enumField!ROFF_while]]}
    rtRoffWrite,              ## @import{[[code:enum!roff_tok.enumField!ROFF_write]]}
    rtRoffWritec,             ## @import{[[code:enum!roff_tok.enumField!ROFF_writec]]}
    rtRoffWritem,             ## @import{[[code:enum!roff_tok.enumField!ROFF_writem]]}
    rtRoffXflag,              ## @import{[[code:enum!roff_tok.enumField!ROFF_xflag]]}
    rtRoffCblock,             ## @import{[[code:enum!roff_tok.enumField!ROFF_cblock]]}
    rtRoffRenamed,            ## @import{[[code:enum!roff_tok.enumField!ROFF_RENAMED]]}
    rtRoffUserdef,            ## @import{[[code:enum!roff_tok.enumField!ROFF_USERDEF]]}
    rtTokenNone,              ## @import{[[code:enum!roff_tok.enumField!TOKEN_NONE]]}
    rtMdocDd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dd]]}
    rtMdocDt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dt]]}
    rtMdocOs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Os]]}
    rtMdocSh,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sh]]}
    rtMdocSs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ss]]}
    rtMdocPp,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Pp]]}
    rtMdocD1,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_D1]]}
    rtMdocDl,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dl]]}
    rtMdocBd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bd]]}
    rtMdocEd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ed]]}
    rtMdocBl,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bl]]}
    rtMdocEl,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_El]]}
    rtMdocIt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_It]]}
    rtMdocAd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ad]]}
    rtMdocAn,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_An]]}
    rtMdocAp,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ap]]}
    rtMdocAr,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ar]]}
    rtMdocCd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Cd]]}
    rtMdocCm,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Cm]]}
    rtMdocDv,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dv]]}
    rtMdocEr,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Er]]}
    rtMdocEv,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ev]]}
    rtMdocEx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ex]]}
    rtMdocFa,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fa]]}
    rtMdocFd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fd]]}
    rtMdocFl,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fl]]}
    rtMdocFn,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fn]]}
    rtMdocFt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ft]]}
    rtMdocIc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ic]]}
    rtMdocIn,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_In]]}
    rtMdocLi,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Li]]}
    rtMdocNd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Nd]]}
    rtMdocNm,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Nm]]}
    rtMdocOp,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Op]]}
    rtMdocOt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ot]]}
    rtMdocPa,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Pa]]}
    rtMdocRv,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Rv]]}
    rtMdocSt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_St]]}
    rtMdocVa,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Va]]}
    rtMdocVt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Vt]]}
    rtMdocXr,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Xr]]}
    rtMdocA,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__A]]}
    rtMdocB,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__B]]}
    rtMdocD,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__D]]}
    rtMdocI,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__I]]}
    rtMdocJ,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__J]]}
    rtMdocN,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__N]]}
    rtMdocO,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__O]]}
    rtMdocP,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__P]]}
    rtMdocR,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__R]]}
    rtMdocT,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__T]]}
    rtMdocV,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__V]]}
    rtMdocAc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ac]]}
    rtMdocAo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ao]]}
    rtMdocAq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Aq]]}
    rtMdocAt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_At]]}
    rtMdocBc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bc]]}
    rtMdocBf,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bf]]}
    rtMdocBo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bo]]}
    rtMdocBq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bq]]}
    rtMdocBsx,                ## @import{[[code:enum!roff_tok.enumField!MDOC_Bsx]]}
    rtMdocBx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bx]]}
    rtMdocDb,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Db]]}
    rtMdocDc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dc]]}
    rtMdocDo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Do]]}
    rtMdocDq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dq]]}
    rtMdocEc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ec]]}
    rtMdocEf,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ef]]}
    rtMdocEm,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Em]]}
    rtMdocEo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Eo]]}
    rtMdocFx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fx]]}
    rtMdocMs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ms]]}
    rtMdocNo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_No]]}
    rtMdocNs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ns]]}
    rtMdocNx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Nx]]}
    rtMdocOx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ox]]}
    rtMdocPc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Pc]]}
    rtMdocPf,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Pf]]}
    rtMdocPo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Po]]}
    rtMdocPq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Pq]]}
    rtMdocQc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Qc]]}
    rtMdocQl,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ql]]}
    rtMdocQo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Qo]]}
    rtMdocQq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Qq]]}
    rtMdocRe,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Re]]}
    rtMdocRs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Rs]]}
    rtMdocSc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sc]]}
    rtMdocSo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_So]]}
    rtMdocSq,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sq]]}
    rtMdocSm,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sm]]}
    rtMdocSx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sx]]}
    rtMdocSy,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Sy]]}
    rtMdocTn,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Tn]]}
    rtMdocUx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ux]]}
    rtMdocXc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Xc]]}
    rtMdocXo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Xo]]}
    rtMdocFo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fo]]}
    rtMdocFc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fc]]}
    rtMdocOo,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Oo]]}
    rtMdocOc,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Oc]]}
    rtMdocBk,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bk]]}
    rtMdocEk,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ek]]}
    rtMdocBt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Bt]]}
    rtMdocHf,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Hf]]}
    rtMdocFr,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Fr]]}
    rtMdocUd,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ud]]}
    rtMdocLb,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Lb]]}
    rtMdocLp,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Lp]]}
    rtMdocLk,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Lk]]}
    rtMdocMt,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Mt]]}
    rtMdocBrq,                ## @import{[[code:enum!roff_tok.enumField!MDOC_Brq]]}
    rtMdocBro,                ## @import{[[code:enum!roff_tok.enumField!MDOC_Bro]]}
    rtMdocBrc,                ## @import{[[code:enum!roff_tok.enumField!MDOC_Brc]]}
    rtMdocC,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__C]]}
    rtMdocEs,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Es]]}
    rtMdocEn,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_En]]}
    rtMdocDx,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Dx]]}
    rtMdocQ,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__Q]]}
    rtMdocU,                  ## @import{[[code:enum!roff_tok.enumField!MDOC__U]]}
    rtMdocTa,                 ## @import{[[code:enum!roff_tok.enumField!MDOC_Ta]]}
    rtMdocMax,                ## @import{[[code:enum!roff_tok.enumField!MDOC_MAX]]}
    rtManTh,                  ## @import{[[code:enum!roff_tok.enumField!MAN_TH]]}
    rtManSh,                  ## @import{[[code:enum!roff_tok.enumField!MAN_SH]]}
    rtManSs,                  ## @import{[[code:enum!roff_tok.enumField!MAN_SS]]}
    rtManTp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_TP]]}
    rtManTq,                  ## @import{[[code:enum!roff_tok.enumField!MAN_TQ]]}
    rtManLp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_LP]]}
    rtManPp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_PP]]}
    rtManP,                   ## @import{[[code:enum!roff_tok.enumField!MAN_P]]}
    rtManIp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_IP]]}
    rtManHp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_HP]]}
    rtManSm,                  ## @import{[[code:enum!roff_tok.enumField!MAN_SM]]}
    rtManSb,                  ## @import{[[code:enum!roff_tok.enumField!MAN_SB]]}
    rtManBi,                  ## @import{[[code:enum!roff_tok.enumField!MAN_BI]]}
    rtManIb,                  ## @import{[[code:enum!roff_tok.enumField!MAN_IB]]}
    rtManBr,                  ## @import{[[code:enum!roff_tok.enumField!MAN_BR]]}
    rtManRb,                  ## @import{[[code:enum!roff_tok.enumField!MAN_RB]]}
    rtManR,                   ## @import{[[code:enum!roff_tok.enumField!MAN_R]]}
    rtManB,                   ## @import{[[code:enum!roff_tok.enumField!MAN_B]]}
    rtManI,                   ## @import{[[code:enum!roff_tok.enumField!MAN_I]]}
    rtManIr,                  ## @import{[[code:enum!roff_tok.enumField!MAN_IR]]}
    rtManRi,                  ## @import{[[code:enum!roff_tok.enumField!MAN_RI]]}
    rtManRe,                  ## @import{[[code:enum!roff_tok.enumField!MAN_RE]]}
    rtManRs,                  ## @import{[[code:enum!roff_tok.enumField!MAN_RS]]}
    rtManDt,                  ## @import{[[code:enum!roff_tok.enumField!MAN_DT]]}
    rtManUc,                  ## @import{[[code:enum!roff_tok.enumField!MAN_UC]]}
    rtManPd,                  ## @import{[[code:enum!roff_tok.enumField!MAN_PD]]}
    rtManAt,                  ## @import{[[code:enum!roff_tok.enumField!MAN_AT]]}
    rtManIn,                  ## @import{[[code:enum!roff_tok.enumField!MAN_in]]}
    rtManSy,                  ## @import{[[code:enum!roff_tok.enumField!MAN_SY]]}
    rtManYs,                  ## @import{[[code:enum!roff_tok.enumField!MAN_YS]]}
    rtManOp,                  ## @import{[[code:enum!roff_tok.enumField!MAN_OP]]}
    rtManEx,                  ## @import{[[code:enum!roff_tok.enumField!MAN_EX]]}
    rtManEe,                  ## @import{[[code:enum!roff_tok.enumField!MAN_EE]]}
    rtManUr,                  ## @import{[[code:enum!roff_tok.enumField!MAN_UR]]}
    rtManUe,                  ## @import{[[code:enum!roff_tok.enumField!MAN_UE]]}
    rtManMt,                  ## @import{[[code:enum!roff_tok.enumField!MAN_MT]]}
    rtManMe,                  ## @import{[[code:enum!roff_tok.enumField!MAN_ME]]}
    rtManMax                   ## @import{[[code:enum!roff_tok.enumField!MAN_MAX]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_rs`
  # Declared in mdoc.h:137
  MdocRs* {.bycopy, importc: "struct mdoc_rs", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_rs]]}
    quoteT* {.importc: "quote_T".}: cint ## @import{[[code:struct!mdoc_rs.field!quote_T]]}
    



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `tbl_dat`
  # Declared in tbl.h:94
  TblDat* {.bycopy, importc: "struct tbl_dat", header: allHeaders.} = object
    ## @import{[[code:struct!tbl_dat]]}
    next* {.importc: "next".}: ptr TblDat ## @import{[[code:struct!tbl_dat.field!next]]}
    layout* {.importc: "layout".}: ptr TblCell ## @import{[[code:struct!tbl_dat.field!layout]]}
    cxString* {.importc: "string".}: cstring ## @import{[[code:struct!tbl_dat.field!string]]}
    hspans* {.importc: "hspans".}: cint ## @import{[[code:struct!tbl_dat.field!hspans]]}
    vspans* {.importc: "vspans".}: cint ## @import{[[code:struct!tbl_dat.field!vspans]]}
    cxBlock* {.importc: "block".}: cint ## @import{[[code:struct!tbl_dat.field!block]]}
    pos* {.importc: "pos".}: TblDattC ## @import{[[code:struct!tbl_dat.field!pos]]}
    



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MdocAuth* = enum
    maNone,                   ## @import{[[code:enum!mdoc_auth.enumField!AUTH__NONE]]}
    maSplit,                  ## @import{[[code:enum!mdoc_auth.enumField!AUTH_split]]}
    maNosplit                  ## @import{[[code:enum!mdoc_auth.enumField!AUTH_nosplit]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `roff_macroset`
  # Declared in roff.h:27
  RoffMacrosetC* {.importc: "enum roff_macroset", header: allHeaders.} = enum ## @import{[[code:enum!roff_macroset]]}
    roffMacroset_MACROSET_NONE = 0, roffMacroset_MACROSET_MDOC = 1,
    roffMacroset_MACROSET_MAN = 2



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdocargt`
  # Declared in mdoc.h:22
  MdocargtC* {.importc: "enum mdocargt", header: allHeaders.} = enum ## @import{[[code:enum!mdocargt]]}
    mdocargt_MDOC_Split = 0, mdocargt_MDOC_Nosplit = 1, mdocargt_MDOC_Ragged = 2,
    mdocargt_MDOC_Unfilled = 3, mdocargt_MDOC_Literal = 4, mdocargt_MDOC_File = 5,
    mdocargt_MDOC_Offset = 6, mdocargt_MDOC_Bullet = 7, mdocargt_MDOC_Dash = 8,
    mdocargt_MDOC_Hyphen = 9, mdocargt_MDOC_Item = 10, mdocargt_MDOC_Enum = 11,
    mdocargt_MDOC_Tag = 12, mdocargt_MDOC_Diag = 13, mdocargt_MDOC_Hang = 14,
    mdocargt_MDOC_Ohang = 15, mdocargt_MDOC_Inset = 16, mdocargt_MDOC_Column = 17,
    mdocargt_MDOC_Width = 18, mdocargt_MDOC_Compact = 19, mdocargt_MDOC_Std = 20,
    mdocargt_MDOC_Filled = 21, mdocargt_MDOC_Words = 22,
    mdocargt_MDOC_Emphasis = 23, mdocargt_MDOC_Symbolic = 24,
    mdocargt_MDOC_Nested = 25, mdocargt_MDOC_Centred = 26,
    mdocargt_MDOC_ARG_MAX = 27



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `eqn_box`
  # Declared in eqn.h:54
  EqnBox* {.bycopy, importc: "struct eqn_box", header: allHeaders.} = object
    ## @import{[[code:struct!eqn_box]]}
    parent* {.importc: "parent".}: ptr EqnBox ## @import{[[code:struct!eqn_box.field!parent]]}
    prev* {.importc: "prev".}: ptr EqnBox ## @import{[[code:struct!eqn_box.field!prev]]}
    next* {.importc: "next".}: ptr EqnBox ## @import{[[code:struct!eqn_box.field!next]]}
    first* {.importc: "first".}: ptr EqnBox ## @import{[[code:struct!eqn_box.field!first]]}
    last* {.importc: "last".}: ptr EqnBox ## @import{[[code:struct!eqn_box.field!last]]}
    text* {.importc: "text".}: cstring ## @import{[[code:struct!eqn_box.field!text]]}
    left* {.importc: "left".}: cstring ## @import{[[code:struct!eqn_box.field!left]]}
    right* {.importc: "right".}: cstring ## @import{[[code:struct!eqn_box.field!right]]}
    top* {.importc: "top".}: cstring ## @import{[[code:struct!eqn_box.field!top]]}
    bottom* {.importc: "bottom".}: cstring ## @import{[[code:struct!eqn_box.field!bottom]]}
    expectargs* {.importc: "expectargs".}: SizeT ## @import{[[code:struct!eqn_box.field!expectargs]]}
    args* {.importc: "args".}: SizeT ## @import{[[code:struct!eqn_box.field!args]]}
    size* {.importc: "size".}: cint ## @import{[[code:struct!eqn_box.field!size]]}
    cxType* {.importc: "type".}: EqnBoxtC ## @import{[[code:struct!eqn_box.field!type]]}
    font* {.importc: "font".}: EqnFonttC ## @import{[[code:struct!eqn_box.field!font]]}
    pos* {.importc: "pos".}: EqnPostC ## @import{[[code:struct!eqn_box.field!pos]]}
    



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `tbl_cell`
  # Declared in tbl.h:52
  TblCell* {.bycopy, importc: "struct tbl_cell", header: allHeaders.} = object
    ## @import{[[code:struct!tbl_cell]]}
    next* {.importc: "next".}: ptr TblCell ## @import{[[code:struct!tbl_cell.field!next]]}
    wstr* {.importc: "wstr".}: cstring ## @import{[[code:struct!tbl_cell.field!wstr]]}
    width* {.importc: "width".}: SizeT ## @import{[[code:struct!tbl_cell.field!width]]}
    spacing* {.importc: "spacing".}: SizeT ## @import{[[code:struct!tbl_cell.field!spacing]]}
    vert* {.importc: "vert".}: cint ## @import{[[code:struct!tbl_cell.field!vert]]}
    col* {.importc: "col".}: cint ## @import{[[code:struct!tbl_cell.field!col]]}
    flags* {.importc: "flags".}: cint ## @import{[[code:struct!tbl_cell.field!flags]]}
    pos* {.importc: "pos".}: TblCelltC ## @import{[[code:struct!tbl_cell.field!pos]]}
    



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  TblDatt* = enum
    tdNone,                   ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NONE]]}
    tdData,                   ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_DATA]]}
    tdHoriz,                  ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_HORIZ]]}
    tdDhoriz,                 ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_DHORIZ]]}
    tdNhoriz,                 ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NHORIZ]]}
    tdNdhoriz                  ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NDHORIZ]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  TblSpant* = enum
    tsData,                   ## @import{[[code:enum!tbl_spant.enumField!TBL_SPAN_DATA]]}
    tsHoriz,                  ## @import{[[code:enum!tbl_spant.enumField!TBL_SPAN_HORIZ]]}
    tsDhoriz                   ## @import{[[code:enum!tbl_spant.enumField!TBL_SPAN_DHORIZ]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  TblCellt* = enum
    tcCentre,                 ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_CENTRE]]}
    tcRight,                  ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_RIGHT]]}
    tcLeft,                   ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_LEFT]]}
    tcNumber,                 ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_NUMBER]]}
    tcSpan,                   ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_SPAN]]}
    tcLong,                   ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_LONG]]}
    tcDown,                   ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_DOWN]]}
    tcHoriz,                  ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_HORIZ]]}
    tcDhoriz,                 ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_DHORIZ]]}
    tcMax                      ## @import{[[code:enum!tbl_cellt.enumField!TBL_CELL_MAX]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_argv`
  # Declared in mdoc.h:56
  MdocArgv* {.bycopy, importc: "struct mdoc_argv", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_argv]]}
    arg* {.importc: "arg".}: MdocargtC ## @import{[[code:struct!mdoc_argv.field!arg]]}
    line* {.importc: "line".}: cint ## @import{[[code:struct!mdoc_argv.field!line]]}
    pos* {.importc: "pos".}: cint ## @import{[[code:struct!mdoc_argv.field!pos]]}
    sz* {.importc: "sz".}: SizeT ## @import{[[code:struct!mdoc_argv.field!sz]]}
    value* {.importc: "value".}: cstringArray ## @import{[[code:struct!mdoc_argv.field!value]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `roff_sec`
  # Declared in roff.h:33
  RoffSecC* {.importc: "enum roff_sec", header: allHeaders.} = enum ## @import{[[code:enum!roff_sec]]}
    roffSec_SEC_NONE = 0, roffSec_SEC_NAME = 1, roffSec_SEC_LIBRARY = 2,
    roffSec_SEC_SYNOPSIS = 3, roffSec_SEC_DESCRIPTION = 4,
    roffSec_SEC_CONTEXT = 5, roffSec_SEC_IMPLEMENTATION = 6,
    roffSec_SEC_RETURN_VALUES = 7, roffSec_SEC_ENVIRONMENT = 8,
    roffSec_SEC_FILES = 9, roffSec_SEC_EXIT_STATUS = 10,
    roffSec_SEC_EXAMPLES = 11, roffSec_SEC_DIAGNOSTICS = 12,
    roffSec_SEC_COMPATIBILITY = 13, roffSec_SEC_ERRORS = 14,
    roffSec_SEC_SEE_ALSO = 15, roffSec_SEC_STANDARDS = 16,
    roffSec_SEC_HISTORY = 17, roffSec_SEC_AUTHORS = 18, roffSec_SEC_CAVEATS = 19,
    roffSec_SEC_BUGS = 20, roffSec_SEC_SECURITY = 21, roffSec_SEC_CUSTOM = 22,
    roffSec_SEC_MAX = 23



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  EqnPost* = enum
    epNone,                   ## @import{[[code:enum!eqn_post.enumField!EQNPOS_NONE]]}
    epSup,                    ## @import{[[code:enum!eqn_post.enumField!EQNPOS_SUP]]}
    epSubsup,                 ## @import{[[code:enum!eqn_post.enumField!EQNPOS_SUBSUP]]}
    epSub,                    ## @import{[[code:enum!eqn_post.enumField!EQNPOS_SUB]]}
    epTo,                     ## @import{[[code:enum!eqn_post.enumField!EQNPOS_TO]]}
    epFrom,                   ## @import{[[code:enum!eqn_post.enumField!EQNPOS_FROM]]}
    epFromto,                 ## @import{[[code:enum!eqn_post.enumField!EQNPOS_FROMTO]]}
    epOver,                   ## @import{[[code:enum!eqn_post.enumField!EQNPOS_OVER]]}
    epSqrt,                   ## @import{[[code:enum!eqn_post.enumField!EQNPOS_SQRT]]}
    epMax                      ## @import{[[code:enum!eqn_post.enumField!EQNPOS__MAX]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mdoc_endbody`
  # Declared in roff.h:485
  MdocEndbodyC* {.importc: "enum mdoc_endbody", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_endbody]]}
    mdocEndbody_ENDBODY_NOT = 0, mdocEndbody_ENDBODY_SPACE = 1



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  RoffMacroset* = enum
    rmNone,                   ## @import{[[code:enum!roff_macroset.enumField!MACROSET_NONE]]}
    rmMdoc,                   ## @import{[[code:enum!roff_macroset.enumField!MACROSET_MDOC]]}
    rmMan                      ## @import{[[code:enum!roff_macroset.enumField!MACROSET_MAN]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_bf`
  # Declared in mdoc.h:129
  MdocBf* {.bycopy, importc: "struct mdoc_bf", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_bf]]}
    font* {.importc: "font".}: MdocFontC ## @import{[[code:struct!mdoc_bf.field!font]]}
    



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  RoffType* = enum
    rtRoot,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_ROOT]]}
    rtBlock,                  ## @import{[[code:enum!roff_type.enumField!ROFFT_BLOCK]]}
    rtHead,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_HEAD]]}
    rtBody,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_BODY]]}
    rtTail,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_TAIL]]}
    rtElem,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_ELEM]]}
    rtText,                   ## @import{[[code:enum!roff_type.enumField!ROFFT_TEXT]]}
    rtComment,                ## @import{[[code:enum!roff_type.enumField!ROFFT_COMMENT]]}
    rtTbl,                    ## @import{[[code:enum!roff_type.enumField!ROFFT_TBL]]}
    rtEqn                      ## @import{[[code:enum!roff_type.enumField!ROFFT_EQN]]}



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mdoc_arg`
  # Declared in mdoc.h:69
  MdocArg* {.bycopy, importc: "struct mdoc_arg", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_arg]]}
    argc* {.importc: "argc".}: SizeT ## @import{[[code:struct!mdoc_arg.field!argc]]}
    argv* {.importc: "argv".}: ptr MdocArgv ## @import{[[code:struct!mdoc_arg.field!argv]]}
    refcnt* {.importc: "refcnt".}: cuint ## @import{[[code:struct!mdoc_arg.field!refcnt]]}
    



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mandoc_os`
  # Declared in roff.h:490
  MandocOsC* {.importc: "enum mandoc_os", header: allHeaders.} = enum ## @import{[[code:enum!mandoc_os]]}
    mandocOs_MANDOC_OS_OTHER = 0, mandocOs_MANDOC_OS_NETBSD = 1,
    mandocOs_MANDOC_OS_OPENBSD = 2



  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `roff_node`
  # Declared in roff.h:496
  RoffNode* {.bycopy, importc: "struct roff_node", header: allHeaders.} = object
    ## @import{[[code:struct!roff_node]]}
    parent* {.importc: "parent".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!parent]]}
    child* {.importc: "child".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!child]]}
    last* {.importc: "last".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!last]]}
    next* {.importc: "next".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!next]]}
    prev* {.importc: "prev".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!prev]]}
    head* {.importc: "head".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!head]]}
    body* {.importc: "body".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!body]]}
    tail* {.importc: "tail".}: ptr RoffNode ## @import{[[code:struct!roff_node.field!tail]]}
    args* {.importc: "args".}: ptr MdocArg ## @import{[[code:struct!roff_node.field!args]]}
    norm* {.importc: "norm".}: ptr MdocData ## @import{[[code:struct!roff_node.field!norm]]}
    cxString* {.importc: "string".}: cstring ## @import{[[code:struct!roff_node.field!string]]}
    span* {.importc: "span".}: ptr TblSpan ## @import{[[code:struct!roff_node.field!span]]}
    eqn* {.importc: "eqn".}: ptr EqnBox ## @import{[[code:struct!roff_node.field!eqn]]}
    line* {.importc: "line".}: cint ## @import{[[code:struct!roff_node.field!line]]}
    pos* {.importc: "pos".}: cint ## @import{[[code:struct!roff_node.field!pos]]}
    flags* {.importc: "flags".}: cint ## @import{[[code:struct!roff_node.field!flags]]}
    prevFont* {.importc: "prev_font".}: cint ## @import{[[code:struct!roff_node.field!prev_font]]}
    aux* {.importc: "aux".}: cint ## @import{[[code:struct!roff_node.field!aux]]}
    tok* {.importc: "tok".}: RoffTokC ## @import{[[code:struct!roff_node.field!tok]]}
    cxType* {.importc: "type".}: RoffTypeC ## @import{[[code:struct!roff_node.field!type]]}
    sec* {.importc: "sec".}: RoffSecC ## @import{[[code:struct!roff_node.field!sec]]}
    cxEnd* {.importc: "end".}: MdocEndbodyC ## @import{[[code:struct!roff_node.field!end]]}
    





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `tbl_opts`
# Declared in tbl.h:19
proc cnewTblOpts*(): ptr TblOpts {.importc: r"new tbl_opts()",
                                   header: allHeaders.}
  ## @import{[[code:struct!tbl_opts]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `tbl_opts`
# Declared in tbl.h:19
proc destroyTblOpts*(obj: ptr TblOpts): void {.importc: r"#.~tbl_opts()",
    header: allHeaders.}
  ## @import{[[code:struct!tbl_opts]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `tbl_opts`
# Declared in tbl.h:19
proc newTblOpts*(): ref TblOpts =
  ## @import{[[code:struct!tbl_opts]]}
  newImportAux()
  new(result, proc (destr: ref TblOpts) =
    destroyTblOpts(addr destr[]))
  {.emit: "new ((void*)result) tbl_opts(); /* Placement new */".}



const
  arrTblCelltmapping: array[TblCellt, tuple[name: string, cEnum: TblCelltC,
      cName: string, value: cint]] = [
    (name: "TBL_CELL_CENTRE", cEnum: tblCellt_TBL_CELL_CENTRE,
     cName: "tbl_cellt::TBL_CELL_CENTRE", value: cint(0)),
    (name: "TBL_CELL_RIGHT", cEnum: tblCellt_TBL_CELL_RIGHT,
     cName: "tbl_cellt::TBL_CELL_RIGHT", value: cint(1)),
    (name: "TBL_CELL_LEFT", cEnum: tblCellt_TBL_CELL_LEFT,
     cName: "tbl_cellt::TBL_CELL_LEFT", value: cint(2)),
    (name: "TBL_CELL_NUMBER", cEnum: tblCellt_TBL_CELL_NUMBER,
     cName: "tbl_cellt::TBL_CELL_NUMBER", value: cint(3)),
    (name: "TBL_CELL_SPAN", cEnum: tblCellt_TBL_CELL_SPAN,
     cName: "tbl_cellt::TBL_CELL_SPAN", value: cint(4)),
    (name: "TBL_CELL_LONG", cEnum: tblCellt_TBL_CELL_LONG,
     cName: "tbl_cellt::TBL_CELL_LONG", value: cint(5)),
    (name: "TBL_CELL_DOWN", cEnum: tblCellt_TBL_CELL_DOWN,
     cName: "tbl_cellt::TBL_CELL_DOWN", value: cint(6)),
    (name: "TBL_CELL_HORIZ", cEnum: tblCellt_TBL_CELL_HORIZ,
     cName: "tbl_cellt::TBL_CELL_HORIZ", value: cint(7)),
    (name: "TBL_CELL_DHORIZ", cEnum: tblCellt_TBL_CELL_DHORIZ,
     cName: "tbl_cellt::TBL_CELL_DHORIZ", value: cint(8)),
    (name: "TBL_CELL_MAX", cEnum: tblCellt_TBL_CELL_MAX,
     cName: "tbl_cellt::TBL_CELL_MAX", value: cint(9))]
proc toCInt*(en: TblCellt): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrTblCelltmapping[en].value

proc toCInt*(en: set[TblCellt]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrTblCelltmapping[val].value)

proc `$`*(en: TblCelltC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of tblCellt_TBL_CELL_CENTRE:
    result = "tbl_cellt::TBL_CELL_CENTRE"
  of tblCellt_TBL_CELL_RIGHT:
    result = "tbl_cellt::TBL_CELL_RIGHT"
  of tblCellt_TBL_CELL_LEFT:
    result = "tbl_cellt::TBL_CELL_LEFT"
  of tblCellt_TBL_CELL_NUMBER:
    result = "tbl_cellt::TBL_CELL_NUMBER"
  of tblCellt_TBL_CELL_SPAN:
    result = "tbl_cellt::TBL_CELL_SPAN"
  of tblCellt_TBL_CELL_LONG:
    result = "tbl_cellt::TBL_CELL_LONG"
  of tblCellt_TBL_CELL_DOWN:
    result = "tbl_cellt::TBL_CELL_DOWN"
  of tblCellt_TBL_CELL_HORIZ:
    result = "tbl_cellt::TBL_CELL_HORIZ"
  of tblCellt_TBL_CELL_DHORIZ:
    result = "tbl_cellt::TBL_CELL_DHORIZ"
  of tblCellt_TBL_CELL_MAX:
    result = "tbl_cellt::TBL_CELL_MAX"
  
func toTblCellt*(en: TblCelltC): TblCellt {.inline.} =
  case en
  of tblCellt_TBL_CELL_CENTRE:
    tcCentre
  of tblCellt_TBL_CELL_RIGHT:
    tcRight
  of tblCellt_TBL_CELL_LEFT:
    tcLeft
  of tblCellt_TBL_CELL_NUMBER:
    tcNumber
  of tblCellt_TBL_CELL_SPAN:
    tcSpan
  of tblCellt_TBL_CELL_LONG:
    tcLong
  of tblCellt_TBL_CELL_DOWN:
    tcDown
  of tblCellt_TBL_CELL_HORIZ:
    tcHoriz
  of tblCellt_TBL_CELL_DHORIZ:
    tcDhoriz
  of tblCellt_TBL_CELL_MAX:
    tcMax
  
converter toTblCelltC*(en: TblCellt): TblCelltC {.inline.} =
  arrTblCelltmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `tbl_cell`
# Declared in tbl.h:52
proc cnewTblCell*(): ptr TblCell {.importc: r"new tbl_cell()",
                                   header: allHeaders.}
  ## @import{[[code:struct!tbl_cell]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `tbl_cell`
# Declared in tbl.h:52
proc destroyTblCell*(obj: ptr TblCell): void {.importc: r"#.~tbl_cell()",
    header: allHeaders.}
  ## @import{[[code:struct!tbl_cell]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `tbl_cell`
# Declared in tbl.h:52
proc newTblCell*(): ref TblCell =
  ## @import{[[code:struct!tbl_cell]]}
  newImportAux()
  new(result, proc (destr: ref TblCell) =
    destroyTblCell(addr destr[]))
  {.emit: "new ((void*)result) tbl_cell(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `tbl_row`
# Declared in tbl.h:74
proc cnewTblRow*(): ptr TblRow {.importc: r"new tbl_row()", header: allHeaders.}
  ## @import{[[code:struct!tbl_row]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `tbl_row`
# Declared in tbl.h:74
proc destroyTblRow*(obj: ptr TblRow): void {.importc: r"#.~tbl_row()",
    header: allHeaders.}
  ## @import{[[code:struct!tbl_row]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `tbl_row`
# Declared in tbl.h:74
proc newTblRow*(): ref TblRow =
  ## @import{[[code:struct!tbl_row]]}
  newImportAux()
  new(result, proc (destr: ref TblRow) =
    destroyTblRow(addr destr[]))
  {.emit: "new ((void*)result) tbl_row(); /* Placement new */".}



const
  arrTblDattmapping: array[TblDatt, tuple[name: string, cEnum: TblDattC,
      cName: string, value: cint]] = [
    (name: "TBL_DATA_NONE", cEnum: tblDatt_TBL_DATA_NONE,
     cName: "tbl_datt::TBL_DATA_NONE", value: cint(0)),
    (name: "TBL_DATA_DATA", cEnum: tblDatt_TBL_DATA_DATA,
     cName: "tbl_datt::TBL_DATA_DATA", value: cint(1)),
    (name: "TBL_DATA_HORIZ", cEnum: tblDatt_TBL_DATA_HORIZ,
     cName: "tbl_datt::TBL_DATA_HORIZ", value: cint(2)),
    (name: "TBL_DATA_DHORIZ", cEnum: tblDatt_TBL_DATA_DHORIZ,
     cName: "tbl_datt::TBL_DATA_DHORIZ", value: cint(3)),
    (name: "TBL_DATA_NHORIZ", cEnum: tblDatt_TBL_DATA_NHORIZ,
     cName: "tbl_datt::TBL_DATA_NHORIZ", value: cint(4)),
    (name: "TBL_DATA_NDHORIZ", cEnum: tblDatt_TBL_DATA_NDHORIZ,
     cName: "tbl_datt::TBL_DATA_NDHORIZ", value: cint(5))]
proc toCInt*(en: TblDatt): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrTblDattmapping[en].value

proc toCInt*(en: set[TblDatt]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrTblDattmapping[val].value)

proc `$`*(en: TblDattC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of tblDatt_TBL_DATA_NONE:
    result = "tbl_datt::TBL_DATA_NONE"
  of tblDatt_TBL_DATA_DATA:
    result = "tbl_datt::TBL_DATA_DATA"
  of tblDatt_TBL_DATA_HORIZ:
    result = "tbl_datt::TBL_DATA_HORIZ"
  of tblDatt_TBL_DATA_DHORIZ:
    result = "tbl_datt::TBL_DATA_DHORIZ"
  of tblDatt_TBL_DATA_NHORIZ:
    result = "tbl_datt::TBL_DATA_NHORIZ"
  of tblDatt_TBL_DATA_NDHORIZ:
    result = "tbl_datt::TBL_DATA_NDHORIZ"
  
func toTblDatt*(en: TblDattC): TblDatt {.inline.} =
  case en
  of tblDatt_TBL_DATA_NONE:
    tdNone
  of tblDatt_TBL_DATA_DATA:
    tdData
  of tblDatt_TBL_DATA_HORIZ:
    tdHoriz
  of tblDatt_TBL_DATA_DHORIZ:
    tdDhoriz
  of tblDatt_TBL_DATA_NHORIZ:
    tdNhoriz
  of tblDatt_TBL_DATA_NDHORIZ:
    tdNdhoriz
  
converter toTblDattC*(en: TblDatt): TblDattC {.inline.} =
  arrTblDattmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `tbl_dat`
# Declared in tbl.h:94
proc cnewTblDat*(): ptr TblDat {.importc: r"new tbl_dat()", header: allHeaders.}
  ## @import{[[code:struct!tbl_dat]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `tbl_dat`
# Declared in tbl.h:94
proc destroyTblDat*(obj: ptr TblDat): void {.importc: r"#.~tbl_dat()",
    header: allHeaders.}
  ## @import{[[code:struct!tbl_dat]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `tbl_dat`
# Declared in tbl.h:94
proc newTblDat*(): ref TblDat =
  ## @import{[[code:struct!tbl_dat]]}
  newImportAux()
  new(result, proc (destr: ref TblDat) =
    destroyTblDat(addr destr[]))
  {.emit: "new ((void*)result) tbl_dat(); /* Placement new */".}



const
  arrTblSpantmapping: array[TblSpant, tuple[name: string, cEnum: TblSpantC,
      cName: string, value: cint]] = [
    (name: "TBL_SPAN_DATA", cEnum: tblSpant_TBL_SPAN_DATA,
     cName: "tbl_spant::TBL_SPAN_DATA", value: cint(0)),
    (name: "TBL_SPAN_HORIZ", cEnum: tblSpant_TBL_SPAN_HORIZ,
     cName: "tbl_spant::TBL_SPAN_HORIZ", value: cint(1)),
    (name: "TBL_SPAN_DHORIZ", cEnum: tblSpant_TBL_SPAN_DHORIZ,
     cName: "tbl_spant::TBL_SPAN_DHORIZ", value: cint(2))]
proc toCInt*(en: TblSpant): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrTblSpantmapping[en].value

proc toCInt*(en: set[TblSpant]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrTblSpantmapping[val].value)

proc `$`*(en: TblSpantC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of tblSpant_TBL_SPAN_DATA:
    result = "tbl_spant::TBL_SPAN_DATA"
  of tblSpant_TBL_SPAN_HORIZ:
    result = "tbl_spant::TBL_SPAN_HORIZ"
  of tblSpant_TBL_SPAN_DHORIZ:
    result = "tbl_spant::TBL_SPAN_DHORIZ"
  
func toTblSpant*(en: TblSpantC): TblSpant {.inline.} =
  case en
  of tblSpant_TBL_SPAN_DATA:
    tsData
  of tblSpant_TBL_SPAN_HORIZ:
    tsHoriz
  of tblSpant_TBL_SPAN_DHORIZ:
    tsDhoriz
  
converter toTblSpantC*(en: TblSpant): TblSpantC {.inline.} =
  arrTblSpantmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `tbl_span`
# Declared in tbl.h:113
proc cnewTblSpan*(): ptr TblSpan {.importc: r"new tbl_span()",
                                   header: allHeaders.}
  ## @import{[[code:struct!tbl_span]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `tbl_span`
# Declared in tbl.h:113
proc destroyTblSpan*(obj: ptr TblSpan): void {.importc: r"#.~tbl_span()",
    header: allHeaders.}
  ## @import{[[code:struct!tbl_span]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `tbl_span`
# Declared in tbl.h:113
proc newTblSpan*(): ref TblSpan =
  ## @import{[[code:struct!tbl_span]]}
  newImportAux()
  new(result, proc (destr: ref TblSpan) =
    destroyTblSpan(addr destr[]))
  {.emit: "new ((void*)result) tbl_span(); /* Placement new */".}



const
  arrRoffMacrosetmapping: array[RoffMacroset, tuple[name: string,
      cEnum: RoffMacrosetC, cName: string, value: cint]] = [
    (name: "MACROSET_NONE", cEnum: roffMacroset_MACROSET_NONE,
     cName: "roff_macroset::MACROSET_NONE", value: cint(0)),
    (name: "MACROSET_MDOC", cEnum: roffMacroset_MACROSET_MDOC,
     cName: "roff_macroset::MACROSET_MDOC", value: cint(1)),
    (name: "MACROSET_MAN", cEnum: roffMacroset_MACROSET_MAN,
     cName: "roff_macroset::MACROSET_MAN", value: cint(2))]
proc toCInt*(en: RoffMacroset): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrRoffMacrosetmapping[en].value

proc toCInt*(en: set[RoffMacroset]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrRoffMacrosetmapping[val].value)

proc `$`*(en: RoffMacrosetC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of roffMacroset_MACROSET_NONE:
    result = "roff_macroset::MACROSET_NONE"
  of roffMacroset_MACROSET_MDOC:
    result = "roff_macroset::MACROSET_MDOC"
  of roffMacroset_MACROSET_MAN:
    result = "roff_macroset::MACROSET_MAN"
  
func toRoffMacroset*(en: RoffMacrosetC): RoffMacroset {.inline.} =
  case en
  of roffMacroset_MACROSET_NONE:
    rmNone
  of roffMacroset_MACROSET_MDOC:
    rmMdoc
  of roffMacroset_MACROSET_MAN:
    rmMan
  
converter toRoffMacrosetC*(en: RoffMacroset): RoffMacrosetC {.inline.} =
  arrRoffMacrosetmapping[en].cEnum




const
  arrRoffSecmapping: array[RoffSec, tuple[name: string, cEnum: RoffSecC,
      cName: string, value: cint]] = [
    (name: "SEC_NONE", cEnum: roffSec_SEC_NONE, cName: "roff_sec::SEC_NONE",
     value: cint(0)),
    (name: "SEC_NAME", cEnum: roffSec_SEC_NAME, cName: "roff_sec::SEC_NAME",
     value: cint(1)),
    (name: "SEC_LIBRARY", cEnum: roffSec_SEC_LIBRARY,
     cName: "roff_sec::SEC_LIBRARY", value: cint(2)),
    (name: "SEC_SYNOPSIS", cEnum: roffSec_SEC_SYNOPSIS,
     cName: "roff_sec::SEC_SYNOPSIS", value: cint(3)),
    (name: "SEC_DESCRIPTION", cEnum: roffSec_SEC_DESCRIPTION,
     cName: "roff_sec::SEC_DESCRIPTION", value: cint(4)),
    (name: "SEC_CONTEXT", cEnum: roffSec_SEC_CONTEXT,
     cName: "roff_sec::SEC_CONTEXT", value: cint(5)),
    (name: "SEC_IMPLEMENTATION", cEnum: roffSec_SEC_IMPLEMENTATION,
     cName: "roff_sec::SEC_IMPLEMENTATION", value: cint(6)),
    (name: "SEC_RETURN_VALUES", cEnum: roffSec_SEC_RETURN_VALUES,
     cName: "roff_sec::SEC_RETURN_VALUES", value: cint(7)),
    (name: "SEC_ENVIRONMENT", cEnum: roffSec_SEC_ENVIRONMENT,
     cName: "roff_sec::SEC_ENVIRONMENT", value: cint(8)),
    (name: "SEC_FILES", cEnum: roffSec_SEC_FILES, cName: "roff_sec::SEC_FILES",
     value: cint(9)),
    (name: "SEC_EXIT_STATUS", cEnum: roffSec_SEC_EXIT_STATUS,
     cName: "roff_sec::SEC_EXIT_STATUS", value: cint(10)),
    (name: "SEC_EXAMPLES", cEnum: roffSec_SEC_EXAMPLES,
     cName: "roff_sec::SEC_EXAMPLES", value: cint(11)),
    (name: "SEC_DIAGNOSTICS", cEnum: roffSec_SEC_DIAGNOSTICS,
     cName: "roff_sec::SEC_DIAGNOSTICS", value: cint(12)),
    (name: "SEC_COMPATIBILITY", cEnum: roffSec_SEC_COMPATIBILITY,
     cName: "roff_sec::SEC_COMPATIBILITY", value: cint(13)),
    (name: "SEC_ERRORS", cEnum: roffSec_SEC_ERRORS,
     cName: "roff_sec::SEC_ERRORS", value: cint(14)),
    (name: "SEC_SEE_ALSO", cEnum: roffSec_SEC_SEE_ALSO,
     cName: "roff_sec::SEC_SEE_ALSO", value: cint(15)),
    (name: "SEC_STANDARDS", cEnum: roffSec_SEC_STANDARDS,
     cName: "roff_sec::SEC_STANDARDS", value: cint(16)),
    (name: "SEC_HISTORY", cEnum: roffSec_SEC_HISTORY,
     cName: "roff_sec::SEC_HISTORY", value: cint(17)),
    (name: "SEC_AUTHORS", cEnum: roffSec_SEC_AUTHORS,
     cName: "roff_sec::SEC_AUTHORS", value: cint(18)),
    (name: "SEC_CAVEATS", cEnum: roffSec_SEC_CAVEATS,
     cName: "roff_sec::SEC_CAVEATS", value: cint(19)),
    (name: "SEC_BUGS", cEnum: roffSec_SEC_BUGS, cName: "roff_sec::SEC_BUGS",
     value: cint(20)),
    (name: "SEC_SECURITY", cEnum: roffSec_SEC_SECURITY,
     cName: "roff_sec::SEC_SECURITY", value: cint(21)),
    (name: "SEC_CUSTOM", cEnum: roffSec_SEC_CUSTOM,
     cName: "roff_sec::SEC_CUSTOM", value: cint(22)),
    (name: "SEC__MAX", cEnum: roffSec_SEC_MAX, cName: "roff_sec::SEC__MAX",
     value: cint(23))]
proc toCInt*(en: RoffSec): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrRoffSecmapping[en].value

proc toCInt*(en: set[RoffSec]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrRoffSecmapping[val].value)

proc `$`*(en: RoffSecC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of roffSec_SEC_NONE:
    result = "roff_sec::SEC_NONE"
  of roffSec_SEC_NAME:
    result = "roff_sec::SEC_NAME"
  of roffSec_SEC_LIBRARY:
    result = "roff_sec::SEC_LIBRARY"
  of roffSec_SEC_SYNOPSIS:
    result = "roff_sec::SEC_SYNOPSIS"
  of roffSec_SEC_DESCRIPTION:
    result = "roff_sec::SEC_DESCRIPTION"
  of roffSec_SEC_CONTEXT:
    result = "roff_sec::SEC_CONTEXT"
  of roffSec_SEC_IMPLEMENTATION:
    result = "roff_sec::SEC_IMPLEMENTATION"
  of roffSec_SEC_RETURN_VALUES:
    result = "roff_sec::SEC_RETURN_VALUES"
  of roffSec_SEC_ENVIRONMENT:
    result = "roff_sec::SEC_ENVIRONMENT"
  of roffSec_SEC_FILES:
    result = "roff_sec::SEC_FILES"
  of roffSec_SEC_EXIT_STATUS:
    result = "roff_sec::SEC_EXIT_STATUS"
  of roffSec_SEC_EXAMPLES:
    result = "roff_sec::SEC_EXAMPLES"
  of roffSec_SEC_DIAGNOSTICS:
    result = "roff_sec::SEC_DIAGNOSTICS"
  of roffSec_SEC_COMPATIBILITY:
    result = "roff_sec::SEC_COMPATIBILITY"
  of roffSec_SEC_ERRORS:
    result = "roff_sec::SEC_ERRORS"
  of roffSec_SEC_SEE_ALSO:
    result = "roff_sec::SEC_SEE_ALSO"
  of roffSec_SEC_STANDARDS:
    result = "roff_sec::SEC_STANDARDS"
  of roffSec_SEC_HISTORY:
    result = "roff_sec::SEC_HISTORY"
  of roffSec_SEC_AUTHORS:
    result = "roff_sec::SEC_AUTHORS"
  of roffSec_SEC_CAVEATS:
    result = "roff_sec::SEC_CAVEATS"
  of roffSec_SEC_BUGS:
    result = "roff_sec::SEC_BUGS"
  of roffSec_SEC_SECURITY:
    result = "roff_sec::SEC_SECURITY"
  of roffSec_SEC_CUSTOM:
    result = "roff_sec::SEC_CUSTOM"
  of roffSec_SEC_MAX:
    result = "roff_sec::SEC__MAX"
  
func toRoffSec*(en: RoffSecC): RoffSec {.inline.} =
  case en
  of roffSec_SEC_NONE:
    rsNone
  of roffSec_SEC_NAME:
    rsName
  of roffSec_SEC_LIBRARY:
    rsLibrary
  of roffSec_SEC_SYNOPSIS:
    rsSynopsis
  of roffSec_SEC_DESCRIPTION:
    rsDescription
  of roffSec_SEC_CONTEXT:
    rsContext
  of roffSec_SEC_IMPLEMENTATION:
    rsImplementation
  of roffSec_SEC_RETURN_VALUES:
    rsReturnValues
  of roffSec_SEC_ENVIRONMENT:
    rsEnvironment
  of roffSec_SEC_FILES:
    rsFiles
  of roffSec_SEC_EXIT_STATUS:
    rsExitStatus
  of roffSec_SEC_EXAMPLES:
    rsExamples
  of roffSec_SEC_DIAGNOSTICS:
    rsDiagnostics
  of roffSec_SEC_COMPATIBILITY:
    rsCompatibility
  of roffSec_SEC_ERRORS:
    rsErrors
  of roffSec_SEC_SEE_ALSO:
    rsSeeAlso
  of roffSec_SEC_STANDARDS:
    rsStandards
  of roffSec_SEC_HISTORY:
    rsHistory
  of roffSec_SEC_AUTHORS:
    rsAuthors
  of roffSec_SEC_CAVEATS:
    rsCaveats
  of roffSec_SEC_BUGS:
    rsBugs
  of roffSec_SEC_SECURITY:
    rsSecurity
  of roffSec_SEC_CUSTOM:
    rsCustom
  of roffSec_SEC_MAX:
    rsMax
  
converter toRoffSecC*(en: RoffSec): RoffSecC {.inline.} =
  arrRoffSecmapping[en].cEnum




const
  arrRoffTypemapping: array[RoffType, tuple[name: string, cEnum: RoffTypeC,
      cName: string, value: cint]] = [
    (name: "ROFFT_ROOT", cEnum: roffType_ROFFT_ROOT,
     cName: "roff_type::ROFFT_ROOT", value: cint(0)),
    (name: "ROFFT_BLOCK", cEnum: roffType_ROFFT_BLOCK,
     cName: "roff_type::ROFFT_BLOCK", value: cint(1)),
    (name: "ROFFT_HEAD", cEnum: roffType_ROFFT_HEAD,
     cName: "roff_type::ROFFT_HEAD", value: cint(2)),
    (name: "ROFFT_BODY", cEnum: roffType_ROFFT_BODY,
     cName: "roff_type::ROFFT_BODY", value: cint(3)),
    (name: "ROFFT_TAIL", cEnum: roffType_ROFFT_TAIL,
     cName: "roff_type::ROFFT_TAIL", value: cint(4)),
    (name: "ROFFT_ELEM", cEnum: roffType_ROFFT_ELEM,
     cName: "roff_type::ROFFT_ELEM", value: cint(5)),
    (name: "ROFFT_TEXT", cEnum: roffType_ROFFT_TEXT,
     cName: "roff_type::ROFFT_TEXT", value: cint(6)),
    (name: "ROFFT_COMMENT", cEnum: roffType_ROFFT_COMMENT,
     cName: "roff_type::ROFFT_COMMENT", value: cint(7)),
    (name: "ROFFT_TBL", cEnum: roffType_ROFFT_TBL,
     cName: "roff_type::ROFFT_TBL", value: cint(8)),
    (name: "ROFFT_EQN", cEnum: roffType_ROFFT_EQN,
     cName: "roff_type::ROFFT_EQN", value: cint(9))]
proc toCInt*(en: RoffType): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrRoffTypemapping[en].value

proc toCInt*(en: set[RoffType]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrRoffTypemapping[val].value)

proc `$`*(en: RoffTypeC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of roffType_ROFFT_ROOT:
    result = "roff_type::ROFFT_ROOT"
  of roffType_ROFFT_BLOCK:
    result = "roff_type::ROFFT_BLOCK"
  of roffType_ROFFT_HEAD:
    result = "roff_type::ROFFT_HEAD"
  of roffType_ROFFT_BODY:
    result = "roff_type::ROFFT_BODY"
  of roffType_ROFFT_TAIL:
    result = "roff_type::ROFFT_TAIL"
  of roffType_ROFFT_ELEM:
    result = "roff_type::ROFFT_ELEM"
  of roffType_ROFFT_TEXT:
    result = "roff_type::ROFFT_TEXT"
  of roffType_ROFFT_COMMENT:
    result = "roff_type::ROFFT_COMMENT"
  of roffType_ROFFT_TBL:
    result = "roff_type::ROFFT_TBL"
  of roffType_ROFFT_EQN:
    result = "roff_type::ROFFT_EQN"
  
func toRoffType*(en: RoffTypeC): RoffType {.inline.} =
  case en
  of roffType_ROFFT_ROOT:
    rtRoot
  of roffType_ROFFT_BLOCK:
    rtBlock
  of roffType_ROFFT_HEAD:
    rtHead
  of roffType_ROFFT_BODY:
    rtBody
  of roffType_ROFFT_TAIL:
    rtTail
  of roffType_ROFFT_ELEM:
    rtElem
  of roffType_ROFFT_TEXT:
    rtText
  of roffType_ROFFT_COMMENT:
    rtComment
  of roffType_ROFFT_TBL:
    rtTbl
  of roffType_ROFFT_EQN:
    rtEqn
  
converter toRoffTypeC*(en: RoffType): RoffTypeC {.inline.} =
  arrRoffTypemapping[en].cEnum




const
  arrRoffTokmapping: array[RoffTok, tuple[name: string, cEnum: RoffTokC,
      cName: string, value: cint]] = [
    (name: "ROFF_br", cEnum: roffTok_ROFF_br, cName: "roff_tok::ROFF_br",
     value: cint(0)),
    (name: "ROFF_ce", cEnum: roffTok_ROFF_ce, cName: "roff_tok::ROFF_ce",
     value: cint(1)),
    (name: "ROFF_fi", cEnum: roffTok_ROFF_fi, cName: "roff_tok::ROFF_fi",
     value: cint(2)),
    (name: "ROFF_ft", cEnum: roffTok_ROFF_ft, cName: "roff_tok::ROFF_ft",
     value: cint(3)),
    (name: "ROFF_ll", cEnum: roffTok_ROFF_ll, cName: "roff_tok::ROFF_ll",
     value: cint(4)),
    (name: "ROFF_mc", cEnum: roffTok_ROFF_mc, cName: "roff_tok::ROFF_mc",
     value: cint(5)),
    (name: "ROFF_nf", cEnum: roffTok_ROFF_nf, cName: "roff_tok::ROFF_nf",
     value: cint(6)),
    (name: "ROFF_po", cEnum: roffTok_ROFF_po, cName: "roff_tok::ROFF_po",
     value: cint(7)),
    (name: "ROFF_rj", cEnum: roffTok_ROFF_rj, cName: "roff_tok::ROFF_rj",
     value: cint(8)),
    (name: "ROFF_sp", cEnum: roffTok_ROFF_sp, cName: "roff_tok::ROFF_sp",
     value: cint(9)),
    (name: "ROFF_ta", cEnum: roffTok_ROFF_ta, cName: "roff_tok::ROFF_ta",
     value: cint(10)),
    (name: "ROFF_ti", cEnum: roffTok_ROFF_ti, cName: "roff_tok::ROFF_ti",
     value: cint(11)),
    (name: "ROFF_MAX", cEnum: roffTok_ROFF_MAX, cName: "roff_tok::ROFF_MAX",
     value: cint(12)),
    (name: "ROFF_ab", cEnum: roffTok_ROFF_ab, cName: "roff_tok::ROFF_ab",
     value: cint(13)),
    (name: "ROFF_ad", cEnum: roffTok_ROFF_ad, cName: "roff_tok::ROFF_ad",
     value: cint(14)),
    (name: "ROFF_af", cEnum: roffTok_ROFF_af, cName: "roff_tok::ROFF_af",
     value: cint(15)),
    (name: "ROFF_aln", cEnum: roffTok_ROFF_aln, cName: "roff_tok::ROFF_aln",
     value: cint(16)),
    (name: "ROFF_als", cEnum: roffTok_ROFF_als, cName: "roff_tok::ROFF_als",
     value: cint(17)),
    (name: "ROFF_am", cEnum: roffTok_ROFF_am, cName: "roff_tok::ROFF_am",
     value: cint(18)),
    (name: "ROFF_am1", cEnum: roffTok_ROFF_am1, cName: "roff_tok::ROFF_am1",
     value: cint(19)),
    (name: "ROFF_ami", cEnum: roffTok_ROFF_ami, cName: "roff_tok::ROFF_ami",
     value: cint(20)),
    (name: "ROFF_ami1", cEnum: roffTok_ROFF_ami1, cName: "roff_tok::ROFF_ami1",
     value: cint(21)),
    (name: "ROFF_as", cEnum: roffTok_ROFF_as, cName: "roff_tok::ROFF_as",
     value: cint(22)),
    (name: "ROFF_as1", cEnum: roffTok_ROFF_as1, cName: "roff_tok::ROFF_as1",
     value: cint(23)),
    (name: "ROFF_asciify", cEnum: roffTok_ROFF_asciify,
     cName: "roff_tok::ROFF_asciify", value: cint(24)),
    (name: "ROFF_backtrace", cEnum: roffTok_ROFF_backtrace,
     cName: "roff_tok::ROFF_backtrace", value: cint(25)),
    (name: "ROFF_bd", cEnum: roffTok_ROFF_bd, cName: "roff_tok::ROFF_bd",
     value: cint(26)),
    (name: "ROFF_bleedat", cEnum: roffTok_ROFF_bleedat,
     cName: "roff_tok::ROFF_bleedat", value: cint(27)),
    (name: "ROFF_blm", cEnum: roffTok_ROFF_blm, cName: "roff_tok::ROFF_blm",
     value: cint(28)),
    (name: "ROFF_box", cEnum: roffTok_ROFF_box, cName: "roff_tok::ROFF_box",
     value: cint(29)),
    (name: "ROFF_boxa", cEnum: roffTok_ROFF_boxa, cName: "roff_tok::ROFF_boxa",
     value: cint(30)),
    (name: "ROFF_bp", cEnum: roffTok_ROFF_bp, cName: "roff_tok::ROFF_bp",
     value: cint(31)),
    (name: "ROFF_BP", cEnum: roffTok_ROFF_BP1, cName: "roff_tok::ROFF_BP",
     value: cint(32)),
    (name: "ROFF_break", cEnum: roffTok_ROFF_break,
     cName: "roff_tok::ROFF_break", value: cint(33)),
    (name: "ROFF_breakchar", cEnum: roffTok_ROFF_breakchar,
     cName: "roff_tok::ROFF_breakchar", value: cint(34)),
    (name: "ROFF_brnl", cEnum: roffTok_ROFF_brnl, cName: "roff_tok::ROFF_brnl",
     value: cint(35)),
    (name: "ROFF_brp", cEnum: roffTok_ROFF_brp, cName: "roff_tok::ROFF_brp",
     value: cint(36)),
    (name: "ROFF_brpnl", cEnum: roffTok_ROFF_brpnl,
     cName: "roff_tok::ROFF_brpnl", value: cint(37)),
    (name: "ROFF_c2", cEnum: roffTok_ROFF_c2, cName: "roff_tok::ROFF_c2",
     value: cint(38)),
    (name: "ROFF_cc", cEnum: roffTok_ROFF_cc, cName: "roff_tok::ROFF_cc",
     value: cint(39)),
    (name: "ROFF_cf", cEnum: roffTok_ROFF_cf, cName: "roff_tok::ROFF_cf",
     value: cint(40)),
    (name: "ROFF_cflags", cEnum: roffTok_ROFF_cflags,
     cName: "roff_tok::ROFF_cflags", value: cint(41)),
    (name: "ROFF_ch", cEnum: roffTok_ROFF_ch, cName: "roff_tok::ROFF_ch",
     value: cint(42)),
    (name: "ROFF_char", cEnum: roffTok_ROFF_char, cName: "roff_tok::ROFF_char",
     value: cint(43)),
    (name: "ROFF_chop", cEnum: roffTok_ROFF_chop, cName: "roff_tok::ROFF_chop",
     value: cint(44)),
    (name: "ROFF_class", cEnum: roffTok_ROFF_class,
     cName: "roff_tok::ROFF_class", value: cint(45)),
    (name: "ROFF_close", cEnum: roffTok_ROFF_close,
     cName: "roff_tok::ROFF_close", value: cint(46)),
    (name: "ROFF_CL", cEnum: roffTok_ROFF_CL, cName: "roff_tok::ROFF_CL",
     value: cint(47)),
    (name: "ROFF_color", cEnum: roffTok_ROFF_color,
     cName: "roff_tok::ROFF_color", value: cint(48)),
    (name: "ROFF_composite", cEnum: roffTok_ROFF_composite,
     cName: "roff_tok::ROFF_composite", value: cint(49)),
    (name: "ROFF_continue", cEnum: roffTok_ROFF_continue,
     cName: "roff_tok::ROFF_continue", value: cint(50)),
    (name: "ROFF_cp", cEnum: roffTok_ROFF_cp, cName: "roff_tok::ROFF_cp",
     value: cint(51)),
    (name: "ROFF_cropat", cEnum: roffTok_ROFF_cropat,
     cName: "roff_tok::ROFF_cropat", value: cint(52)),
    (name: "ROFF_cs", cEnum: roffTok_ROFF_cs, cName: "roff_tok::ROFF_cs",
     value: cint(53)),
    (name: "ROFF_cu", cEnum: roffTok_ROFF_cu, cName: "roff_tok::ROFF_cu",
     value: cint(54)),
    (name: "ROFF_da", cEnum: roffTok_ROFF_da, cName: "roff_tok::ROFF_da",
     value: cint(55)),
    (name: "ROFF_dch", cEnum: roffTok_ROFF_dch, cName: "roff_tok::ROFF_dch",
     value: cint(56)),
    (name: "ROFF_Dd", cEnum: roffTok_ROFF_Dd, cName: "roff_tok::ROFF_Dd",
     value: cint(57)),
    (name: "ROFF_de", cEnum: roffTok_ROFF_de, cName: "roff_tok::ROFF_de",
     value: cint(58)),
    (name: "ROFF_de1", cEnum: roffTok_ROFF_de1, cName: "roff_tok::ROFF_de1",
     value: cint(59)),
    (name: "ROFF_defcolor", cEnum: roffTok_ROFF_defcolor,
     cName: "roff_tok::ROFF_defcolor", value: cint(60)),
    (name: "ROFF_dei", cEnum: roffTok_ROFF_dei, cName: "roff_tok::ROFF_dei",
     value: cint(61)),
    (name: "ROFF_dei1", cEnum: roffTok_ROFF_dei1, cName: "roff_tok::ROFF_dei1",
     value: cint(62)),
    (name: "ROFF_device", cEnum: roffTok_ROFF_device,
     cName: "roff_tok::ROFF_device", value: cint(63)),
    (name: "ROFF_devicem", cEnum: roffTok_ROFF_devicem,
     cName: "roff_tok::ROFF_devicem", value: cint(64)),
    (name: "ROFF_di", cEnum: roffTok_ROFF_di, cName: "roff_tok::ROFF_di",
     value: cint(65)),
    (name: "ROFF_do", cEnum: roffTok_ROFF_do, cName: "roff_tok::ROFF_do",
     value: cint(66)),
    (name: "ROFF_ds", cEnum: roffTok_ROFF_ds, cName: "roff_tok::ROFF_ds",
     value: cint(67)),
    (name: "ROFF_ds1", cEnum: roffTok_ROFF_ds1, cName: "roff_tok::ROFF_ds1",
     value: cint(68)),
    (name: "ROFF_dwh", cEnum: roffTok_ROFF_dwh, cName: "roff_tok::ROFF_dwh",
     value: cint(69)),
    (name: "ROFF_dt", cEnum: roffTok_ROFF_dt, cName: "roff_tok::ROFF_dt",
     value: cint(70)),
    (name: "ROFF_ec", cEnum: roffTok_ROFF_ec, cName: "roff_tok::ROFF_ec",
     value: cint(71)),
    (name: "ROFF_ecr", cEnum: roffTok_ROFF_ecr, cName: "roff_tok::ROFF_ecr",
     value: cint(72)),
    (name: "ROFF_ecs", cEnum: roffTok_ROFF_ecs, cName: "roff_tok::ROFF_ecs",
     value: cint(73)),
    (name: "ROFF_el", cEnum: roffTok_ROFF_el, cName: "roff_tok::ROFF_el",
     value: cint(74)),
    (name: "ROFF_em", cEnum: roffTok_ROFF_em, cName: "roff_tok::ROFF_em",
     value: cint(75)),
    (name: "ROFF_EN", cEnum: roffTok_ROFF_EN, cName: "roff_tok::ROFF_EN",
     value: cint(76)),
    (name: "ROFF_eo", cEnum: roffTok_ROFF_eo, cName: "roff_tok::ROFF_eo",
     value: cint(77)),
    (name: "ROFF_EP", cEnum: roffTok_ROFF_EP, cName: "roff_tok::ROFF_EP",
     value: cint(78)),
    (name: "ROFF_EQ", cEnum: roffTok_ROFF_EQ, cName: "roff_tok::ROFF_EQ",
     value: cint(79)),
    (name: "ROFF_errprint", cEnum: roffTok_ROFF_errprint,
     cName: "roff_tok::ROFF_errprint", value: cint(80)),
    (name: "ROFF_ev", cEnum: roffTok_ROFF_ev, cName: "roff_tok::ROFF_ev",
     value: cint(81)),
    (name: "ROFF_evc", cEnum: roffTok_ROFF_evc, cName: "roff_tok::ROFF_evc",
     value: cint(82)),
    (name: "ROFF_ex", cEnum: roffTok_ROFF_ex, cName: "roff_tok::ROFF_ex",
     value: cint(83)),
    (name: "ROFF_fallback", cEnum: roffTok_ROFF_fallback,
     cName: "roff_tok::ROFF_fallback", value: cint(84)),
    (name: "ROFF_fam", cEnum: roffTok_ROFF_fam, cName: "roff_tok::ROFF_fam",
     value: cint(85)),
    (name: "ROFF_fc", cEnum: roffTok_ROFF_fc, cName: "roff_tok::ROFF_fc",
     value: cint(86)),
    (name: "ROFF_fchar", cEnum: roffTok_ROFF_fchar,
     cName: "roff_tok::ROFF_fchar", value: cint(87)),
    (name: "ROFF_fcolor", cEnum: roffTok_ROFF_fcolor,
     cName: "roff_tok::ROFF_fcolor", value: cint(88)),
    (name: "ROFF_fdeferlig", cEnum: roffTok_ROFF_fdeferlig,
     cName: "roff_tok::ROFF_fdeferlig", value: cint(89)),
    (name: "ROFF_feature", cEnum: roffTok_ROFF_feature,
     cName: "roff_tok::ROFF_feature", value: cint(90)),
    (name: "ROFF_fkern", cEnum: roffTok_ROFF_fkern,
     cName: "roff_tok::ROFF_fkern", value: cint(91)),
    (name: "ROFF_fl", cEnum: roffTok_ROFF_fl, cName: "roff_tok::ROFF_fl",
     value: cint(92)),
    (name: "ROFF_flig", cEnum: roffTok_ROFF_flig, cName: "roff_tok::ROFF_flig",
     value: cint(93)),
    (name: "ROFF_fp", cEnum: roffTok_ROFF_fp, cName: "roff_tok::ROFF_fp",
     value: cint(94)),
    (name: "ROFF_fps", cEnum: roffTok_ROFF_fps, cName: "roff_tok::ROFF_fps",
     value: cint(95)),
    (name: "ROFF_fschar", cEnum: roffTok_ROFF_fschar,
     cName: "roff_tok::ROFF_fschar", value: cint(96)),
    (name: "ROFF_fspacewidth", cEnum: roffTok_ROFF_fspacewidth,
     cName: "roff_tok::ROFF_fspacewidth", value: cint(97)),
    (name: "ROFF_fspecial", cEnum: roffTok_ROFF_fspecial,
     cName: "roff_tok::ROFF_fspecial", value: cint(98)),
    (name: "ROFF_ftr", cEnum: roffTok_ROFF_ftr, cName: "roff_tok::ROFF_ftr",
     value: cint(99)),
    (name: "ROFF_fzoom", cEnum: roffTok_ROFF_fzoom,
     cName: "roff_tok::ROFF_fzoom", value: cint(100)),
    (name: "ROFF_gcolor", cEnum: roffTok_ROFF_gcolor,
     cName: "roff_tok::ROFF_gcolor", value: cint(101)),
    (name: "ROFF_hc", cEnum: roffTok_ROFF_hc, cName: "roff_tok::ROFF_hc",
     value: cint(102)),
    (name: "ROFF_hcode", cEnum: roffTok_ROFF_hcode,
     cName: "roff_tok::ROFF_hcode", value: cint(103)),
    (name: "ROFF_hidechar", cEnum: roffTok_ROFF_hidechar,
     cName: "roff_tok::ROFF_hidechar", value: cint(104)),
    (name: "ROFF_hla", cEnum: roffTok_ROFF_hla, cName: "roff_tok::ROFF_hla",
     value: cint(105)),
    (name: "ROFF_hlm", cEnum: roffTok_ROFF_hlm, cName: "roff_tok::ROFF_hlm",
     value: cint(106)),
    (name: "ROFF_hpf", cEnum: roffTok_ROFF_hpf, cName: "roff_tok::ROFF_hpf",
     value: cint(107)),
    (name: "ROFF_hpfa", cEnum: roffTok_ROFF_hpfa, cName: "roff_tok::ROFF_hpfa",
     value: cint(108)),
    (name: "ROFF_hpfcode", cEnum: roffTok_ROFF_hpfcode,
     cName: "roff_tok::ROFF_hpfcode", value: cint(109)),
    (name: "ROFF_hw", cEnum: roffTok_ROFF_hw, cName: "roff_tok::ROFF_hw",
     value: cint(110)),
    (name: "ROFF_hy", cEnum: roffTok_ROFF_hy, cName: "roff_tok::ROFF_hy",
     value: cint(111)),
    (name: "ROFF_hylang", cEnum: roffTok_ROFF_hylang,
     cName: "roff_tok::ROFF_hylang", value: cint(112)),
    (name: "ROFF_hylen", cEnum: roffTok_ROFF_hylen,
     cName: "roff_tok::ROFF_hylen", value: cint(113)),
    (name: "ROFF_hym", cEnum: roffTok_ROFF_hym, cName: "roff_tok::ROFF_hym",
     value: cint(114)),
    (name: "ROFF_hypp", cEnum: roffTok_ROFF_hypp, cName: "roff_tok::ROFF_hypp",
     value: cint(115)),
    (name: "ROFF_hys", cEnum: roffTok_ROFF_hys, cName: "roff_tok::ROFF_hys",
     value: cint(116)),
    (name: "ROFF_ie", cEnum: roffTok_ROFF_ie, cName: "roff_tok::ROFF_ie",
     value: cint(117)),
    (name: "ROFF_if", cEnum: roffTok_ROFF_if, cName: "roff_tok::ROFF_if",
     value: cint(118)),
    (name: "ROFF_ig", cEnum: roffTok_ROFF_ig, cName: "roff_tok::ROFF_ig",
     value: cint(119)),
    (name: "ROFF_index", cEnum: roffTok_ROFF_index,
     cName: "roff_tok::ROFF_index", value: cint(120)),
    (name: "ROFF_it", cEnum: roffTok_ROFF_it, cName: "roff_tok::ROFF_it",
     value: cint(121)),
    (name: "ROFF_itc", cEnum: roffTok_ROFF_itc, cName: "roff_tok::ROFF_itc",
     value: cint(122)),
    (name: "ROFF_IX", cEnum: roffTok_ROFF_IX, cName: "roff_tok::ROFF_IX",
     value: cint(123)),
    (name: "ROFF_kern", cEnum: roffTok_ROFF_kern, cName: "roff_tok::ROFF_kern",
     value: cint(124)),
    (name: "ROFF_kernafter", cEnum: roffTok_ROFF_kernafter,
     cName: "roff_tok::ROFF_kernafter", value: cint(125)),
    (name: "ROFF_kernbefore", cEnum: roffTok_ROFF_kernbefore,
     cName: "roff_tok::ROFF_kernbefore", value: cint(126)),
    (name: "ROFF_kernpair", cEnum: roffTok_ROFF_kernpair,
     cName: "roff_tok::ROFF_kernpair", value: cint(127)),
    (name: "ROFF_lc", cEnum: roffTok_ROFF_lc, cName: "roff_tok::ROFF_lc",
     value: cint(128)),
    (name: "ROFF_lc_ctype", cEnum: roffTok_ROFF_lc_ctype,
     cName: "roff_tok::ROFF_lc_ctype", value: cint(129)),
    (name: "ROFF_lds", cEnum: roffTok_ROFF_lds, cName: "roff_tok::ROFF_lds",
     value: cint(130)),
    (name: "ROFF_length", cEnum: roffTok_ROFF_length,
     cName: "roff_tok::ROFF_length", value: cint(131)),
    (name: "ROFF_letadj", cEnum: roffTok_ROFF_letadj,
     cName: "roff_tok::ROFF_letadj", value: cint(132)),
    (name: "ROFF_lf", cEnum: roffTok_ROFF_lf, cName: "roff_tok::ROFF_lf",
     value: cint(133)),
    (name: "ROFF_lg", cEnum: roffTok_ROFF_lg, cName: "roff_tok::ROFF_lg",
     value: cint(134)),
    (name: "ROFF_lhang", cEnum: roffTok_ROFF_lhang,
     cName: "roff_tok::ROFF_lhang", value: cint(135)),
    (name: "ROFF_linetabs", cEnum: roffTok_ROFF_linetabs,
     cName: "roff_tok::ROFF_linetabs", value: cint(136)),
    (name: "ROFF_lnr", cEnum: roffTok_ROFF_lnr, cName: "roff_tok::ROFF_lnr",
     value: cint(137)),
    (name: "ROFF_lnrf", cEnum: roffTok_ROFF_lnrf, cName: "roff_tok::ROFF_lnrf",
     value: cint(138)),
    (name: "ROFF_lpfx", cEnum: roffTok_ROFF_lpfx, cName: "roff_tok::ROFF_lpfx",
     value: cint(139)),
    (name: "ROFF_ls", cEnum: roffTok_ROFF_ls, cName: "roff_tok::ROFF_ls",
     value: cint(140)),
    (name: "ROFF_lsm", cEnum: roffTok_ROFF_lsm, cName: "roff_tok::ROFF_lsm",
     value: cint(141)),
    (name: "ROFF_lt", cEnum: roffTok_ROFF_lt, cName: "roff_tok::ROFF_lt",
     value: cint(142)),
    (name: "ROFF_mediasize", cEnum: roffTok_ROFF_mediasize,
     cName: "roff_tok::ROFF_mediasize", value: cint(143)),
    (name: "ROFF_minss", cEnum: roffTok_ROFF_minss,
     cName: "roff_tok::ROFF_minss", value: cint(144)),
    (name: "ROFF_mk", cEnum: roffTok_ROFF_mk, cName: "roff_tok::ROFF_mk",
     value: cint(145)),
    (name: "ROFF_mso", cEnum: roffTok_ROFF_mso, cName: "roff_tok::ROFF_mso",
     value: cint(146)),
    (name: "ROFF_na", cEnum: roffTok_ROFF_na, cName: "roff_tok::ROFF_na",
     value: cint(147)),
    (name: "ROFF_ne", cEnum: roffTok_ROFF_ne, cName: "roff_tok::ROFF_ne",
     value: cint(148)),
    (name: "ROFF_nh", cEnum: roffTok_ROFF_nh, cName: "roff_tok::ROFF_nh",
     value: cint(149)),
    (name: "ROFF_nhychar", cEnum: roffTok_ROFF_nhychar,
     cName: "roff_tok::ROFF_nhychar", value: cint(150)),
    (name: "ROFF_nm", cEnum: roffTok_ROFF_nm, cName: "roff_tok::ROFF_nm",
     value: cint(151)),
    (name: "ROFF_nn", cEnum: roffTok_ROFF_nn, cName: "roff_tok::ROFF_nn",
     value: cint(152)),
    (name: "ROFF_nop", cEnum: roffTok_ROFF_nop, cName: "roff_tok::ROFF_nop",
     value: cint(153)),
    (name: "ROFF_nr", cEnum: roffTok_ROFF_nr, cName: "roff_tok::ROFF_nr",
     value: cint(154)),
    (name: "ROFF_nrf", cEnum: roffTok_ROFF_nrf, cName: "roff_tok::ROFF_nrf",
     value: cint(155)),
    (name: "ROFF_nroff", cEnum: roffTok_ROFF_nroff,
     cName: "roff_tok::ROFF_nroff", value: cint(156)),
    (name: "ROFF_ns", cEnum: roffTok_ROFF_ns, cName: "roff_tok::ROFF_ns",
     value: cint(157)),
    (name: "ROFF_nx", cEnum: roffTok_ROFF_nx, cName: "roff_tok::ROFF_nx",
     value: cint(158)),
    (name: "ROFF_open", cEnum: roffTok_ROFF_open, cName: "roff_tok::ROFF_open",
     value: cint(159)),
    (name: "ROFF_opena", cEnum: roffTok_ROFF_opena,
     cName: "roff_tok::ROFF_opena", value: cint(160)),
    (name: "ROFF_os", cEnum: roffTok_ROFF_os, cName: "roff_tok::ROFF_os",
     value: cint(161)),
    (name: "ROFF_output", cEnum: roffTok_ROFF_output,
     cName: "roff_tok::ROFF_output", value: cint(162)),
    (name: "ROFF_padj", cEnum: roffTok_ROFF_padj, cName: "roff_tok::ROFF_padj",
     value: cint(163)),
    (name: "ROFF_papersize", cEnum: roffTok_ROFF_papersize,
     cName: "roff_tok::ROFF_papersize", value: cint(164)),
    (name: "ROFF_pc", cEnum: roffTok_ROFF_pc, cName: "roff_tok::ROFF_pc",
     value: cint(165)),
    (name: "ROFF_pev", cEnum: roffTok_ROFF_pev, cName: "roff_tok::ROFF_pev",
     value: cint(166)),
    (name: "ROFF_pi", cEnum: roffTok_ROFF_pi, cName: "roff_tok::ROFF_pi",
     value: cint(167)),
    (name: "ROFF_PI", cEnum: roffTok_ROFF_PI1, cName: "roff_tok::ROFF_PI",
     value: cint(168)),
    (name: "ROFF_pl", cEnum: roffTok_ROFF_pl, cName: "roff_tok::ROFF_pl",
     value: cint(169)),
    (name: "ROFF_pm", cEnum: roffTok_ROFF_pm, cName: "roff_tok::ROFF_pm",
     value: cint(170)),
    (name: "ROFF_pn", cEnum: roffTok_ROFF_pn, cName: "roff_tok::ROFF_pn",
     value: cint(171)),
    (name: "ROFF_pnr", cEnum: roffTok_ROFF_pnr, cName: "roff_tok::ROFF_pnr",
     value: cint(172)),
    (name: "ROFF_ps", cEnum: roffTok_ROFF_ps, cName: "roff_tok::ROFF_ps",
     value: cint(173)),
    (name: "ROFF_psbb", cEnum: roffTok_ROFF_psbb, cName: "roff_tok::ROFF_psbb",
     value: cint(174)),
    (name: "ROFF_pshape", cEnum: roffTok_ROFF_pshape,
     cName: "roff_tok::ROFF_pshape", value: cint(175)),
    (name: "ROFF_pso", cEnum: roffTok_ROFF_pso, cName: "roff_tok::ROFF_pso",
     value: cint(176)),
    (name: "ROFF_ptr", cEnum: roffTok_ROFF_ptr, cName: "roff_tok::ROFF_ptr",
     value: cint(177)),
    (name: "ROFF_pvs", cEnum: roffTok_ROFF_pvs, cName: "roff_tok::ROFF_pvs",
     value: cint(178)),
    (name: "ROFF_rchar", cEnum: roffTok_ROFF_rchar,
     cName: "roff_tok::ROFF_rchar", value: cint(179)),
    (name: "ROFF_rd", cEnum: roffTok_ROFF_rd, cName: "roff_tok::ROFF_rd",
     value: cint(180)),
    (name: "ROFF_recursionlimit", cEnum: roffTok_ROFF_recursionlimit,
     cName: "roff_tok::ROFF_recursionlimit", value: cint(181)),
    (name: "ROFF_return", cEnum: roffTok_ROFF_return,
     cName: "roff_tok::ROFF_return", value: cint(182)),
    (name: "ROFF_rfschar", cEnum: roffTok_ROFF_rfschar,
     cName: "roff_tok::ROFF_rfschar", value: cint(183)),
    (name: "ROFF_rhang", cEnum: roffTok_ROFF_rhang,
     cName: "roff_tok::ROFF_rhang", value: cint(184)),
    (name: "ROFF_rm", cEnum: roffTok_ROFF_rm, cName: "roff_tok::ROFF_rm",
     value: cint(185)),
    (name: "ROFF_rn", cEnum: roffTok_ROFF_rn, cName: "roff_tok::ROFF_rn",
     value: cint(186)),
    (name: "ROFF_rnn", cEnum: roffTok_ROFF_rnn, cName: "roff_tok::ROFF_rnn",
     value: cint(187)),
    (name: "ROFF_rr", cEnum: roffTok_ROFF_rr, cName: "roff_tok::ROFF_rr",
     value: cint(188)),
    (name: "ROFF_rs", cEnum: roffTok_ROFF_rs, cName: "roff_tok::ROFF_rs",
     value: cint(189)),
    (name: "ROFF_rt", cEnum: roffTok_ROFF_rt, cName: "roff_tok::ROFF_rt",
     value: cint(190)),
    (name: "ROFF_schar", cEnum: roffTok_ROFF_schar,
     cName: "roff_tok::ROFF_schar", value: cint(191)),
    (name: "ROFF_sentchar", cEnum: roffTok_ROFF_sentchar,
     cName: "roff_tok::ROFF_sentchar", value: cint(192)),
    (name: "ROFF_shc", cEnum: roffTok_ROFF_shc, cName: "roff_tok::ROFF_shc",
     value: cint(193)),
    (name: "ROFF_shift", cEnum: roffTok_ROFF_shift,
     cName: "roff_tok::ROFF_shift", value: cint(194)),
    (name: "ROFF_sizes", cEnum: roffTok_ROFF_sizes,
     cName: "roff_tok::ROFF_sizes", value: cint(195)),
    (name: "ROFF_so", cEnum: roffTok_ROFF_so, cName: "roff_tok::ROFF_so",
     value: cint(196)),
    (name: "ROFF_spacewidth", cEnum: roffTok_ROFF_spacewidth,
     cName: "roff_tok::ROFF_spacewidth", value: cint(197)),
    (name: "ROFF_special", cEnum: roffTok_ROFF_special,
     cName: "roff_tok::ROFF_special", value: cint(198)),
    (name: "ROFF_spreadwarn", cEnum: roffTok_ROFF_spreadwarn,
     cName: "roff_tok::ROFF_spreadwarn", value: cint(199)),
    (name: "ROFF_ss", cEnum: roffTok_ROFF_ss, cName: "roff_tok::ROFF_ss",
     value: cint(200)),
    (name: "ROFF_sty", cEnum: roffTok_ROFF_sty, cName: "roff_tok::ROFF_sty",
     value: cint(201)),
    (name: "ROFF_substring", cEnum: roffTok_ROFF_substring,
     cName: "roff_tok::ROFF_substring", value: cint(202)),
    (name: "ROFF_sv", cEnum: roffTok_ROFF_sv, cName: "roff_tok::ROFF_sv",
     value: cint(203)),
    (name: "ROFF_sy", cEnum: roffTok_ROFF_sy, cName: "roff_tok::ROFF_sy",
     value: cint(204)),
    (name: "ROFF_T_", cEnum: roffTok_ROFF_T, cName: "roff_tok::ROFF_T_",
     value: cint(205)),
    (name: "ROFF_tc", cEnum: roffTok_ROFF_tc, cName: "roff_tok::ROFF_tc",
     value: cint(206)),
    (name: "ROFF_TE", cEnum: roffTok_ROFF_TE, cName: "roff_tok::ROFF_TE",
     value: cint(207)),
    (name: "ROFF_TH", cEnum: roffTok_ROFF_TH, cName: "roff_tok::ROFF_TH",
     value: cint(208)),
    (name: "ROFF_tkf", cEnum: roffTok_ROFF_tkf, cName: "roff_tok::ROFF_tkf",
     value: cint(209)),
    (name: "ROFF_tl", cEnum: roffTok_ROFF_tl, cName: "roff_tok::ROFF_tl",
     value: cint(210)),
    (name: "ROFF_tm", cEnum: roffTok_ROFF_tm, cName: "roff_tok::ROFF_tm",
     value: cint(211)),
    (name: "ROFF_tm1", cEnum: roffTok_ROFF_tm1, cName: "roff_tok::ROFF_tm1",
     value: cint(212)),
    (name: "ROFF_tmc", cEnum: roffTok_ROFF_tmc, cName: "roff_tok::ROFF_tmc",
     value: cint(213)),
    (name: "ROFF_tr", cEnum: roffTok_ROFF_tr, cName: "roff_tok::ROFF_tr",
     value: cint(214)),
    (name: "ROFF_track", cEnum: roffTok_ROFF_track,
     cName: "roff_tok::ROFF_track", value: cint(215)),
    (name: "ROFF_transchar", cEnum: roffTok_ROFF_transchar,
     cName: "roff_tok::ROFF_transchar", value: cint(216)),
    (name: "ROFF_trf", cEnum: roffTok_ROFF_trf, cName: "roff_tok::ROFF_trf",
     value: cint(217)),
    (name: "ROFF_trimat", cEnum: roffTok_ROFF_trimat,
     cName: "roff_tok::ROFF_trimat", value: cint(218)),
    (name: "ROFF_trin", cEnum: roffTok_ROFF_trin, cName: "roff_tok::ROFF_trin",
     value: cint(219)),
    (name: "ROFF_trnt", cEnum: roffTok_ROFF_trnt, cName: "roff_tok::ROFF_trnt",
     value: cint(220)),
    (name: "ROFF_troff", cEnum: roffTok_ROFF_troff,
     cName: "roff_tok::ROFF_troff", value: cint(221)),
    (name: "ROFF_TS", cEnum: roffTok_ROFF_TS, cName: "roff_tok::ROFF_TS",
     value: cint(222)),
    (name: "ROFF_uf", cEnum: roffTok_ROFF_uf, cName: "roff_tok::ROFF_uf",
     value: cint(223)),
    (name: "ROFF_ul", cEnum: roffTok_ROFF_ul, cName: "roff_tok::ROFF_ul",
     value: cint(224)),
    (name: "ROFF_unformat", cEnum: roffTok_ROFF_unformat,
     cName: "roff_tok::ROFF_unformat", value: cint(225)),
    (name: "ROFF_unwatch", cEnum: roffTok_ROFF_unwatch,
     cName: "roff_tok::ROFF_unwatch", value: cint(226)),
    (name: "ROFF_unwatchn", cEnum: roffTok_ROFF_unwatchn,
     cName: "roff_tok::ROFF_unwatchn", value: cint(227)),
    (name: "ROFF_vpt", cEnum: roffTok_ROFF_vpt, cName: "roff_tok::ROFF_vpt",
     value: cint(228)),
    (name: "ROFF_vs", cEnum: roffTok_ROFF_vs, cName: "roff_tok::ROFF_vs",
     value: cint(229)),
    (name: "ROFF_warn", cEnum: roffTok_ROFF_warn, cName: "roff_tok::ROFF_warn",
     value: cint(230)),
    (name: "ROFF_warnscale", cEnum: roffTok_ROFF_warnscale,
     cName: "roff_tok::ROFF_warnscale", value: cint(231)),
    (name: "ROFF_watch", cEnum: roffTok_ROFF_watch,
     cName: "roff_tok::ROFF_watch", value: cint(232)),
    (name: "ROFF_watchlength", cEnum: roffTok_ROFF_watchlength,
     cName: "roff_tok::ROFF_watchlength", value: cint(233)),
    (name: "ROFF_watchn", cEnum: roffTok_ROFF_watchn,
     cName: "roff_tok::ROFF_watchn", value: cint(234)),
    (name: "ROFF_wh", cEnum: roffTok_ROFF_wh, cName: "roff_tok::ROFF_wh",
     value: cint(235)),
    (name: "ROFF_while", cEnum: roffTok_ROFF_while,
     cName: "roff_tok::ROFF_while", value: cint(236)),
    (name: "ROFF_write", cEnum: roffTok_ROFF_write,
     cName: "roff_tok::ROFF_write", value: cint(237)),
    (name: "ROFF_writec", cEnum: roffTok_ROFF_writec,
     cName: "roff_tok::ROFF_writec", value: cint(238)),
    (name: "ROFF_writem", cEnum: roffTok_ROFF_writem,
     cName: "roff_tok::ROFF_writem", value: cint(239)),
    (name: "ROFF_xflag", cEnum: roffTok_ROFF_xflag,
     cName: "roff_tok::ROFF_xflag", value: cint(240)),
    (name: "ROFF_cblock", cEnum: roffTok_ROFF_cblock,
     cName: "roff_tok::ROFF_cblock", value: cint(241)),
    (name: "ROFF_RENAMED", cEnum: roffTok_ROFF_RENAMED,
     cName: "roff_tok::ROFF_RENAMED", value: cint(242)),
    (name: "ROFF_USERDEF", cEnum: roffTok_ROFF_USERDEF,
     cName: "roff_tok::ROFF_USERDEF", value: cint(243)),
    (name: "TOKEN_NONE", cEnum: roffTok_TOKEN_NONE,
     cName: "roff_tok::TOKEN_NONE", value: cint(244)),
    (name: "MDOC_Dd", cEnum: roffTok_MDOC_Dd, cName: "roff_tok::MDOC_Dd",
     value: cint(245)),
    (name: "MDOC_Dt", cEnum: roffTok_MDOC_Dt, cName: "roff_tok::MDOC_Dt",
     value: cint(246)),
    (name: "MDOC_Os", cEnum: roffTok_MDOC_Os, cName: "roff_tok::MDOC_Os",
     value: cint(247)),
    (name: "MDOC_Sh", cEnum: roffTok_MDOC_Sh, cName: "roff_tok::MDOC_Sh",
     value: cint(248)),
    (name: "MDOC_Ss", cEnum: roffTok_MDOC_Ss, cName: "roff_tok::MDOC_Ss",
     value: cint(249)),
    (name: "MDOC_Pp", cEnum: roffTok_MDOC_Pp, cName: "roff_tok::MDOC_Pp",
     value: cint(250)),
    (name: "MDOC_D1", cEnum: roffTok_MDOC_D1, cName: "roff_tok::MDOC_D1",
     value: cint(251)),
    (name: "MDOC_Dl", cEnum: roffTok_MDOC_Dl, cName: "roff_tok::MDOC_Dl",
     value: cint(252)),
    (name: "MDOC_Bd", cEnum: roffTok_MDOC_Bd, cName: "roff_tok::MDOC_Bd",
     value: cint(253)),
    (name: "MDOC_Ed", cEnum: roffTok_MDOC_Ed, cName: "roff_tok::MDOC_Ed",
     value: cint(254)),
    (name: "MDOC_Bl", cEnum: roffTok_MDOC_Bl, cName: "roff_tok::MDOC_Bl",
     value: cint(255)),
    (name: "MDOC_El", cEnum: roffTok_MDOC_El, cName: "roff_tok::MDOC_El",
     value: cint(256)),
    (name: "MDOC_It", cEnum: roffTok_MDOC_It, cName: "roff_tok::MDOC_It",
     value: cint(257)),
    (name: "MDOC_Ad", cEnum: roffTok_MDOC_Ad, cName: "roff_tok::MDOC_Ad",
     value: cint(258)),
    (name: "MDOC_An", cEnum: roffTok_MDOC_An, cName: "roff_tok::MDOC_An",
     value: cint(259)),
    (name: "MDOC_Ap", cEnum: roffTok_MDOC_Ap, cName: "roff_tok::MDOC_Ap",
     value: cint(260)),
    (name: "MDOC_Ar", cEnum: roffTok_MDOC_Ar, cName: "roff_tok::MDOC_Ar",
     value: cint(261)),
    (name: "MDOC_Cd", cEnum: roffTok_MDOC_Cd, cName: "roff_tok::MDOC_Cd",
     value: cint(262)),
    (name: "MDOC_Cm", cEnum: roffTok_MDOC_Cm, cName: "roff_tok::MDOC_Cm",
     value: cint(263)),
    (name: "MDOC_Dv", cEnum: roffTok_MDOC_Dv, cName: "roff_tok::MDOC_Dv",
     value: cint(264)),
    (name: "MDOC_Er", cEnum: roffTok_MDOC_Er, cName: "roff_tok::MDOC_Er",
     value: cint(265)),
    (name: "MDOC_Ev", cEnum: roffTok_MDOC_Ev, cName: "roff_tok::MDOC_Ev",
     value: cint(266)),
    (name: "MDOC_Ex", cEnum: roffTok_MDOC_Ex, cName: "roff_tok::MDOC_Ex",
     value: cint(267)),
    (name: "MDOC_Fa", cEnum: roffTok_MDOC_Fa, cName: "roff_tok::MDOC_Fa",
     value: cint(268)),
    (name: "MDOC_Fd", cEnum: roffTok_MDOC_Fd, cName: "roff_tok::MDOC_Fd",
     value: cint(269)),
    (name: "MDOC_Fl", cEnum: roffTok_MDOC_Fl, cName: "roff_tok::MDOC_Fl",
     value: cint(270)),
    (name: "MDOC_Fn", cEnum: roffTok_MDOC_Fn, cName: "roff_tok::MDOC_Fn",
     value: cint(271)),
    (name: "MDOC_Ft", cEnum: roffTok_MDOC_Ft, cName: "roff_tok::MDOC_Ft",
     value: cint(272)),
    (name: "MDOC_Ic", cEnum: roffTok_MDOC_Ic, cName: "roff_tok::MDOC_Ic",
     value: cint(273)),
    (name: "MDOC_In", cEnum: roffTok_MDOC_In, cName: "roff_tok::MDOC_In",
     value: cint(274)),
    (name: "MDOC_Li", cEnum: roffTok_MDOC_Li, cName: "roff_tok::MDOC_Li",
     value: cint(275)),
    (name: "MDOC_Nd", cEnum: roffTok_MDOC_Nd, cName: "roff_tok::MDOC_Nd",
     value: cint(276)),
    (name: "MDOC_Nm", cEnum: roffTok_MDOC_Nm, cName: "roff_tok::MDOC_Nm",
     value: cint(277)),
    (name: "MDOC_Op", cEnum: roffTok_MDOC_Op, cName: "roff_tok::MDOC_Op",
     value: cint(278)),
    (name: "MDOC_Ot", cEnum: roffTok_MDOC_Ot, cName: "roff_tok::MDOC_Ot",
     value: cint(279)),
    (name: "MDOC_Pa", cEnum: roffTok_MDOC_Pa, cName: "roff_tok::MDOC_Pa",
     value: cint(280)),
    (name: "MDOC_Rv", cEnum: roffTok_MDOC_Rv, cName: "roff_tok::MDOC_Rv",
     value: cint(281)),
    (name: "MDOC_St", cEnum: roffTok_MDOC_St, cName: "roff_tok::MDOC_St",
     value: cint(282)),
    (name: "MDOC_Va", cEnum: roffTok_MDOC_Va, cName: "roff_tok::MDOC_Va",
     value: cint(283)),
    (name: "MDOC_Vt", cEnum: roffTok_MDOC_Vt, cName: "roff_tok::MDOC_Vt",
     value: cint(284)),
    (name: "MDOC_Xr", cEnum: roffTok_MDOC_Xr, cName: "roff_tok::MDOC_Xr",
     value: cint(285)),
    (name: "MDOC__A", cEnum: roffTok_MDOC_A, cName: "roff_tok::MDOC__A",
     value: cint(286)),
    (name: "MDOC__B", cEnum: roffTok_MDOC_B, cName: "roff_tok::MDOC__B",
     value: cint(287)),
    (name: "MDOC__D", cEnum: roffTok_MDOC_D, cName: "roff_tok::MDOC__D",
     value: cint(288)),
    (name: "MDOC__I", cEnum: roffTok_MDOC_I, cName: "roff_tok::MDOC__I",
     value: cint(289)),
    (name: "MDOC__J", cEnum: roffTok_MDOC_J, cName: "roff_tok::MDOC__J",
     value: cint(290)),
    (name: "MDOC__N", cEnum: roffTok_MDOC_N, cName: "roff_tok::MDOC__N",
     value: cint(291)),
    (name: "MDOC__O", cEnum: roffTok_MDOC_O, cName: "roff_tok::MDOC__O",
     value: cint(292)),
    (name: "MDOC__P", cEnum: roffTok_MDOC_P, cName: "roff_tok::MDOC__P",
     value: cint(293)),
    (name: "MDOC__R", cEnum: roffTok_MDOC_R, cName: "roff_tok::MDOC__R",
     value: cint(294)),
    (name: "MDOC__T", cEnum: roffTok_MDOC_T, cName: "roff_tok::MDOC__T",
     value: cint(295)),
    (name: "MDOC__V", cEnum: roffTok_MDOC_V, cName: "roff_tok::MDOC__V",
     value: cint(296)),
    (name: "MDOC_Ac", cEnum: roffTok_MDOC_Ac, cName: "roff_tok::MDOC_Ac",
     value: cint(297)),
    (name: "MDOC_Ao", cEnum: roffTok_MDOC_Ao, cName: "roff_tok::MDOC_Ao",
     value: cint(298)),
    (name: "MDOC_Aq", cEnum: roffTok_MDOC_Aq, cName: "roff_tok::MDOC_Aq",
     value: cint(299)),
    (name: "MDOC_At", cEnum: roffTok_MDOC_At, cName: "roff_tok::MDOC_At",
     value: cint(300)),
    (name: "MDOC_Bc", cEnum: roffTok_MDOC_Bc, cName: "roff_tok::MDOC_Bc",
     value: cint(301)),
    (name: "MDOC_Bf", cEnum: roffTok_MDOC_Bf, cName: "roff_tok::MDOC_Bf",
     value: cint(302)),
    (name: "MDOC_Bo", cEnum: roffTok_MDOC_Bo, cName: "roff_tok::MDOC_Bo",
     value: cint(303)),
    (name: "MDOC_Bq", cEnum: roffTok_MDOC_Bq, cName: "roff_tok::MDOC_Bq",
     value: cint(304)),
    (name: "MDOC_Bsx", cEnum: roffTok_MDOC_Bsx, cName: "roff_tok::MDOC_Bsx",
     value: cint(305)),
    (name: "MDOC_Bx", cEnum: roffTok_MDOC_Bx, cName: "roff_tok::MDOC_Bx",
     value: cint(306)),
    (name: "MDOC_Db", cEnum: roffTok_MDOC_Db, cName: "roff_tok::MDOC_Db",
     value: cint(307)),
    (name: "MDOC_Dc", cEnum: roffTok_MDOC_Dc, cName: "roff_tok::MDOC_Dc",
     value: cint(308)),
    (name: "MDOC_Do", cEnum: roffTok_MDOC_Do, cName: "roff_tok::MDOC_Do",
     value: cint(309)),
    (name: "MDOC_Dq", cEnum: roffTok_MDOC_Dq, cName: "roff_tok::MDOC_Dq",
     value: cint(310)),
    (name: "MDOC_Ec", cEnum: roffTok_MDOC_Ec, cName: "roff_tok::MDOC_Ec",
     value: cint(311)),
    (name: "MDOC_Ef", cEnum: roffTok_MDOC_Ef, cName: "roff_tok::MDOC_Ef",
     value: cint(312)),
    (name: "MDOC_Em", cEnum: roffTok_MDOC_Em, cName: "roff_tok::MDOC_Em",
     value: cint(313)),
    (name: "MDOC_Eo", cEnum: roffTok_MDOC_Eo, cName: "roff_tok::MDOC_Eo",
     value: cint(314)),
    (name: "MDOC_Fx", cEnum: roffTok_MDOC_Fx, cName: "roff_tok::MDOC_Fx",
     value: cint(315)),
    (name: "MDOC_Ms", cEnum: roffTok_MDOC_Ms, cName: "roff_tok::MDOC_Ms",
     value: cint(316)),
    (name: "MDOC_No", cEnum: roffTok_MDOC_No, cName: "roff_tok::MDOC_No",
     value: cint(317)),
    (name: "MDOC_Ns", cEnum: roffTok_MDOC_Ns, cName: "roff_tok::MDOC_Ns",
     value: cint(318)),
    (name: "MDOC_Nx", cEnum: roffTok_MDOC_Nx, cName: "roff_tok::MDOC_Nx",
     value: cint(319)),
    (name: "MDOC_Ox", cEnum: roffTok_MDOC_Ox, cName: "roff_tok::MDOC_Ox",
     value: cint(320)),
    (name: "MDOC_Pc", cEnum: roffTok_MDOC_Pc, cName: "roff_tok::MDOC_Pc",
     value: cint(321)),
    (name: "MDOC_Pf", cEnum: roffTok_MDOC_Pf, cName: "roff_tok::MDOC_Pf",
     value: cint(322)),
    (name: "MDOC_Po", cEnum: roffTok_MDOC_Po, cName: "roff_tok::MDOC_Po",
     value: cint(323)),
    (name: "MDOC_Pq", cEnum: roffTok_MDOC_Pq, cName: "roff_tok::MDOC_Pq",
     value: cint(324)),
    (name: "MDOC_Qc", cEnum: roffTok_MDOC_Qc, cName: "roff_tok::MDOC_Qc",
     value: cint(325)),
    (name: "MDOC_Ql", cEnum: roffTok_MDOC_Ql, cName: "roff_tok::MDOC_Ql",
     value: cint(326)),
    (name: "MDOC_Qo", cEnum: roffTok_MDOC_Qo, cName: "roff_tok::MDOC_Qo",
     value: cint(327)),
    (name: "MDOC_Qq", cEnum: roffTok_MDOC_Qq, cName: "roff_tok::MDOC_Qq",
     value: cint(328)),
    (name: "MDOC_Re", cEnum: roffTok_MDOC_Re, cName: "roff_tok::MDOC_Re",
     value: cint(329)),
    (name: "MDOC_Rs", cEnum: roffTok_MDOC_Rs, cName: "roff_tok::MDOC_Rs",
     value: cint(330)),
    (name: "MDOC_Sc", cEnum: roffTok_MDOC_Sc, cName: "roff_tok::MDOC_Sc",
     value: cint(331)),
    (name: "MDOC_So", cEnum: roffTok_MDOC_So, cName: "roff_tok::MDOC_So",
     value: cint(332)),
    (name: "MDOC_Sq", cEnum: roffTok_MDOC_Sq, cName: "roff_tok::MDOC_Sq",
     value: cint(333)),
    (name: "MDOC_Sm", cEnum: roffTok_MDOC_Sm, cName: "roff_tok::MDOC_Sm",
     value: cint(334)),
    (name: "MDOC_Sx", cEnum: roffTok_MDOC_Sx, cName: "roff_tok::MDOC_Sx",
     value: cint(335)),
    (name: "MDOC_Sy", cEnum: roffTok_MDOC_Sy, cName: "roff_tok::MDOC_Sy",
     value: cint(336)),
    (name: "MDOC_Tn", cEnum: roffTok_MDOC_Tn, cName: "roff_tok::MDOC_Tn",
     value: cint(337)),
    (name: "MDOC_Ux", cEnum: roffTok_MDOC_Ux, cName: "roff_tok::MDOC_Ux",
     value: cint(338)),
    (name: "MDOC_Xc", cEnum: roffTok_MDOC_Xc, cName: "roff_tok::MDOC_Xc",
     value: cint(339)),
    (name: "MDOC_Xo", cEnum: roffTok_MDOC_Xo, cName: "roff_tok::MDOC_Xo",
     value: cint(340)),
    (name: "MDOC_Fo", cEnum: roffTok_MDOC_Fo, cName: "roff_tok::MDOC_Fo",
     value: cint(341)),
    (name: "MDOC_Fc", cEnum: roffTok_MDOC_Fc, cName: "roff_tok::MDOC_Fc",
     value: cint(342)),
    (name: "MDOC_Oo", cEnum: roffTok_MDOC_Oo, cName: "roff_tok::MDOC_Oo",
     value: cint(343)),
    (name: "MDOC_Oc", cEnum: roffTok_MDOC_Oc, cName: "roff_tok::MDOC_Oc",
     value: cint(344)),
    (name: "MDOC_Bk", cEnum: roffTok_MDOC_Bk, cName: "roff_tok::MDOC_Bk",
     value: cint(345)),
    (name: "MDOC_Ek", cEnum: roffTok_MDOC_Ek, cName: "roff_tok::MDOC_Ek",
     value: cint(346)),
    (name: "MDOC_Bt", cEnum: roffTok_MDOC_Bt, cName: "roff_tok::MDOC_Bt",
     value: cint(347)),
    (name: "MDOC_Hf", cEnum: roffTok_MDOC_Hf, cName: "roff_tok::MDOC_Hf",
     value: cint(348)),
    (name: "MDOC_Fr", cEnum: roffTok_MDOC_Fr, cName: "roff_tok::MDOC_Fr",
     value: cint(349)),
    (name: "MDOC_Ud", cEnum: roffTok_MDOC_Ud, cName: "roff_tok::MDOC_Ud",
     value: cint(350)),
    (name: "MDOC_Lb", cEnum: roffTok_MDOC_Lb, cName: "roff_tok::MDOC_Lb",
     value: cint(351)),
    (name: "MDOC_Lp", cEnum: roffTok_MDOC_Lp, cName: "roff_tok::MDOC_Lp",
     value: cint(352)),
    (name: "MDOC_Lk", cEnum: roffTok_MDOC_Lk, cName: "roff_tok::MDOC_Lk",
     value: cint(353)),
    (name: "MDOC_Mt", cEnum: roffTok_MDOC_Mt, cName: "roff_tok::MDOC_Mt",
     value: cint(354)),
    (name: "MDOC_Brq", cEnum: roffTok_MDOC_Brq, cName: "roff_tok::MDOC_Brq",
     value: cint(355)),
    (name: "MDOC_Bro", cEnum: roffTok_MDOC_Bro, cName: "roff_tok::MDOC_Bro",
     value: cint(356)),
    (name: "MDOC_Brc", cEnum: roffTok_MDOC_Brc, cName: "roff_tok::MDOC_Brc",
     value: cint(357)),
    (name: "MDOC__C", cEnum: roffTok_MDOC_C, cName: "roff_tok::MDOC__C",
     value: cint(358)),
    (name: "MDOC_Es", cEnum: roffTok_MDOC_Es, cName: "roff_tok::MDOC_Es",
     value: cint(359)),
    (name: "MDOC_En", cEnum: roffTok_MDOC_En, cName: "roff_tok::MDOC_En",
     value: cint(360)),
    (name: "MDOC_Dx", cEnum: roffTok_MDOC_Dx, cName: "roff_tok::MDOC_Dx",
     value: cint(361)),
    (name: "MDOC__Q", cEnum: roffTok_MDOC_Q, cName: "roff_tok::MDOC__Q",
     value: cint(362)),
    (name: "MDOC__U", cEnum: roffTok_MDOC_U, cName: "roff_tok::MDOC__U",
     value: cint(363)),
    (name: "MDOC_Ta", cEnum: roffTok_MDOC_Ta, cName: "roff_tok::MDOC_Ta",
     value: cint(364)),
    (name: "MDOC_MAX", cEnum: roffTok_MDOC_MAX, cName: "roff_tok::MDOC_MAX",
     value: cint(365)),
    (name: "MAN_TH", cEnum: roffTok_MAN_TH, cName: "roff_tok::MAN_TH",
     value: cint(366)),
    (name: "MAN_SH", cEnum: roffTok_MAN_SH, cName: "roff_tok::MAN_SH",
     value: cint(367)),
    (name: "MAN_SS", cEnum: roffTok_MAN_SS, cName: "roff_tok::MAN_SS",
     value: cint(368)),
    (name: "MAN_TP", cEnum: roffTok_MAN_TP, cName: "roff_tok::MAN_TP",
     value: cint(369)),
    (name: "MAN_TQ", cEnum: roffTok_MAN_TQ, cName: "roff_tok::MAN_TQ",
     value: cint(370)),
    (name: "MAN_LP", cEnum: roffTok_MAN_LP, cName: "roff_tok::MAN_LP",
     value: cint(371)),
    (name: "MAN_PP", cEnum: roffTok_MAN_PP, cName: "roff_tok::MAN_PP",
     value: cint(372)),
    (name: "MAN_P", cEnum: roffTok_MAN_P, cName: "roff_tok::MAN_P",
     value: cint(373)),
    (name: "MAN_IP", cEnum: roffTok_MAN_IP, cName: "roff_tok::MAN_IP",
     value: cint(374)),
    (name: "MAN_HP", cEnum: roffTok_MAN_HP, cName: "roff_tok::MAN_HP",
     value: cint(375)),
    (name: "MAN_SM", cEnum: roffTok_MAN_SM, cName: "roff_tok::MAN_SM",
     value: cint(376)),
    (name: "MAN_SB", cEnum: roffTok_MAN_SB, cName: "roff_tok::MAN_SB",
     value: cint(377)),
    (name: "MAN_BI", cEnum: roffTok_MAN_BI, cName: "roff_tok::MAN_BI",
     value: cint(378)),
    (name: "MAN_IB", cEnum: roffTok_MAN_IB, cName: "roff_tok::MAN_IB",
     value: cint(379)),
    (name: "MAN_BR", cEnum: roffTok_MAN_BR, cName: "roff_tok::MAN_BR",
     value: cint(380)),
    (name: "MAN_RB", cEnum: roffTok_MAN_RB, cName: "roff_tok::MAN_RB",
     value: cint(381)),
    (name: "MAN_R", cEnum: roffTok_MAN_R, cName: "roff_tok::MAN_R",
     value: cint(382)),
    (name: "MAN_B", cEnum: roffTok_MAN_B, cName: "roff_tok::MAN_B",
     value: cint(383)),
    (name: "MAN_I", cEnum: roffTok_MAN_I, cName: "roff_tok::MAN_I",
     value: cint(384)),
    (name: "MAN_IR", cEnum: roffTok_MAN_IR, cName: "roff_tok::MAN_IR",
     value: cint(385)),
    (name: "MAN_RI", cEnum: roffTok_MAN_RI, cName: "roff_tok::MAN_RI",
     value: cint(386)),
    (name: "MAN_RE", cEnum: roffTok_MAN_RE, cName: "roff_tok::MAN_RE",
     value: cint(387)),
    (name: "MAN_RS", cEnum: roffTok_MAN_RS, cName: "roff_tok::MAN_RS",
     value: cint(388)),
    (name: "MAN_DT", cEnum: roffTok_MAN_DT, cName: "roff_tok::MAN_DT",
     value: cint(389)),
    (name: "MAN_UC", cEnum: roffTok_MAN_UC, cName: "roff_tok::MAN_UC",
     value: cint(390)),
    (name: "MAN_PD", cEnum: roffTok_MAN_PD, cName: "roff_tok::MAN_PD",
     value: cint(391)),
    (name: "MAN_AT", cEnum: roffTok_MAN_AT, cName: "roff_tok::MAN_AT",
     value: cint(392)),
    (name: "MAN_in", cEnum: roffTok_MAN_in, cName: "roff_tok::MAN_in",
     value: cint(393)),
    (name: "MAN_SY", cEnum: roffTok_MAN_SY, cName: "roff_tok::MAN_SY",
     value: cint(394)),
    (name: "MAN_YS", cEnum: roffTok_MAN_YS, cName: "roff_tok::MAN_YS",
     value: cint(395)),
    (name: "MAN_OP", cEnum: roffTok_MAN_OP, cName: "roff_tok::MAN_OP",
     value: cint(396)),
    (name: "MAN_EX", cEnum: roffTok_MAN_EX, cName: "roff_tok::MAN_EX",
     value: cint(397)),
    (name: "MAN_EE", cEnum: roffTok_MAN_EE, cName: "roff_tok::MAN_EE",
     value: cint(398)),
    (name: "MAN_UR", cEnum: roffTok_MAN_UR, cName: "roff_tok::MAN_UR",
     value: cint(399)),
    (name: "MAN_UE", cEnum: roffTok_MAN_UE, cName: "roff_tok::MAN_UE",
     value: cint(400)),
    (name: "MAN_MT", cEnum: roffTok_MAN_MT, cName: "roff_tok::MAN_MT",
     value: cint(401)),
    (name: "MAN_ME", cEnum: roffTok_MAN_ME, cName: "roff_tok::MAN_ME",
     value: cint(402)),
    (name: "MAN_MAX", cEnum: roffTok_MAN_MAX, cName: "roff_tok::MAN_MAX",
     value: cint(403))]
proc toCInt*(en: RoffTok): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrRoffTokmapping[en].value

proc toCInt*(en: set[RoffTok]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrRoffTokmapping[val].value)

proc `$`*(en: RoffTokC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of roffTok_ROFF_br:
    result = "roff_tok::ROFF_br"
  of roffTok_ROFF_ce:
    result = "roff_tok::ROFF_ce"
  of roffTok_ROFF_fi:
    result = "roff_tok::ROFF_fi"
  of roffTok_ROFF_ft:
    result = "roff_tok::ROFF_ft"
  of roffTok_ROFF_ll:
    result = "roff_tok::ROFF_ll"
  of roffTok_ROFF_mc:
    result = "roff_tok::ROFF_mc"
  of roffTok_ROFF_nf:
    result = "roff_tok::ROFF_nf"
  of roffTok_ROFF_po:
    result = "roff_tok::ROFF_po"
  of roffTok_ROFF_rj:
    result = "roff_tok::ROFF_rj"
  of roffTok_ROFF_sp:
    result = "roff_tok::ROFF_sp"
  of roffTok_ROFF_ta:
    result = "roff_tok::ROFF_ta"
  of roffTok_ROFF_ti:
    result = "roff_tok::ROFF_ti"
  of roffTok_ROFF_MAX:
    result = "roff_tok::ROFF_MAX"
  of roffTok_ROFF_ab:
    result = "roff_tok::ROFF_ab"
  of roffTok_ROFF_ad:
    result = "roff_tok::ROFF_ad"
  of roffTok_ROFF_af:
    result = "roff_tok::ROFF_af"
  of roffTok_ROFF_aln:
    result = "roff_tok::ROFF_aln"
  of roffTok_ROFF_als:
    result = "roff_tok::ROFF_als"
  of roffTok_ROFF_am:
    result = "roff_tok::ROFF_am"
  of roffTok_ROFF_am1:
    result = "roff_tok::ROFF_am1"
  of roffTok_ROFF_ami:
    result = "roff_tok::ROFF_ami"
  of roffTok_ROFF_ami1:
    result = "roff_tok::ROFF_ami1"
  of roffTok_ROFF_as:
    result = "roff_tok::ROFF_as"
  of roffTok_ROFF_as1:
    result = "roff_tok::ROFF_as1"
  of roffTok_ROFF_asciify:
    result = "roff_tok::ROFF_asciify"
  of roffTok_ROFF_backtrace:
    result = "roff_tok::ROFF_backtrace"
  of roffTok_ROFF_bd:
    result = "roff_tok::ROFF_bd"
  of roffTok_ROFF_bleedat:
    result = "roff_tok::ROFF_bleedat"
  of roffTok_ROFF_blm:
    result = "roff_tok::ROFF_blm"
  of roffTok_ROFF_box:
    result = "roff_tok::ROFF_box"
  of roffTok_ROFF_boxa:
    result = "roff_tok::ROFF_boxa"
  of roffTok_ROFF_bp:
    result = "roff_tok::ROFF_bp"
  of roffTok_ROFF_BP1:
    result = "roff_tok::ROFF_BP"
  of roffTok_ROFF_break:
    result = "roff_tok::ROFF_break"
  of roffTok_ROFF_breakchar:
    result = "roff_tok::ROFF_breakchar"
  of roffTok_ROFF_brnl:
    result = "roff_tok::ROFF_brnl"
  of roffTok_ROFF_brp:
    result = "roff_tok::ROFF_brp"
  of roffTok_ROFF_brpnl:
    result = "roff_tok::ROFF_brpnl"
  of roffTok_ROFF_c2:
    result = "roff_tok::ROFF_c2"
  of roffTok_ROFF_cc:
    result = "roff_tok::ROFF_cc"
  of roffTok_ROFF_cf:
    result = "roff_tok::ROFF_cf"
  of roffTok_ROFF_cflags:
    result = "roff_tok::ROFF_cflags"
  of roffTok_ROFF_ch:
    result = "roff_tok::ROFF_ch"
  of roffTok_ROFF_char:
    result = "roff_tok::ROFF_char"
  of roffTok_ROFF_chop:
    result = "roff_tok::ROFF_chop"
  of roffTok_ROFF_class:
    result = "roff_tok::ROFF_class"
  of roffTok_ROFF_close:
    result = "roff_tok::ROFF_close"
  of roffTok_ROFF_CL:
    result = "roff_tok::ROFF_CL"
  of roffTok_ROFF_color:
    result = "roff_tok::ROFF_color"
  of roffTok_ROFF_composite:
    result = "roff_tok::ROFF_composite"
  of roffTok_ROFF_continue:
    result = "roff_tok::ROFF_continue"
  of roffTok_ROFF_cp:
    result = "roff_tok::ROFF_cp"
  of roffTok_ROFF_cropat:
    result = "roff_tok::ROFF_cropat"
  of roffTok_ROFF_cs:
    result = "roff_tok::ROFF_cs"
  of roffTok_ROFF_cu:
    result = "roff_tok::ROFF_cu"
  of roffTok_ROFF_da:
    result = "roff_tok::ROFF_da"
  of roffTok_ROFF_dch:
    result = "roff_tok::ROFF_dch"
  of roffTok_ROFF_Dd:
    result = "roff_tok::ROFF_Dd"
  of roffTok_ROFF_de:
    result = "roff_tok::ROFF_de"
  of roffTok_ROFF_de1:
    result = "roff_tok::ROFF_de1"
  of roffTok_ROFF_defcolor:
    result = "roff_tok::ROFF_defcolor"
  of roffTok_ROFF_dei:
    result = "roff_tok::ROFF_dei"
  of roffTok_ROFF_dei1:
    result = "roff_tok::ROFF_dei1"
  of roffTok_ROFF_device:
    result = "roff_tok::ROFF_device"
  of roffTok_ROFF_devicem:
    result = "roff_tok::ROFF_devicem"
  of roffTok_ROFF_di:
    result = "roff_tok::ROFF_di"
  of roffTok_ROFF_do:
    result = "roff_tok::ROFF_do"
  of roffTok_ROFF_ds:
    result = "roff_tok::ROFF_ds"
  of roffTok_ROFF_ds1:
    result = "roff_tok::ROFF_ds1"
  of roffTok_ROFF_dwh:
    result = "roff_tok::ROFF_dwh"
  of roffTok_ROFF_dt:
    result = "roff_tok::ROFF_dt"
  of roffTok_ROFF_ec:
    result = "roff_tok::ROFF_ec"
  of roffTok_ROFF_ecr:
    result = "roff_tok::ROFF_ecr"
  of roffTok_ROFF_ecs:
    result = "roff_tok::ROFF_ecs"
  of roffTok_ROFF_el:
    result = "roff_tok::ROFF_el"
  of roffTok_ROFF_em:
    result = "roff_tok::ROFF_em"
  of roffTok_ROFF_EN:
    result = "roff_tok::ROFF_EN"
  of roffTok_ROFF_eo:
    result = "roff_tok::ROFF_eo"
  of roffTok_ROFF_EP:
    result = "roff_tok::ROFF_EP"
  of roffTok_ROFF_EQ:
    result = "roff_tok::ROFF_EQ"
  of roffTok_ROFF_errprint:
    result = "roff_tok::ROFF_errprint"
  of roffTok_ROFF_ev:
    result = "roff_tok::ROFF_ev"
  of roffTok_ROFF_evc:
    result = "roff_tok::ROFF_evc"
  of roffTok_ROFF_ex:
    result = "roff_tok::ROFF_ex"
  of roffTok_ROFF_fallback:
    result = "roff_tok::ROFF_fallback"
  of roffTok_ROFF_fam:
    result = "roff_tok::ROFF_fam"
  of roffTok_ROFF_fc:
    result = "roff_tok::ROFF_fc"
  of roffTok_ROFF_fchar:
    result = "roff_tok::ROFF_fchar"
  of roffTok_ROFF_fcolor:
    result = "roff_tok::ROFF_fcolor"
  of roffTok_ROFF_fdeferlig:
    result = "roff_tok::ROFF_fdeferlig"
  of roffTok_ROFF_feature:
    result = "roff_tok::ROFF_feature"
  of roffTok_ROFF_fkern:
    result = "roff_tok::ROFF_fkern"
  of roffTok_ROFF_fl:
    result = "roff_tok::ROFF_fl"
  of roffTok_ROFF_flig:
    result = "roff_tok::ROFF_flig"
  of roffTok_ROFF_fp:
    result = "roff_tok::ROFF_fp"
  of roffTok_ROFF_fps:
    result = "roff_tok::ROFF_fps"
  of roffTok_ROFF_fschar:
    result = "roff_tok::ROFF_fschar"
  of roffTok_ROFF_fspacewidth:
    result = "roff_tok::ROFF_fspacewidth"
  of roffTok_ROFF_fspecial:
    result = "roff_tok::ROFF_fspecial"
  of roffTok_ROFF_ftr:
    result = "roff_tok::ROFF_ftr"
  of roffTok_ROFF_fzoom:
    result = "roff_tok::ROFF_fzoom"
  of roffTok_ROFF_gcolor:
    result = "roff_tok::ROFF_gcolor"
  of roffTok_ROFF_hc:
    result = "roff_tok::ROFF_hc"
  of roffTok_ROFF_hcode:
    result = "roff_tok::ROFF_hcode"
  of roffTok_ROFF_hidechar:
    result = "roff_tok::ROFF_hidechar"
  of roffTok_ROFF_hla:
    result = "roff_tok::ROFF_hla"
  of roffTok_ROFF_hlm:
    result = "roff_tok::ROFF_hlm"
  of roffTok_ROFF_hpf:
    result = "roff_tok::ROFF_hpf"
  of roffTok_ROFF_hpfa:
    result = "roff_tok::ROFF_hpfa"
  of roffTok_ROFF_hpfcode:
    result = "roff_tok::ROFF_hpfcode"
  of roffTok_ROFF_hw:
    result = "roff_tok::ROFF_hw"
  of roffTok_ROFF_hy:
    result = "roff_tok::ROFF_hy"
  of roffTok_ROFF_hylang:
    result = "roff_tok::ROFF_hylang"
  of roffTok_ROFF_hylen:
    result = "roff_tok::ROFF_hylen"
  of roffTok_ROFF_hym:
    result = "roff_tok::ROFF_hym"
  of roffTok_ROFF_hypp:
    result = "roff_tok::ROFF_hypp"
  of roffTok_ROFF_hys:
    result = "roff_tok::ROFF_hys"
  of roffTok_ROFF_ie:
    result = "roff_tok::ROFF_ie"
  of roffTok_ROFF_if:
    result = "roff_tok::ROFF_if"
  of roffTok_ROFF_ig:
    result = "roff_tok::ROFF_ig"
  of roffTok_ROFF_index:
    result = "roff_tok::ROFF_index"
  of roffTok_ROFF_it:
    result = "roff_tok::ROFF_it"
  of roffTok_ROFF_itc:
    result = "roff_tok::ROFF_itc"
  of roffTok_ROFF_IX:
    result = "roff_tok::ROFF_IX"
  of roffTok_ROFF_kern:
    result = "roff_tok::ROFF_kern"
  of roffTok_ROFF_kernafter:
    result = "roff_tok::ROFF_kernafter"
  of roffTok_ROFF_kernbefore:
    result = "roff_tok::ROFF_kernbefore"
  of roffTok_ROFF_kernpair:
    result = "roff_tok::ROFF_kernpair"
  of roffTok_ROFF_lc:
    result = "roff_tok::ROFF_lc"
  of roffTok_ROFF_lc_ctype:
    result = "roff_tok::ROFF_lc_ctype"
  of roffTok_ROFF_lds:
    result = "roff_tok::ROFF_lds"
  of roffTok_ROFF_length:
    result = "roff_tok::ROFF_length"
  of roffTok_ROFF_letadj:
    result = "roff_tok::ROFF_letadj"
  of roffTok_ROFF_lf:
    result = "roff_tok::ROFF_lf"
  of roffTok_ROFF_lg:
    result = "roff_tok::ROFF_lg"
  of roffTok_ROFF_lhang:
    result = "roff_tok::ROFF_lhang"
  of roffTok_ROFF_linetabs:
    result = "roff_tok::ROFF_linetabs"
  of roffTok_ROFF_lnr:
    result = "roff_tok::ROFF_lnr"
  of roffTok_ROFF_lnrf:
    result = "roff_tok::ROFF_lnrf"
  of roffTok_ROFF_lpfx:
    result = "roff_tok::ROFF_lpfx"
  of roffTok_ROFF_ls:
    result = "roff_tok::ROFF_ls"
  of roffTok_ROFF_lsm:
    result = "roff_tok::ROFF_lsm"
  of roffTok_ROFF_lt:
    result = "roff_tok::ROFF_lt"
  of roffTok_ROFF_mediasize:
    result = "roff_tok::ROFF_mediasize"
  of roffTok_ROFF_minss:
    result = "roff_tok::ROFF_minss"
  of roffTok_ROFF_mk:
    result = "roff_tok::ROFF_mk"
  of roffTok_ROFF_mso:
    result = "roff_tok::ROFF_mso"
  of roffTok_ROFF_na:
    result = "roff_tok::ROFF_na"
  of roffTok_ROFF_ne:
    result = "roff_tok::ROFF_ne"
  of roffTok_ROFF_nh:
    result = "roff_tok::ROFF_nh"
  of roffTok_ROFF_nhychar:
    result = "roff_tok::ROFF_nhychar"
  of roffTok_ROFF_nm:
    result = "roff_tok::ROFF_nm"
  of roffTok_ROFF_nn:
    result = "roff_tok::ROFF_nn"
  of roffTok_ROFF_nop:
    result = "roff_tok::ROFF_nop"
  of roffTok_ROFF_nr:
    result = "roff_tok::ROFF_nr"
  of roffTok_ROFF_nrf:
    result = "roff_tok::ROFF_nrf"
  of roffTok_ROFF_nroff:
    result = "roff_tok::ROFF_nroff"
  of roffTok_ROFF_ns:
    result = "roff_tok::ROFF_ns"
  of roffTok_ROFF_nx:
    result = "roff_tok::ROFF_nx"
  of roffTok_ROFF_open:
    result = "roff_tok::ROFF_open"
  of roffTok_ROFF_opena:
    result = "roff_tok::ROFF_opena"
  of roffTok_ROFF_os:
    result = "roff_tok::ROFF_os"
  of roffTok_ROFF_output:
    result = "roff_tok::ROFF_output"
  of roffTok_ROFF_padj:
    result = "roff_tok::ROFF_padj"
  of roffTok_ROFF_papersize:
    result = "roff_tok::ROFF_papersize"
  of roffTok_ROFF_pc:
    result = "roff_tok::ROFF_pc"
  of roffTok_ROFF_pev:
    result = "roff_tok::ROFF_pev"
  of roffTok_ROFF_pi:
    result = "roff_tok::ROFF_pi"
  of roffTok_ROFF_PI1:
    result = "roff_tok::ROFF_PI"
  of roffTok_ROFF_pl:
    result = "roff_tok::ROFF_pl"
  of roffTok_ROFF_pm:
    result = "roff_tok::ROFF_pm"
  of roffTok_ROFF_pn:
    result = "roff_tok::ROFF_pn"
  of roffTok_ROFF_pnr:
    result = "roff_tok::ROFF_pnr"
  of roffTok_ROFF_ps:
    result = "roff_tok::ROFF_ps"
  of roffTok_ROFF_psbb:
    result = "roff_tok::ROFF_psbb"
  of roffTok_ROFF_pshape:
    result = "roff_tok::ROFF_pshape"
  of roffTok_ROFF_pso:
    result = "roff_tok::ROFF_pso"
  of roffTok_ROFF_ptr:
    result = "roff_tok::ROFF_ptr"
  of roffTok_ROFF_pvs:
    result = "roff_tok::ROFF_pvs"
  of roffTok_ROFF_rchar:
    result = "roff_tok::ROFF_rchar"
  of roffTok_ROFF_rd:
    result = "roff_tok::ROFF_rd"
  of roffTok_ROFF_recursionlimit:
    result = "roff_tok::ROFF_recursionlimit"
  of roffTok_ROFF_return:
    result = "roff_tok::ROFF_return"
  of roffTok_ROFF_rfschar:
    result = "roff_tok::ROFF_rfschar"
  of roffTok_ROFF_rhang:
    result = "roff_tok::ROFF_rhang"
  of roffTok_ROFF_rm:
    result = "roff_tok::ROFF_rm"
  of roffTok_ROFF_rn:
    result = "roff_tok::ROFF_rn"
  of roffTok_ROFF_rnn:
    result = "roff_tok::ROFF_rnn"
  of roffTok_ROFF_rr:
    result = "roff_tok::ROFF_rr"
  of roffTok_ROFF_rs:
    result = "roff_tok::ROFF_rs"
  of roffTok_ROFF_rt:
    result = "roff_tok::ROFF_rt"
  of roffTok_ROFF_schar:
    result = "roff_tok::ROFF_schar"
  of roffTok_ROFF_sentchar:
    result = "roff_tok::ROFF_sentchar"
  of roffTok_ROFF_shc:
    result = "roff_tok::ROFF_shc"
  of roffTok_ROFF_shift:
    result = "roff_tok::ROFF_shift"
  of roffTok_ROFF_sizes:
    result = "roff_tok::ROFF_sizes"
  of roffTok_ROFF_so:
    result = "roff_tok::ROFF_so"
  of roffTok_ROFF_spacewidth:
    result = "roff_tok::ROFF_spacewidth"
  of roffTok_ROFF_special:
    result = "roff_tok::ROFF_special"
  of roffTok_ROFF_spreadwarn:
    result = "roff_tok::ROFF_spreadwarn"
  of roffTok_ROFF_ss:
    result = "roff_tok::ROFF_ss"
  of roffTok_ROFF_sty:
    result = "roff_tok::ROFF_sty"
  of roffTok_ROFF_substring:
    result = "roff_tok::ROFF_substring"
  of roffTok_ROFF_sv:
    result = "roff_tok::ROFF_sv"
  of roffTok_ROFF_sy:
    result = "roff_tok::ROFF_sy"
  of roffTok_ROFF_T:
    result = "roff_tok::ROFF_T_"
  of roffTok_ROFF_tc:
    result = "roff_tok::ROFF_tc"
  of roffTok_ROFF_TE:
    result = "roff_tok::ROFF_TE"
  of roffTok_ROFF_TH:
    result = "roff_tok::ROFF_TH"
  of roffTok_ROFF_tkf:
    result = "roff_tok::ROFF_tkf"
  of roffTok_ROFF_tl:
    result = "roff_tok::ROFF_tl"
  of roffTok_ROFF_tm:
    result = "roff_tok::ROFF_tm"
  of roffTok_ROFF_tm1:
    result = "roff_tok::ROFF_tm1"
  of roffTok_ROFF_tmc:
    result = "roff_tok::ROFF_tmc"
  of roffTok_ROFF_tr:
    result = "roff_tok::ROFF_tr"
  of roffTok_ROFF_track:
    result = "roff_tok::ROFF_track"
  of roffTok_ROFF_transchar:
    result = "roff_tok::ROFF_transchar"
  of roffTok_ROFF_trf:
    result = "roff_tok::ROFF_trf"
  of roffTok_ROFF_trimat:
    result = "roff_tok::ROFF_trimat"
  of roffTok_ROFF_trin:
    result = "roff_tok::ROFF_trin"
  of roffTok_ROFF_trnt:
    result = "roff_tok::ROFF_trnt"
  of roffTok_ROFF_troff:
    result = "roff_tok::ROFF_troff"
  of roffTok_ROFF_TS:
    result = "roff_tok::ROFF_TS"
  of roffTok_ROFF_uf:
    result = "roff_tok::ROFF_uf"
  of roffTok_ROFF_ul:
    result = "roff_tok::ROFF_ul"
  of roffTok_ROFF_unformat:
    result = "roff_tok::ROFF_unformat"
  of roffTok_ROFF_unwatch:
    result = "roff_tok::ROFF_unwatch"
  of roffTok_ROFF_unwatchn:
    result = "roff_tok::ROFF_unwatchn"
  of roffTok_ROFF_vpt:
    result = "roff_tok::ROFF_vpt"
  of roffTok_ROFF_vs:
    result = "roff_tok::ROFF_vs"
  of roffTok_ROFF_warn:
    result = "roff_tok::ROFF_warn"
  of roffTok_ROFF_warnscale:
    result = "roff_tok::ROFF_warnscale"
  of roffTok_ROFF_watch:
    result = "roff_tok::ROFF_watch"
  of roffTok_ROFF_watchlength:
    result = "roff_tok::ROFF_watchlength"
  of roffTok_ROFF_watchn:
    result = "roff_tok::ROFF_watchn"
  of roffTok_ROFF_wh:
    result = "roff_tok::ROFF_wh"
  of roffTok_ROFF_while:
    result = "roff_tok::ROFF_while"
  of roffTok_ROFF_write:
    result = "roff_tok::ROFF_write"
  of roffTok_ROFF_writec:
    result = "roff_tok::ROFF_writec"
  of roffTok_ROFF_writem:
    result = "roff_tok::ROFF_writem"
  of roffTok_ROFF_xflag:
    result = "roff_tok::ROFF_xflag"
  of roffTok_ROFF_cblock:
    result = "roff_tok::ROFF_cblock"
  of roffTok_ROFF_RENAMED:
    result = "roff_tok::ROFF_RENAMED"
  of roffTok_ROFF_USERDEF:
    result = "roff_tok::ROFF_USERDEF"
  of roffTok_TOKEN_NONE:
    result = "roff_tok::TOKEN_NONE"
  of roffTok_MDOC_Dd:
    result = "roff_tok::MDOC_Dd"
  of roffTok_MDOC_Dt:
    result = "roff_tok::MDOC_Dt"
  of roffTok_MDOC_Os:
    result = "roff_tok::MDOC_Os"
  of roffTok_MDOC_Sh:
    result = "roff_tok::MDOC_Sh"
  of roffTok_MDOC_Ss:
    result = "roff_tok::MDOC_Ss"
  of roffTok_MDOC_Pp:
    result = "roff_tok::MDOC_Pp"
  of roffTok_MDOC_D1:
    result = "roff_tok::MDOC_D1"
  of roffTok_MDOC_Dl:
    result = "roff_tok::MDOC_Dl"
  of roffTok_MDOC_Bd:
    result = "roff_tok::MDOC_Bd"
  of roffTok_MDOC_Ed:
    result = "roff_tok::MDOC_Ed"
  of roffTok_MDOC_Bl:
    result = "roff_tok::MDOC_Bl"
  of roffTok_MDOC_El:
    result = "roff_tok::MDOC_El"
  of roffTok_MDOC_It:
    result = "roff_tok::MDOC_It"
  of roffTok_MDOC_Ad:
    result = "roff_tok::MDOC_Ad"
  of roffTok_MDOC_An:
    result = "roff_tok::MDOC_An"
  of roffTok_MDOC_Ap:
    result = "roff_tok::MDOC_Ap"
  of roffTok_MDOC_Ar:
    result = "roff_tok::MDOC_Ar"
  of roffTok_MDOC_Cd:
    result = "roff_tok::MDOC_Cd"
  of roffTok_MDOC_Cm:
    result = "roff_tok::MDOC_Cm"
  of roffTok_MDOC_Dv:
    result = "roff_tok::MDOC_Dv"
  of roffTok_MDOC_Er:
    result = "roff_tok::MDOC_Er"
  of roffTok_MDOC_Ev:
    result = "roff_tok::MDOC_Ev"
  of roffTok_MDOC_Ex:
    result = "roff_tok::MDOC_Ex"
  of roffTok_MDOC_Fa:
    result = "roff_tok::MDOC_Fa"
  of roffTok_MDOC_Fd:
    result = "roff_tok::MDOC_Fd"
  of roffTok_MDOC_Fl:
    result = "roff_tok::MDOC_Fl"
  of roffTok_MDOC_Fn:
    result = "roff_tok::MDOC_Fn"
  of roffTok_MDOC_Ft:
    result = "roff_tok::MDOC_Ft"
  of roffTok_MDOC_Ic:
    result = "roff_tok::MDOC_Ic"
  of roffTok_MDOC_In:
    result = "roff_tok::MDOC_In"
  of roffTok_MDOC_Li:
    result = "roff_tok::MDOC_Li"
  of roffTok_MDOC_Nd:
    result = "roff_tok::MDOC_Nd"
  of roffTok_MDOC_Nm:
    result = "roff_tok::MDOC_Nm"
  of roffTok_MDOC_Op:
    result = "roff_tok::MDOC_Op"
  of roffTok_MDOC_Ot:
    result = "roff_tok::MDOC_Ot"
  of roffTok_MDOC_Pa:
    result = "roff_tok::MDOC_Pa"
  of roffTok_MDOC_Rv:
    result = "roff_tok::MDOC_Rv"
  of roffTok_MDOC_St:
    result = "roff_tok::MDOC_St"
  of roffTok_MDOC_Va:
    result = "roff_tok::MDOC_Va"
  of roffTok_MDOC_Vt:
    result = "roff_tok::MDOC_Vt"
  of roffTok_MDOC_Xr:
    result = "roff_tok::MDOC_Xr"
  of roffTok_MDOC_A:
    result = "roff_tok::MDOC__A"
  of roffTok_MDOC_B:
    result = "roff_tok::MDOC__B"
  of roffTok_MDOC_D:
    result = "roff_tok::MDOC__D"
  of roffTok_MDOC_I:
    result = "roff_tok::MDOC__I"
  of roffTok_MDOC_J:
    result = "roff_tok::MDOC__J"
  of roffTok_MDOC_N:
    result = "roff_tok::MDOC__N"
  of roffTok_MDOC_O:
    result = "roff_tok::MDOC__O"
  of roffTok_MDOC_P:
    result = "roff_tok::MDOC__P"
  of roffTok_MDOC_R:
    result = "roff_tok::MDOC__R"
  of roffTok_MDOC_T:
    result = "roff_tok::MDOC__T"
  of roffTok_MDOC_V:
    result = "roff_tok::MDOC__V"
  of roffTok_MDOC_Ac:
    result = "roff_tok::MDOC_Ac"
  of roffTok_MDOC_Ao:
    result = "roff_tok::MDOC_Ao"
  of roffTok_MDOC_Aq:
    result = "roff_tok::MDOC_Aq"
  of roffTok_MDOC_At:
    result = "roff_tok::MDOC_At"
  of roffTok_MDOC_Bc:
    result = "roff_tok::MDOC_Bc"
  of roffTok_MDOC_Bf:
    result = "roff_tok::MDOC_Bf"
  of roffTok_MDOC_Bo:
    result = "roff_tok::MDOC_Bo"
  of roffTok_MDOC_Bq:
    result = "roff_tok::MDOC_Bq"
  of roffTok_MDOC_Bsx:
    result = "roff_tok::MDOC_Bsx"
  of roffTok_MDOC_Bx:
    result = "roff_tok::MDOC_Bx"
  of roffTok_MDOC_Db:
    result = "roff_tok::MDOC_Db"
  of roffTok_MDOC_Dc:
    result = "roff_tok::MDOC_Dc"
  of roffTok_MDOC_Do:
    result = "roff_tok::MDOC_Do"
  of roffTok_MDOC_Dq:
    result = "roff_tok::MDOC_Dq"
  of roffTok_MDOC_Ec:
    result = "roff_tok::MDOC_Ec"
  of roffTok_MDOC_Ef:
    result = "roff_tok::MDOC_Ef"
  of roffTok_MDOC_Em:
    result = "roff_tok::MDOC_Em"
  of roffTok_MDOC_Eo:
    result = "roff_tok::MDOC_Eo"
  of roffTok_MDOC_Fx:
    result = "roff_tok::MDOC_Fx"
  of roffTok_MDOC_Ms:
    result = "roff_tok::MDOC_Ms"
  of roffTok_MDOC_No:
    result = "roff_tok::MDOC_No"
  of roffTok_MDOC_Ns:
    result = "roff_tok::MDOC_Ns"
  of roffTok_MDOC_Nx:
    result = "roff_tok::MDOC_Nx"
  of roffTok_MDOC_Ox:
    result = "roff_tok::MDOC_Ox"
  of roffTok_MDOC_Pc:
    result = "roff_tok::MDOC_Pc"
  of roffTok_MDOC_Pf:
    result = "roff_tok::MDOC_Pf"
  of roffTok_MDOC_Po:
    result = "roff_tok::MDOC_Po"
  of roffTok_MDOC_Pq:
    result = "roff_tok::MDOC_Pq"
  of roffTok_MDOC_Qc:
    result = "roff_tok::MDOC_Qc"
  of roffTok_MDOC_Ql:
    result = "roff_tok::MDOC_Ql"
  of roffTok_MDOC_Qo:
    result = "roff_tok::MDOC_Qo"
  of roffTok_MDOC_Qq:
    result = "roff_tok::MDOC_Qq"
  of roffTok_MDOC_Re:
    result = "roff_tok::MDOC_Re"
  of roffTok_MDOC_Rs:
    result = "roff_tok::MDOC_Rs"
  of roffTok_MDOC_Sc:
    result = "roff_tok::MDOC_Sc"
  of roffTok_MDOC_So:
    result = "roff_tok::MDOC_So"
  of roffTok_MDOC_Sq:
    result = "roff_tok::MDOC_Sq"
  of roffTok_MDOC_Sm:
    result = "roff_tok::MDOC_Sm"
  of roffTok_MDOC_Sx:
    result = "roff_tok::MDOC_Sx"
  of roffTok_MDOC_Sy:
    result = "roff_tok::MDOC_Sy"
  of roffTok_MDOC_Tn:
    result = "roff_tok::MDOC_Tn"
  of roffTok_MDOC_Ux:
    result = "roff_tok::MDOC_Ux"
  of roffTok_MDOC_Xc:
    result = "roff_tok::MDOC_Xc"
  of roffTok_MDOC_Xo:
    result = "roff_tok::MDOC_Xo"
  of roffTok_MDOC_Fo:
    result = "roff_tok::MDOC_Fo"
  of roffTok_MDOC_Fc:
    result = "roff_tok::MDOC_Fc"
  of roffTok_MDOC_Oo:
    result = "roff_tok::MDOC_Oo"
  of roffTok_MDOC_Oc:
    result = "roff_tok::MDOC_Oc"
  of roffTok_MDOC_Bk:
    result = "roff_tok::MDOC_Bk"
  of roffTok_MDOC_Ek:
    result = "roff_tok::MDOC_Ek"
  of roffTok_MDOC_Bt:
    result = "roff_tok::MDOC_Bt"
  of roffTok_MDOC_Hf:
    result = "roff_tok::MDOC_Hf"
  of roffTok_MDOC_Fr:
    result = "roff_tok::MDOC_Fr"
  of roffTok_MDOC_Ud:
    result = "roff_tok::MDOC_Ud"
  of roffTok_MDOC_Lb:
    result = "roff_tok::MDOC_Lb"
  of roffTok_MDOC_Lp:
    result = "roff_tok::MDOC_Lp"
  of roffTok_MDOC_Lk:
    result = "roff_tok::MDOC_Lk"
  of roffTok_MDOC_Mt:
    result = "roff_tok::MDOC_Mt"
  of roffTok_MDOC_Brq:
    result = "roff_tok::MDOC_Brq"
  of roffTok_MDOC_Bro:
    result = "roff_tok::MDOC_Bro"
  of roffTok_MDOC_Brc:
    result = "roff_tok::MDOC_Brc"
  of roffTok_MDOC_C:
    result = "roff_tok::MDOC__C"
  of roffTok_MDOC_Es:
    result = "roff_tok::MDOC_Es"
  of roffTok_MDOC_En:
    result = "roff_tok::MDOC_En"
  of roffTok_MDOC_Dx:
    result = "roff_tok::MDOC_Dx"
  of roffTok_MDOC_Q:
    result = "roff_tok::MDOC__Q"
  of roffTok_MDOC_U:
    result = "roff_tok::MDOC__U"
  of roffTok_MDOC_Ta:
    result = "roff_tok::MDOC_Ta"
  of roffTok_MDOC_MAX:
    result = "roff_tok::MDOC_MAX"
  of roffTok_MAN_TH:
    result = "roff_tok::MAN_TH"
  of roffTok_MAN_SH:
    result = "roff_tok::MAN_SH"
  of roffTok_MAN_SS:
    result = "roff_tok::MAN_SS"
  of roffTok_MAN_TP:
    result = "roff_tok::MAN_TP"
  of roffTok_MAN_TQ:
    result = "roff_tok::MAN_TQ"
  of roffTok_MAN_LP:
    result = "roff_tok::MAN_LP"
  of roffTok_MAN_PP:
    result = "roff_tok::MAN_PP"
  of roffTok_MAN_P:
    result = "roff_tok::MAN_P"
  of roffTok_MAN_IP:
    result = "roff_tok::MAN_IP"
  of roffTok_MAN_HP:
    result = "roff_tok::MAN_HP"
  of roffTok_MAN_SM:
    result = "roff_tok::MAN_SM"
  of roffTok_MAN_SB:
    result = "roff_tok::MAN_SB"
  of roffTok_MAN_BI:
    result = "roff_tok::MAN_BI"
  of roffTok_MAN_IB:
    result = "roff_tok::MAN_IB"
  of roffTok_MAN_BR:
    result = "roff_tok::MAN_BR"
  of roffTok_MAN_RB:
    result = "roff_tok::MAN_RB"
  of roffTok_MAN_R:
    result = "roff_tok::MAN_R"
  of roffTok_MAN_B:
    result = "roff_tok::MAN_B"
  of roffTok_MAN_I:
    result = "roff_tok::MAN_I"
  of roffTok_MAN_IR:
    result = "roff_tok::MAN_IR"
  of roffTok_MAN_RI:
    result = "roff_tok::MAN_RI"
  of roffTok_MAN_RE:
    result = "roff_tok::MAN_RE"
  of roffTok_MAN_RS:
    result = "roff_tok::MAN_RS"
  of roffTok_MAN_DT:
    result = "roff_tok::MAN_DT"
  of roffTok_MAN_UC:
    result = "roff_tok::MAN_UC"
  of roffTok_MAN_PD:
    result = "roff_tok::MAN_PD"
  of roffTok_MAN_AT:
    result = "roff_tok::MAN_AT"
  of roffTok_MAN_in:
    result = "roff_tok::MAN_in"
  of roffTok_MAN_SY:
    result = "roff_tok::MAN_SY"
  of roffTok_MAN_YS:
    result = "roff_tok::MAN_YS"
  of roffTok_MAN_OP:
    result = "roff_tok::MAN_OP"
  of roffTok_MAN_EX:
    result = "roff_tok::MAN_EX"
  of roffTok_MAN_EE:
    result = "roff_tok::MAN_EE"
  of roffTok_MAN_UR:
    result = "roff_tok::MAN_UR"
  of roffTok_MAN_UE:
    result = "roff_tok::MAN_UE"
  of roffTok_MAN_MT:
    result = "roff_tok::MAN_MT"
  of roffTok_MAN_ME:
    result = "roff_tok::MAN_ME"
  of roffTok_MAN_MAX:
    result = "roff_tok::MAN_MAX"
  
func toRoffTok*(en: RoffTokC): RoffTok {.inline.} =
  case en
  of roffTok_ROFF_br:
    rtRoffBr
  of roffTok_ROFF_ce:
    rtRoffCe
  of roffTok_ROFF_fi:
    rtRoffFi
  of roffTok_ROFF_ft:
    rtRoffFt
  of roffTok_ROFF_ll:
    rtRoffLl
  of roffTok_ROFF_mc:
    rtRoffMc
  of roffTok_ROFF_nf:
    rtRoffNf
  of roffTok_ROFF_po:
    rtRoffPo
  of roffTok_ROFF_rj:
    rtRoffRj
  of roffTok_ROFF_sp:
    rtRoffSp
  of roffTok_ROFF_ta:
    rtRoffTa
  of roffTok_ROFF_ti:
    rtRoffTi
  of roffTok_ROFF_MAX:
    rtRoffMax
  of roffTok_ROFF_ab:
    rtRoffAb
  of roffTok_ROFF_ad:
    rtRoffAd
  of roffTok_ROFF_af:
    rtRoffAf
  of roffTok_ROFF_aln:
    rtRoffAln
  of roffTok_ROFF_als:
    rtRoffAls
  of roffTok_ROFF_am:
    rtRoffAm
  of roffTok_ROFF_am1:
    rtRoffAm1
  of roffTok_ROFF_ami:
    rtRoffAmi
  of roffTok_ROFF_ami1:
    rtRoffAmi1
  of roffTok_ROFF_as:
    rtRoffAs
  of roffTok_ROFF_as1:
    rtRoffAs1
  of roffTok_ROFF_asciify:
    rtRoffAsciify
  of roffTok_ROFF_backtrace:
    rtRoffBacktrace
  of roffTok_ROFF_bd:
    rtRoffBd
  of roffTok_ROFF_bleedat:
    rtRoffBleedat
  of roffTok_ROFF_blm:
    rtRoffBlm
  of roffTok_ROFF_box:
    rtRoffBox
  of roffTok_ROFF_boxa:
    rtRoffBoxa
  of roffTok_ROFF_bp:
    rtRoffBp
  of roffTok_ROFF_BP1:
    rtRoffBp1
  of roffTok_ROFF_break:
    rtRoffBreak
  of roffTok_ROFF_breakchar:
    rtRoffBreakchar
  of roffTok_ROFF_brnl:
    rtRoffBrnl
  of roffTok_ROFF_brp:
    rtRoffBrp
  of roffTok_ROFF_brpnl:
    rtRoffBrpnl
  of roffTok_ROFF_c2:
    rtRoffC2
  of roffTok_ROFF_cc:
    rtRoffCc
  of roffTok_ROFF_cf:
    rtRoffCf
  of roffTok_ROFF_cflags:
    rtRoffCflags
  of roffTok_ROFF_ch:
    rtRoffCh
  of roffTok_ROFF_char:
    rtRoffChar
  of roffTok_ROFF_chop:
    rtRoffChop
  of roffTok_ROFF_class:
    rtRoffClass
  of roffTok_ROFF_close:
    rtRoffClose
  of roffTok_ROFF_CL:
    rtRoffCl
  of roffTok_ROFF_color:
    rtRoffColor
  of roffTok_ROFF_composite:
    rtRoffComposite
  of roffTok_ROFF_continue:
    rtRoffContinue
  of roffTok_ROFF_cp:
    rtRoffCp
  of roffTok_ROFF_cropat:
    rtRoffCropat
  of roffTok_ROFF_cs:
    rtRoffCs
  of roffTok_ROFF_cu:
    rtRoffCu
  of roffTok_ROFF_da:
    rtRoffDa
  of roffTok_ROFF_dch:
    rtRoffDch
  of roffTok_ROFF_Dd:
    rtRoffDd
  of roffTok_ROFF_de:
    rtRoffDe
  of roffTok_ROFF_de1:
    rtRoffDe1
  of roffTok_ROFF_defcolor:
    rtRoffDefcolor
  of roffTok_ROFF_dei:
    rtRoffDei
  of roffTok_ROFF_dei1:
    rtRoffDei1
  of roffTok_ROFF_device:
    rtRoffDevice
  of roffTok_ROFF_devicem:
    rtRoffDevicem
  of roffTok_ROFF_di:
    rtRoffDi
  of roffTok_ROFF_do:
    rtRoffDo
  of roffTok_ROFF_ds:
    rtRoffDs
  of roffTok_ROFF_ds1:
    rtRoffDs1
  of roffTok_ROFF_dwh:
    rtRoffDwh
  of roffTok_ROFF_dt:
    rtRoffDt
  of roffTok_ROFF_ec:
    rtRoffEc
  of roffTok_ROFF_ecr:
    rtRoffEcr
  of roffTok_ROFF_ecs:
    rtRoffEcs
  of roffTok_ROFF_el:
    rtRoffEl
  of roffTok_ROFF_em:
    rtRoffEm
  of roffTok_ROFF_EN:
    rtRoffEn
  of roffTok_ROFF_eo:
    rtRoffEo
  of roffTok_ROFF_EP:
    rtRoffEp
  of roffTok_ROFF_EQ:
    rtRoffEq
  of roffTok_ROFF_errprint:
    rtRoffErrprint
  of roffTok_ROFF_ev:
    rtRoffEv
  of roffTok_ROFF_evc:
    rtRoffEvc
  of roffTok_ROFF_ex:
    rtRoffEx
  of roffTok_ROFF_fallback:
    rtRoffFallback
  of roffTok_ROFF_fam:
    rtRoffFam
  of roffTok_ROFF_fc:
    rtRoffFc
  of roffTok_ROFF_fchar:
    rtRoffFchar
  of roffTok_ROFF_fcolor:
    rtRoffFcolor
  of roffTok_ROFF_fdeferlig:
    rtRoffFdeferlig
  of roffTok_ROFF_feature:
    rtRoffFeature
  of roffTok_ROFF_fkern:
    rtRoffFkern
  of roffTok_ROFF_fl:
    rtRoffFl
  of roffTok_ROFF_flig:
    rtRoffFlig
  of roffTok_ROFF_fp:
    rtRoffFp
  of roffTok_ROFF_fps:
    rtRoffFps
  of roffTok_ROFF_fschar:
    rtRoffFschar
  of roffTok_ROFF_fspacewidth:
    rtRoffFspacewidth
  of roffTok_ROFF_fspecial:
    rtRoffFspecial
  of roffTok_ROFF_ftr:
    rtRoffFtr
  of roffTok_ROFF_fzoom:
    rtRoffFzoom
  of roffTok_ROFF_gcolor:
    rtRoffGcolor
  of roffTok_ROFF_hc:
    rtRoffHc
  of roffTok_ROFF_hcode:
    rtRoffHcode
  of roffTok_ROFF_hidechar:
    rtRoffHidechar
  of roffTok_ROFF_hla:
    rtRoffHla
  of roffTok_ROFF_hlm:
    rtRoffHlm
  of roffTok_ROFF_hpf:
    rtRoffHpf
  of roffTok_ROFF_hpfa:
    rtRoffHpfa
  of roffTok_ROFF_hpfcode:
    rtRoffHpfcode
  of roffTok_ROFF_hw:
    rtRoffHw
  of roffTok_ROFF_hy:
    rtRoffHy
  of roffTok_ROFF_hylang:
    rtRoffHylang
  of roffTok_ROFF_hylen:
    rtRoffHylen
  of roffTok_ROFF_hym:
    rtRoffHym
  of roffTok_ROFF_hypp:
    rtRoffHypp
  of roffTok_ROFF_hys:
    rtRoffHys
  of roffTok_ROFF_ie:
    rtRoffIe
  of roffTok_ROFF_if:
    rtRoffIf
  of roffTok_ROFF_ig:
    rtRoffIg
  of roffTok_ROFF_index:
    rtRoffIndex
  of roffTok_ROFF_it:
    rtRoffIt
  of roffTok_ROFF_itc:
    rtRoffItc
  of roffTok_ROFF_IX:
    rtRoffIx
  of roffTok_ROFF_kern:
    rtRoffKern
  of roffTok_ROFF_kernafter:
    rtRoffKernafter
  of roffTok_ROFF_kernbefore:
    rtRoffKernbefore
  of roffTok_ROFF_kernpair:
    rtRoffKernpair
  of roffTok_ROFF_lc:
    rtRoffLc
  of roffTok_ROFF_lc_ctype:
    rtRoffLcCtype
  of roffTok_ROFF_lds:
    rtRoffLds
  of roffTok_ROFF_length:
    rtRoffLength
  of roffTok_ROFF_letadj:
    rtRoffLetadj
  of roffTok_ROFF_lf:
    rtRoffLf
  of roffTok_ROFF_lg:
    rtRoffLg
  of roffTok_ROFF_lhang:
    rtRoffLhang
  of roffTok_ROFF_linetabs:
    rtRoffLinetabs
  of roffTok_ROFF_lnr:
    rtRoffLnr
  of roffTok_ROFF_lnrf:
    rtRoffLnrf
  of roffTok_ROFF_lpfx:
    rtRoffLpfx
  of roffTok_ROFF_ls:
    rtRoffLs
  of roffTok_ROFF_lsm:
    rtRoffLsm
  of roffTok_ROFF_lt:
    rtRoffLt
  of roffTok_ROFF_mediasize:
    rtRoffMediasize
  of roffTok_ROFF_minss:
    rtRoffMinss
  of roffTok_ROFF_mk:
    rtRoffMk
  of roffTok_ROFF_mso:
    rtRoffMso
  of roffTok_ROFF_na:
    rtRoffNa
  of roffTok_ROFF_ne:
    rtRoffNe
  of roffTok_ROFF_nh:
    rtRoffNh
  of roffTok_ROFF_nhychar:
    rtRoffNhychar
  of roffTok_ROFF_nm:
    rtRoffNm
  of roffTok_ROFF_nn:
    rtRoffNn
  of roffTok_ROFF_nop:
    rtRoffNop
  of roffTok_ROFF_nr:
    rtRoffNr
  of roffTok_ROFF_nrf:
    rtRoffNrf
  of roffTok_ROFF_nroff:
    rtRoffNroff
  of roffTok_ROFF_ns:
    rtRoffNs
  of roffTok_ROFF_nx:
    rtRoffNx
  of roffTok_ROFF_open:
    rtRoffOpen
  of roffTok_ROFF_opena:
    rtRoffOpena
  of roffTok_ROFF_os:
    rtRoffOs
  of roffTok_ROFF_output:
    rtRoffOutput
  of roffTok_ROFF_padj:
    rtRoffPadj
  of roffTok_ROFF_papersize:
    rtRoffPapersize
  of roffTok_ROFF_pc:
    rtRoffPc
  of roffTok_ROFF_pev:
    rtRoffPev
  of roffTok_ROFF_pi:
    rtRoffPi
  of roffTok_ROFF_PI1:
    rtRoffPi1
  of roffTok_ROFF_pl:
    rtRoffPl
  of roffTok_ROFF_pm:
    rtRoffPm
  of roffTok_ROFF_pn:
    rtRoffPn
  of roffTok_ROFF_pnr:
    rtRoffPnr
  of roffTok_ROFF_ps:
    rtRoffPs
  of roffTok_ROFF_psbb:
    rtRoffPsbb
  of roffTok_ROFF_pshape:
    rtRoffPshape
  of roffTok_ROFF_pso:
    rtRoffPso
  of roffTok_ROFF_ptr:
    rtRoffPtr
  of roffTok_ROFF_pvs:
    rtRoffPvs
  of roffTok_ROFF_rchar:
    rtRoffRchar
  of roffTok_ROFF_rd:
    rtRoffRd
  of roffTok_ROFF_recursionlimit:
    rtRoffRecursionlimit
  of roffTok_ROFF_return:
    rtRoffReturn
  of roffTok_ROFF_rfschar:
    rtRoffRfschar
  of roffTok_ROFF_rhang:
    rtRoffRhang
  of roffTok_ROFF_rm:
    rtRoffRm
  of roffTok_ROFF_rn:
    rtRoffRn
  of roffTok_ROFF_rnn:
    rtRoffRnn
  of roffTok_ROFF_rr:
    rtRoffRr
  of roffTok_ROFF_rs:
    rtRoffRs
  of roffTok_ROFF_rt:
    rtRoffRt
  of roffTok_ROFF_schar:
    rtRoffSchar
  of roffTok_ROFF_sentchar:
    rtRoffSentchar
  of roffTok_ROFF_shc:
    rtRoffShc
  of roffTok_ROFF_shift:
    rtRoffShift
  of roffTok_ROFF_sizes:
    rtRoffSizes
  of roffTok_ROFF_so:
    rtRoffSo
  of roffTok_ROFF_spacewidth:
    rtRoffSpacewidth
  of roffTok_ROFF_special:
    rtRoffSpecial
  of roffTok_ROFF_spreadwarn:
    rtRoffSpreadwarn
  of roffTok_ROFF_ss:
    rtRoffSs
  of roffTok_ROFF_sty:
    rtRoffSty
  of roffTok_ROFF_substring:
    rtRoffSubstring
  of roffTok_ROFF_sv:
    rtRoffSv
  of roffTok_ROFF_sy:
    rtRoffSy
  of roffTok_ROFF_T:
    rtRoffT
  of roffTok_ROFF_tc:
    rtRoffTc
  of roffTok_ROFF_TE:
    rtRoffTe
  of roffTok_ROFF_TH:
    rtRoffTh
  of roffTok_ROFF_tkf:
    rtRoffTkf
  of roffTok_ROFF_tl:
    rtRoffTl
  of roffTok_ROFF_tm:
    rtRoffTm
  of roffTok_ROFF_tm1:
    rtRoffTm1
  of roffTok_ROFF_tmc:
    rtRoffTmc
  of roffTok_ROFF_tr:
    rtRoffTr
  of roffTok_ROFF_track:
    rtRoffTrack
  of roffTok_ROFF_transchar:
    rtRoffTranschar
  of roffTok_ROFF_trf:
    rtRoffTrf
  of roffTok_ROFF_trimat:
    rtRoffTrimat
  of roffTok_ROFF_trin:
    rtRoffTrin
  of roffTok_ROFF_trnt:
    rtRoffTrnt
  of roffTok_ROFF_troff:
    rtRoffTroff
  of roffTok_ROFF_TS:
    rtRoffTs
  of roffTok_ROFF_uf:
    rtRoffUf
  of roffTok_ROFF_ul:
    rtRoffUl
  of roffTok_ROFF_unformat:
    rtRoffUnformat
  of roffTok_ROFF_unwatch:
    rtRoffUnwatch
  of roffTok_ROFF_unwatchn:
    rtRoffUnwatchn
  of roffTok_ROFF_vpt:
    rtRoffVpt
  of roffTok_ROFF_vs:
    rtRoffVs
  of roffTok_ROFF_warn:
    rtRoffWarn
  of roffTok_ROFF_warnscale:
    rtRoffWarnscale
  of roffTok_ROFF_watch:
    rtRoffWatch
  of roffTok_ROFF_watchlength:
    rtRoffWatchlength
  of roffTok_ROFF_watchn:
    rtRoffWatchn
  of roffTok_ROFF_wh:
    rtRoffWh
  of roffTok_ROFF_while:
    rtRoffWhile
  of roffTok_ROFF_write:
    rtRoffWrite
  of roffTok_ROFF_writec:
    rtRoffWritec
  of roffTok_ROFF_writem:
    rtRoffWritem
  of roffTok_ROFF_xflag:
    rtRoffXflag
  of roffTok_ROFF_cblock:
    rtRoffCblock
  of roffTok_ROFF_RENAMED:
    rtRoffRenamed
  of roffTok_ROFF_USERDEF:
    rtRoffUserdef
  of roffTok_TOKEN_NONE:
    rtTokenNone
  of roffTok_MDOC_Dd:
    rtMdocDd
  of roffTok_MDOC_Dt:
    rtMdocDt
  of roffTok_MDOC_Os:
    rtMdocOs
  of roffTok_MDOC_Sh:
    rtMdocSh
  of roffTok_MDOC_Ss:
    rtMdocSs
  of roffTok_MDOC_Pp:
    rtMdocPp
  of roffTok_MDOC_D1:
    rtMdocD1
  of roffTok_MDOC_Dl:
    rtMdocDl
  of roffTok_MDOC_Bd:
    rtMdocBd
  of roffTok_MDOC_Ed:
    rtMdocEd
  of roffTok_MDOC_Bl:
    rtMdocBl
  of roffTok_MDOC_El:
    rtMdocEl
  of roffTok_MDOC_It:
    rtMdocIt
  of roffTok_MDOC_Ad:
    rtMdocAd
  of roffTok_MDOC_An:
    rtMdocAn
  of roffTok_MDOC_Ap:
    rtMdocAp
  of roffTok_MDOC_Ar:
    rtMdocAr
  of roffTok_MDOC_Cd:
    rtMdocCd
  of roffTok_MDOC_Cm:
    rtMdocCm
  of roffTok_MDOC_Dv:
    rtMdocDv
  of roffTok_MDOC_Er:
    rtMdocEr
  of roffTok_MDOC_Ev:
    rtMdocEv
  of roffTok_MDOC_Ex:
    rtMdocEx
  of roffTok_MDOC_Fa:
    rtMdocFa
  of roffTok_MDOC_Fd:
    rtMdocFd
  of roffTok_MDOC_Fl:
    rtMdocFl
  of roffTok_MDOC_Fn:
    rtMdocFn
  of roffTok_MDOC_Ft:
    rtMdocFt
  of roffTok_MDOC_Ic:
    rtMdocIc
  of roffTok_MDOC_In:
    rtMdocIn
  of roffTok_MDOC_Li:
    rtMdocLi
  of roffTok_MDOC_Nd:
    rtMdocNd
  of roffTok_MDOC_Nm:
    rtMdocNm
  of roffTok_MDOC_Op:
    rtMdocOp
  of roffTok_MDOC_Ot:
    rtMdocOt
  of roffTok_MDOC_Pa:
    rtMdocPa
  of roffTok_MDOC_Rv:
    rtMdocRv
  of roffTok_MDOC_St:
    rtMdocSt
  of roffTok_MDOC_Va:
    rtMdocVa
  of roffTok_MDOC_Vt:
    rtMdocVt
  of roffTok_MDOC_Xr:
    rtMdocXr
  of roffTok_MDOC_A:
    rtMdocA
  of roffTok_MDOC_B:
    rtMdocB
  of roffTok_MDOC_D:
    rtMdocD
  of roffTok_MDOC_I:
    rtMdocI
  of roffTok_MDOC_J:
    rtMdocJ
  of roffTok_MDOC_N:
    rtMdocN
  of roffTok_MDOC_O:
    rtMdocO
  of roffTok_MDOC_P:
    rtMdocP
  of roffTok_MDOC_R:
    rtMdocR
  of roffTok_MDOC_T:
    rtMdocT
  of roffTok_MDOC_V:
    rtMdocV
  of roffTok_MDOC_Ac:
    rtMdocAc
  of roffTok_MDOC_Ao:
    rtMdocAo
  of roffTok_MDOC_Aq:
    rtMdocAq
  of roffTok_MDOC_At:
    rtMdocAt
  of roffTok_MDOC_Bc:
    rtMdocBc
  of roffTok_MDOC_Bf:
    rtMdocBf
  of roffTok_MDOC_Bo:
    rtMdocBo
  of roffTok_MDOC_Bq:
    rtMdocBq
  of roffTok_MDOC_Bsx:
    rtMdocBsx
  of roffTok_MDOC_Bx:
    rtMdocBx
  of roffTok_MDOC_Db:
    rtMdocDb
  of roffTok_MDOC_Dc:
    rtMdocDc
  of roffTok_MDOC_Do:
    rtMdocDo
  of roffTok_MDOC_Dq:
    rtMdocDq
  of roffTok_MDOC_Ec:
    rtMdocEc
  of roffTok_MDOC_Ef:
    rtMdocEf
  of roffTok_MDOC_Em:
    rtMdocEm
  of roffTok_MDOC_Eo:
    rtMdocEo
  of roffTok_MDOC_Fx:
    rtMdocFx
  of roffTok_MDOC_Ms:
    rtMdocMs
  of roffTok_MDOC_No:
    rtMdocNo
  of roffTok_MDOC_Ns:
    rtMdocNs
  of roffTok_MDOC_Nx:
    rtMdocNx
  of roffTok_MDOC_Ox:
    rtMdocOx
  of roffTok_MDOC_Pc:
    rtMdocPc
  of roffTok_MDOC_Pf:
    rtMdocPf
  of roffTok_MDOC_Po:
    rtMdocPo
  of roffTok_MDOC_Pq:
    rtMdocPq
  of roffTok_MDOC_Qc:
    rtMdocQc
  of roffTok_MDOC_Ql:
    rtMdocQl
  of roffTok_MDOC_Qo:
    rtMdocQo
  of roffTok_MDOC_Qq:
    rtMdocQq
  of roffTok_MDOC_Re:
    rtMdocRe
  of roffTok_MDOC_Rs:
    rtMdocRs
  of roffTok_MDOC_Sc:
    rtMdocSc
  of roffTok_MDOC_So:
    rtMdocSo
  of roffTok_MDOC_Sq:
    rtMdocSq
  of roffTok_MDOC_Sm:
    rtMdocSm
  of roffTok_MDOC_Sx:
    rtMdocSx
  of roffTok_MDOC_Sy:
    rtMdocSy
  of roffTok_MDOC_Tn:
    rtMdocTn
  of roffTok_MDOC_Ux:
    rtMdocUx
  of roffTok_MDOC_Xc:
    rtMdocXc
  of roffTok_MDOC_Xo:
    rtMdocXo
  of roffTok_MDOC_Fo:
    rtMdocFo
  of roffTok_MDOC_Fc:
    rtMdocFc
  of roffTok_MDOC_Oo:
    rtMdocOo
  of roffTok_MDOC_Oc:
    rtMdocOc
  of roffTok_MDOC_Bk:
    rtMdocBk
  of roffTok_MDOC_Ek:
    rtMdocEk
  of roffTok_MDOC_Bt:
    rtMdocBt
  of roffTok_MDOC_Hf:
    rtMdocHf
  of roffTok_MDOC_Fr:
    rtMdocFr
  of roffTok_MDOC_Ud:
    rtMdocUd
  of roffTok_MDOC_Lb:
    rtMdocLb
  of roffTok_MDOC_Lp:
    rtMdocLp
  of roffTok_MDOC_Lk:
    rtMdocLk
  of roffTok_MDOC_Mt:
    rtMdocMt
  of roffTok_MDOC_Brq:
    rtMdocBrq
  of roffTok_MDOC_Bro:
    rtMdocBro
  of roffTok_MDOC_Brc:
    rtMdocBrc
  of roffTok_MDOC_C:
    rtMdocC
  of roffTok_MDOC_Es:
    rtMdocEs
  of roffTok_MDOC_En:
    rtMdocEn
  of roffTok_MDOC_Dx:
    rtMdocDx
  of roffTok_MDOC_Q:
    rtMdocQ
  of roffTok_MDOC_U:
    rtMdocU
  of roffTok_MDOC_Ta:
    rtMdocTa
  of roffTok_MDOC_MAX:
    rtMdocMax
  of roffTok_MAN_TH:
    rtManTh
  of roffTok_MAN_SH:
    rtManSh
  of roffTok_MAN_SS:
    rtManSs
  of roffTok_MAN_TP:
    rtManTp
  of roffTok_MAN_TQ:
    rtManTq
  of roffTok_MAN_LP:
    rtManLp
  of roffTok_MAN_PP:
    rtManPp
  of roffTok_MAN_P:
    rtManP
  of roffTok_MAN_IP:
    rtManIp
  of roffTok_MAN_HP:
    rtManHp
  of roffTok_MAN_SM:
    rtManSm
  of roffTok_MAN_SB:
    rtManSb
  of roffTok_MAN_BI:
    rtManBi
  of roffTok_MAN_IB:
    rtManIb
  of roffTok_MAN_BR:
    rtManBr
  of roffTok_MAN_RB:
    rtManRb
  of roffTok_MAN_R:
    rtManR
  of roffTok_MAN_B:
    rtManB
  of roffTok_MAN_I:
    rtManI
  of roffTok_MAN_IR:
    rtManIr
  of roffTok_MAN_RI:
    rtManRi
  of roffTok_MAN_RE:
    rtManRe
  of roffTok_MAN_RS:
    rtManRs
  of roffTok_MAN_DT:
    rtManDt
  of roffTok_MAN_UC:
    rtManUc
  of roffTok_MAN_PD:
    rtManPd
  of roffTok_MAN_AT:
    rtManAt
  of roffTok_MAN_in:
    rtManIn
  of roffTok_MAN_SY:
    rtManSy
  of roffTok_MAN_YS:
    rtManYs
  of roffTok_MAN_OP:
    rtManOp
  of roffTok_MAN_EX:
    rtManEx
  of roffTok_MAN_EE:
    rtManEe
  of roffTok_MAN_UR:
    rtManUr
  of roffTok_MAN_UE:
    rtManUe
  of roffTok_MAN_MT:
    rtManMt
  of roffTok_MAN_ME:
    rtManMe
  of roffTok_MAN_MAX:
    rtManMax
  
converter toRoffTokC*(en: RoffTok): RoffTokC {.inline.} =
  arrRoffTokmapping[en].cEnum




const
  arrMdocEndbodymapping: array[MdocEndbody, tuple[name: string,
      cEnum: MdocEndbodyC, cName: string, value: cint]] = [
    (name: "ENDBODY_NOT", cEnum: mdocEndbody_ENDBODY_NOT,
     cName: "mdoc_endbody::ENDBODY_NOT", value: cint(0)),
    (name: "ENDBODY_SPACE", cEnum: mdocEndbody_ENDBODY_SPACE,
     cName: "mdoc_endbody::ENDBODY_SPACE", value: cint(1))]
proc toCInt*(en: MdocEndbody): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocEndbodymapping[en].value

proc toCInt*(en: set[MdocEndbody]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocEndbodymapping[val].value)

proc `$`*(en: MdocEndbodyC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocEndbody_ENDBODY_NOT:
    result = "mdoc_endbody::ENDBODY_NOT"
  of mdocEndbody_ENDBODY_SPACE:
    result = "mdoc_endbody::ENDBODY_SPACE"
  
func toMdocEndbody*(en: MdocEndbodyC): MdocEndbody {.inline.} =
  case en
  of mdocEndbody_ENDBODY_NOT:
    meNot
  of mdocEndbody_ENDBODY_SPACE:
    meSpace
  
converter toMdocEndbodyC*(en: MdocEndbody): MdocEndbodyC {.inline.} =
  arrMdocEndbodymapping[en].cEnum




const
  arrMandocOsmapping: array[MandocOs, tuple[name: string, cEnum: MandocOsC,
      cName: string, value: cint]] = [
    (name: "MANDOC_OS_OTHER", cEnum: mandocOs_MANDOC_OS_OTHER,
     cName: "mandoc_os::MANDOC_OS_OTHER", value: cint(0)),
    (name: "MANDOC_OS_NETBSD", cEnum: mandocOs_MANDOC_OS_NETBSD,
     cName: "mandoc_os::MANDOC_OS_NETBSD", value: cint(1)),
    (name: "MANDOC_OS_OPENBSD", cEnum: mandocOs_MANDOC_OS_OPENBSD,
     cName: "mandoc_os::MANDOC_OS_OPENBSD", value: cint(2))]
proc toCInt*(en: MandocOs): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMandocOsmapping[en].value

proc toCInt*(en: set[MandocOs]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMandocOsmapping[val].value)

proc `$`*(en: MandocOsC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mandocOs_MANDOC_OS_OTHER:
    result = "mandoc_os::MANDOC_OS_OTHER"
  of mandocOs_MANDOC_OS_NETBSD:
    result = "mandoc_os::MANDOC_OS_NETBSD"
  of mandocOs_MANDOC_OS_OPENBSD:
    result = "mandoc_os::MANDOC_OS_OPENBSD"
  
func toMandocOs*(en: MandocOsC): MandocOs {.inline.} =
  case en
  of mandocOs_MANDOC_OS_OTHER:
    mdosOther
  of mandocOs_MANDOC_OS_NETBSD:
    mdosNetbsd
  of mandocOs_MANDOC_OS_OPENBSD:
    mdosOpenbsd
  
converter toMandocOsC*(en: MandocOs): MandocOsC {.inline.} =
  arrMandocOsmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `roff_node`
# Declared in roff.h:496
proc cnewRoffNode*(): ptr RoffNode {.importc: r"new roff_node()",
                                     header: allHeaders.}
  ## @import{[[code:struct!roff_node]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `roff_node`
# Declared in roff.h:496
proc destroyRoffNode*(obj: ptr RoffNode): void {.importc: r"#.~roff_node()",
    header: allHeaders.}
  ## @import{[[code:struct!roff_node]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `roff_node`
# Declared in roff.h:496
proc newRoffNode*(): ref RoffNode =
  ## @import{[[code:struct!roff_node]]}
  newImportAux()
  new(result, proc (destr: ref RoffNode) =
    destroyRoffNode(addr destr[]))
  {.emit: "new ((void*)result) roff_node(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `roff_meta`
# Declared in roff.h:532
proc cnewRoffMeta*(): ptr RoffMeta {.importc: r"new roff_meta()",
                                     header: allHeaders.}
  ## @import{[[code:struct!roff_meta]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `roff_meta`
# Declared in roff.h:532
proc destroyRoffMeta*(obj: ptr RoffMeta): void {.importc: r"#.~roff_meta()",
    header: allHeaders.}
  ## @import{[[code:struct!roff_meta]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `roff_meta`
# Declared in roff.h:532
proc newRoffMeta*(): ref RoffMeta =
  ## @import{[[code:struct!roff_meta]]}
  newImportAux()
  new(result, proc (destr: ref RoffMeta) =
    destroyRoffMeta(addr destr[]))
  {.emit: "new ((void*)result) roff_meta(); /* Placement new */".}



const
  arrMdocargtmapping: array[Mdocargt, tuple[name: string, cEnum: MdocargtC,
      cName: string, value: cint]] = [
    (name: "MDOC_Split", cEnum: mdocargt_MDOC_Split,
     cName: "mdocargt::MDOC_Split", value: cint(0)),
    (name: "MDOC_Nosplit", cEnum: mdocargt_MDOC_Nosplit,
     cName: "mdocargt::MDOC_Nosplit", value: cint(1)),
    (name: "MDOC_Ragged", cEnum: mdocargt_MDOC_Ragged,
     cName: "mdocargt::MDOC_Ragged", value: cint(2)),
    (name: "MDOC_Unfilled", cEnum: mdocargt_MDOC_Unfilled,
     cName: "mdocargt::MDOC_Unfilled", value: cint(3)),
    (name: "MDOC_Literal", cEnum: mdocargt_MDOC_Literal,
     cName: "mdocargt::MDOC_Literal", value: cint(4)),
    (name: "MDOC_File", cEnum: mdocargt_MDOC_File, cName: "mdocargt::MDOC_File",
     value: cint(5)),
    (name: "MDOC_Offset", cEnum: mdocargt_MDOC_Offset,
     cName: "mdocargt::MDOC_Offset", value: cint(6)),
    (name: "MDOC_Bullet", cEnum: mdocargt_MDOC_Bullet,
     cName: "mdocargt::MDOC_Bullet", value: cint(7)),
    (name: "MDOC_Dash", cEnum: mdocargt_MDOC_Dash, cName: "mdocargt::MDOC_Dash",
     value: cint(8)),
    (name: "MDOC_Hyphen", cEnum: mdocargt_MDOC_Hyphen,
     cName: "mdocargt::MDOC_Hyphen", value: cint(9)),
    (name: "MDOC_Item", cEnum: mdocargt_MDOC_Item, cName: "mdocargt::MDOC_Item",
     value: cint(10)),
    (name: "MDOC_Enum", cEnum: mdocargt_MDOC_Enum, cName: "mdocargt::MDOC_Enum",
     value: cint(11)),
    (name: "MDOC_Tag", cEnum: mdocargt_MDOC_Tag, cName: "mdocargt::MDOC_Tag",
     value: cint(12)),
    (name: "MDOC_Diag", cEnum: mdocargt_MDOC_Diag, cName: "mdocargt::MDOC_Diag",
     value: cint(13)),
    (name: "MDOC_Hang", cEnum: mdocargt_MDOC_Hang, cName: "mdocargt::MDOC_Hang",
     value: cint(14)),
    (name: "MDOC_Ohang", cEnum: mdocargt_MDOC_Ohang,
     cName: "mdocargt::MDOC_Ohang", value: cint(15)),
    (name: "MDOC_Inset", cEnum: mdocargt_MDOC_Inset,
     cName: "mdocargt::MDOC_Inset", value: cint(16)),
    (name: "MDOC_Column", cEnum: mdocargt_MDOC_Column,
     cName: "mdocargt::MDOC_Column", value: cint(17)),
    (name: "MDOC_Width", cEnum: mdocargt_MDOC_Width,
     cName: "mdocargt::MDOC_Width", value: cint(18)),
    (name: "MDOC_Compact", cEnum: mdocargt_MDOC_Compact,
     cName: "mdocargt::MDOC_Compact", value: cint(19)),
    (name: "MDOC_Std", cEnum: mdocargt_MDOC_Std, cName: "mdocargt::MDOC_Std",
     value: cint(20)),
    (name: "MDOC_Filled", cEnum: mdocargt_MDOC_Filled,
     cName: "mdocargt::MDOC_Filled", value: cint(21)),
    (name: "MDOC_Words", cEnum: mdocargt_MDOC_Words,
     cName: "mdocargt::MDOC_Words", value: cint(22)),
    (name: "MDOC_Emphasis", cEnum: mdocargt_MDOC_Emphasis,
     cName: "mdocargt::MDOC_Emphasis", value: cint(23)),
    (name: "MDOC_Symbolic", cEnum: mdocargt_MDOC_Symbolic,
     cName: "mdocargt::MDOC_Symbolic", value: cint(24)),
    (name: "MDOC_Nested", cEnum: mdocargt_MDOC_Nested,
     cName: "mdocargt::MDOC_Nested", value: cint(25)),
    (name: "MDOC_Centred", cEnum: mdocargt_MDOC_Centred,
     cName: "mdocargt::MDOC_Centred", value: cint(26)),
    (name: "MDOC_ARG_MAX", cEnum: mdocargt_MDOC_ARG_MAX,
     cName: "mdocargt::MDOC_ARG_MAX", value: cint(27))]
proc toCInt*(en: Mdocargt): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocargtmapping[en].value

proc toCInt*(en: set[Mdocargt]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocargtmapping[val].value)

proc `$`*(en: MdocargtC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocargt_MDOC_Split:
    result = "mdocargt::MDOC_Split"
  of mdocargt_MDOC_Nosplit:
    result = "mdocargt::MDOC_Nosplit"
  of mdocargt_MDOC_Ragged:
    result = "mdocargt::MDOC_Ragged"
  of mdocargt_MDOC_Unfilled:
    result = "mdocargt::MDOC_Unfilled"
  of mdocargt_MDOC_Literal:
    result = "mdocargt::MDOC_Literal"
  of mdocargt_MDOC_File:
    result = "mdocargt::MDOC_File"
  of mdocargt_MDOC_Offset:
    result = "mdocargt::MDOC_Offset"
  of mdocargt_MDOC_Bullet:
    result = "mdocargt::MDOC_Bullet"
  of mdocargt_MDOC_Dash:
    result = "mdocargt::MDOC_Dash"
  of mdocargt_MDOC_Hyphen:
    result = "mdocargt::MDOC_Hyphen"
  of mdocargt_MDOC_Item:
    result = "mdocargt::MDOC_Item"
  of mdocargt_MDOC_Enum:
    result = "mdocargt::MDOC_Enum"
  of mdocargt_MDOC_Tag:
    result = "mdocargt::MDOC_Tag"
  of mdocargt_MDOC_Diag:
    result = "mdocargt::MDOC_Diag"
  of mdocargt_MDOC_Hang:
    result = "mdocargt::MDOC_Hang"
  of mdocargt_MDOC_Ohang:
    result = "mdocargt::MDOC_Ohang"
  of mdocargt_MDOC_Inset:
    result = "mdocargt::MDOC_Inset"
  of mdocargt_MDOC_Column:
    result = "mdocargt::MDOC_Column"
  of mdocargt_MDOC_Width:
    result = "mdocargt::MDOC_Width"
  of mdocargt_MDOC_Compact:
    result = "mdocargt::MDOC_Compact"
  of mdocargt_MDOC_Std:
    result = "mdocargt::MDOC_Std"
  of mdocargt_MDOC_Filled:
    result = "mdocargt::MDOC_Filled"
  of mdocargt_MDOC_Words:
    result = "mdocargt::MDOC_Words"
  of mdocargt_MDOC_Emphasis:
    result = "mdocargt::MDOC_Emphasis"
  of mdocargt_MDOC_Symbolic:
    result = "mdocargt::MDOC_Symbolic"
  of mdocargt_MDOC_Nested:
    result = "mdocargt::MDOC_Nested"
  of mdocargt_MDOC_Centred:
    result = "mdocargt::MDOC_Centred"
  of mdocargt_MDOC_ARG_MAX:
    result = "mdocargt::MDOC_ARG_MAX"
  
func toMdocargt*(en: MdocargtC): Mdocargt {.inline.} =
  case en
  of mdocargt_MDOC_Split:
    mSplit
  of mdocargt_MDOC_Nosplit:
    mNosplit
  of mdocargt_MDOC_Ragged:
    mRagged
  of mdocargt_MDOC_Unfilled:
    mUnfilled
  of mdocargt_MDOC_Literal:
    mLiteral
  of mdocargt_MDOC_File:
    mFile
  of mdocargt_MDOC_Offset:
    mOffset
  of mdocargt_MDOC_Bullet:
    mBullet
  of mdocargt_MDOC_Dash:
    mDash
  of mdocargt_MDOC_Hyphen:
    mHyphen
  of mdocargt_MDOC_Item:
    mItem
  of mdocargt_MDOC_Enum:
    mEnum
  of mdocargt_MDOC_Tag:
    mTag
  of mdocargt_MDOC_Diag:
    mDiag
  of mdocargt_MDOC_Hang:
    mHang
  of mdocargt_MDOC_Ohang:
    mOhang
  of mdocargt_MDOC_Inset:
    mInset
  of mdocargt_MDOC_Column:
    mColumn
  of mdocargt_MDOC_Width:
    mWidth
  of mdocargt_MDOC_Compact:
    mCompact
  of mdocargt_MDOC_Std:
    mStd
  of mdocargt_MDOC_Filled:
    mFilled
  of mdocargt_MDOC_Words:
    mWords
  of mdocargt_MDOC_Emphasis:
    mEmphasis
  of mdocargt_MDOC_Symbolic:
    mSymbolic
  of mdocargt_MDOC_Nested:
    mNested
  of mdocargt_MDOC_Centred:
    mCentred
  of mdocargt_MDOC_ARG_MAX:
    mArgMax
  
converter toMdocargtC*(en: Mdocargt): MdocargtC {.inline.} =
  arrMdocargtmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc cnewMdocArgv*(): ptr MdocArgv {.importc: r"new mdoc_argv()",
                                     header: allHeaders.}
  ## @import{[[code:struct!mdoc_argv]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc destroyMdocArgv*(obj: ptr MdocArgv): void {.importc: r"#.~mdoc_argv()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_argv]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc newMdocArgv*(): ref MdocArgv =
  ## @import{[[code:struct!mdoc_argv]]}
  newImportAux()
  new(result, proc (destr: ref MdocArgv) =
    destroyMdocArgv(addr destr[]))
  {.emit: "new ((void*)result) mdoc_argv(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc cnewMdocArg*(): ptr MdocArg {.importc: r"new mdoc_arg()",
                                   header: allHeaders.}
  ## @import{[[code:struct!mdoc_arg]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc destroyMdocArg*(obj: ptr MdocArg): void {.importc: r"#.~mdoc_arg()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_arg]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc newMdocArg*(): ref MdocArg =
  ## @import{[[code:struct!mdoc_arg]]}
  newImportAux()
  new(result, proc (destr: ref MdocArg) =
    destroyMdocArg(addr destr[]))
  {.emit: "new ((void*)result) mdoc_arg(); /* Placement new */".}



const
  arrMdocListmapping: array[MdocList, tuple[name: string, cEnum: MdocListC,
      cName: string, value: cint]] = [
    (name: "LIST__NONE", cEnum: mdocList_LIST_NONE,
     cName: "mdoc_list::LIST__NONE", value: cint(0)),
    (name: "LIST_bullet", cEnum: mdocList_LIST_bullet,
     cName: "mdoc_list::LIST_bullet", value: cint(1)),
    (name: "LIST_column", cEnum: mdocList_LIST_column,
     cName: "mdoc_list::LIST_column", value: cint(2)),
    (name: "LIST_dash", cEnum: mdocList_LIST_dash,
     cName: "mdoc_list::LIST_dash", value: cint(3)),
    (name: "LIST_diag", cEnum: mdocList_LIST_diag,
     cName: "mdoc_list::LIST_diag", value: cint(4)),
    (name: "LIST_enum", cEnum: mdocList_LIST_enum,
     cName: "mdoc_list::LIST_enum", value: cint(5)),
    (name: "LIST_hang", cEnum: mdocList_LIST_hang,
     cName: "mdoc_list::LIST_hang", value: cint(6)),
    (name: "LIST_hyphen", cEnum: mdocList_LIST_hyphen,
     cName: "mdoc_list::LIST_hyphen", value: cint(7)),
    (name: "LIST_inset", cEnum: mdocList_LIST_inset,
     cName: "mdoc_list::LIST_inset", value: cint(8)),
    (name: "LIST_item", cEnum: mdocList_LIST_item,
     cName: "mdoc_list::LIST_item", value: cint(9)),
    (name: "LIST_ohang", cEnum: mdocList_LIST_ohang,
     cName: "mdoc_list::LIST_ohang", value: cint(10)),
    (name: "LIST_tag", cEnum: mdocList_LIST_tag, cName: "mdoc_list::LIST_tag",
     value: cint(11)),
    (name: "LIST_MAX", cEnum: mdocList_LIST_MAX, cName: "mdoc_list::LIST_MAX",
     value: cint(12))]
proc toCInt*(en: MdocList): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocListmapping[en].value

proc toCInt*(en: set[MdocList]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocListmapping[val].value)

proc `$`*(en: MdocListC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocList_LIST_NONE:
    result = "mdoc_list::LIST__NONE"
  of mdocList_LIST_bullet:
    result = "mdoc_list::LIST_bullet"
  of mdocList_LIST_column:
    result = "mdoc_list::LIST_column"
  of mdocList_LIST_dash:
    result = "mdoc_list::LIST_dash"
  of mdocList_LIST_diag:
    result = "mdoc_list::LIST_diag"
  of mdocList_LIST_enum:
    result = "mdoc_list::LIST_enum"
  of mdocList_LIST_hang:
    result = "mdoc_list::LIST_hang"
  of mdocList_LIST_hyphen:
    result = "mdoc_list::LIST_hyphen"
  of mdocList_LIST_inset:
    result = "mdoc_list::LIST_inset"
  of mdocList_LIST_item:
    result = "mdoc_list::LIST_item"
  of mdocList_LIST_ohang:
    result = "mdoc_list::LIST_ohang"
  of mdocList_LIST_tag:
    result = "mdoc_list::LIST_tag"
  of mdocList_LIST_MAX:
    result = "mdoc_list::LIST_MAX"
  
func toMdocList*(en: MdocListC): MdocList {.inline.} =
  case en
  of mdocList_LIST_NONE:
    mlNone
  of mdocList_LIST_bullet:
    mlBullet
  of mdocList_LIST_column:
    mlColumn
  of mdocList_LIST_dash:
    mlDash
  of mdocList_LIST_diag:
    mlDiag
  of mdocList_LIST_enum:
    mlEnum
  of mdocList_LIST_hang:
    mlHang
  of mdocList_LIST_hyphen:
    mlHyphen
  of mdocList_LIST_inset:
    mlInset
  of mdocList_LIST_item:
    mlItem
  of mdocList_LIST_ohang:
    mlOhang
  of mdocList_LIST_tag:
    mlTag
  of mdocList_LIST_MAX:
    mlMax1
  
converter toMdocListC*(en: MdocList): MdocListC {.inline.} =
  arrMdocListmapping[en].cEnum




const
  arrMdocDispmapping: array[MdocDisp, tuple[name: string, cEnum: MdocDispC,
      cName: string, value: cint]] = [
    (name: "DISP__NONE", cEnum: mdocDisp_DISP_NONE,
     cName: "mdoc_disp::DISP__NONE", value: cint(0)),
    (name: "DISP_centered", cEnum: mdocDisp_DISP_centered,
     cName: "mdoc_disp::DISP_centered", value: cint(1)),
    (name: "DISP_ragged", cEnum: mdocDisp_DISP_ragged,
     cName: "mdoc_disp::DISP_ragged", value: cint(2)),
    (name: "DISP_unfilled", cEnum: mdocDisp_DISP_unfilled,
     cName: "mdoc_disp::DISP_unfilled", value: cint(3)),
    (name: "DISP_filled", cEnum: mdocDisp_DISP_filled,
     cName: "mdoc_disp::DISP_filled", value: cint(4)),
    (name: "DISP_literal", cEnum: mdocDisp_DISP_literal,
     cName: "mdoc_disp::DISP_literal", value: cint(5))]
proc toCInt*(en: MdocDisp): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocDispmapping[en].value

proc toCInt*(en: set[MdocDisp]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocDispmapping[val].value)

proc `$`*(en: MdocDispC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocDisp_DISP_NONE:
    result = "mdoc_disp::DISP__NONE"
  of mdocDisp_DISP_centered:
    result = "mdoc_disp::DISP_centered"
  of mdocDisp_DISP_ragged:
    result = "mdoc_disp::DISP_ragged"
  of mdocDisp_DISP_unfilled:
    result = "mdoc_disp::DISP_unfilled"
  of mdocDisp_DISP_filled:
    result = "mdoc_disp::DISP_filled"
  of mdocDisp_DISP_literal:
    result = "mdoc_disp::DISP_literal"
  
func toMdocDisp*(en: MdocDispC): MdocDisp {.inline.} =
  case en
  of mdocDisp_DISP_NONE:
    mdNone
  of mdocDisp_DISP_centered:
    mdCentered
  of mdocDisp_DISP_ragged:
    mdRagged
  of mdocDisp_DISP_unfilled:
    mdUnfilled
  of mdocDisp_DISP_filled:
    mdFilled
  of mdocDisp_DISP_literal:
    mdLiteral
  
converter toMdocDispC*(en: MdocDisp): MdocDispC {.inline.} =
  arrMdocDispmapping[en].cEnum




const
  arrMdocAuthmapping: array[MdocAuth, tuple[name: string, cEnum: MdocAuthC,
      cName: string, value: cint]] = [
    (name: "AUTH__NONE", cEnum: mdocAuth_AUTH_NONE,
     cName: "mdoc_auth::AUTH__NONE", value: cint(0)),
    (name: "AUTH_split", cEnum: mdocAuth_AUTH_split,
     cName: "mdoc_auth::AUTH_split", value: cint(1)),
    (name: "AUTH_nosplit", cEnum: mdocAuth_AUTH_nosplit,
     cName: "mdoc_auth::AUTH_nosplit", value: cint(2))]
proc toCInt*(en: MdocAuth): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocAuthmapping[en].value

proc toCInt*(en: set[MdocAuth]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocAuthmapping[val].value)

proc `$`*(en: MdocAuthC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocAuth_AUTH_NONE:
    result = "mdoc_auth::AUTH__NONE"
  of mdocAuth_AUTH_split:
    result = "mdoc_auth::AUTH_split"
  of mdocAuth_AUTH_nosplit:
    result = "mdoc_auth::AUTH_nosplit"
  
func toMdocAuth*(en: MdocAuthC): MdocAuth {.inline.} =
  case en
  of mdocAuth_AUTH_NONE:
    maNone
  of mdocAuth_AUTH_split:
    maSplit
  of mdocAuth_AUTH_nosplit:
    maNosplit
  
converter toMdocAuthC*(en: MdocAuth): MdocAuthC {.inline.} =
  arrMdocAuthmapping[en].cEnum




const
  arrMdocFontmapping: array[MdocFont, tuple[name: string, cEnum: MdocFontC,
      cName: string, value: cint]] = [
    (name: "FONT__NONE", cEnum: mdocFont_FONT_NONE,
     cName: "mdoc_font::FONT__NONE", value: cint(0)),
    (name: "FONT_Em", cEnum: mdocFont_FONT_Em, cName: "mdoc_font::FONT_Em",
     value: cint(1)),
    (name: "FONT_Li", cEnum: mdocFont_FONT_Li, cName: "mdoc_font::FONT_Li",
     value: cint(2)),
    (name: "FONT_Sy", cEnum: mdocFont_FONT_Sy, cName: "mdoc_font::FONT_Sy",
     value: cint(3))]
proc toCInt*(en: MdocFont): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMdocFontmapping[en].value

proc toCInt*(en: set[MdocFont]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMdocFontmapping[val].value)

proc `$`*(en: MdocFontC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mdocFont_FONT_NONE:
    result = "mdoc_font::FONT__NONE"
  of mdocFont_FONT_Em:
    result = "mdoc_font::FONT_Em"
  of mdocFont_FONT_Li:
    result = "mdoc_font::FONT_Li"
  of mdocFont_FONT_Sy:
    result = "mdoc_font::FONT_Sy"
  
func toMdocFont*(en: MdocFontC): MdocFont {.inline.} =
  case en
  of mdocFont_FONT_NONE:
    mfNone
  of mdocFont_FONT_Em:
    mfEm
  of mdocFont_FONT_Li:
    mfLi
  of mdocFont_FONT_Sy:
    mfSy
  
converter toMdocFontC*(en: MdocFont): MdocFontC {.inline.} =
  arrMdocFontmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_bd`
# Declared in mdoc.h:113
proc cnewMdocBd*(): ptr MdocBd {.importc: r"new mdoc_bd()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_bd]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_bd`
# Declared in mdoc.h:113
proc destroyMdocBd*(obj: ptr MdocBd): void {.importc: r"#.~mdoc_bd()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_bd]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_bd`
# Declared in mdoc.h:113
proc newMdocBd*(): ref MdocBd =
  ## @import{[[code:struct!mdoc_bd]]}
  newImportAux()
  new(result, proc (destr: ref MdocBd) =
    destroyMdocBd(addr destr[]))
  {.emit: "new ((void*)result) mdoc_bd(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_bl`
# Declared in mdoc.h:119
proc cnewMdocBl*(): ptr MdocBl {.importc: r"new mdoc_bl()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_bl]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_bl`
# Declared in mdoc.h:119
proc destroyMdocBl*(obj: ptr MdocBl): void {.importc: r"#.~mdoc_bl()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_bl]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_bl`
# Declared in mdoc.h:119
proc newMdocBl*(): ref MdocBl =
  ## @import{[[code:struct!mdoc_bl]]}
  newImportAux()
  new(result, proc (destr: ref MdocBl) =
    destroyMdocBl(addr destr[]))
  {.emit: "new ((void*)result) mdoc_bl(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_bf`
# Declared in mdoc.h:129
proc cnewMdocBf*(): ptr MdocBf {.importc: r"new mdoc_bf()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_bf]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_bf`
# Declared in mdoc.h:129
proc destroyMdocBf*(obj: ptr MdocBf): void {.importc: r"#.~mdoc_bf()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_bf]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_bf`
# Declared in mdoc.h:129
proc newMdocBf*(): ref MdocBf =
  ## @import{[[code:struct!mdoc_bf]]}
  newImportAux()
  new(result, proc (destr: ref MdocBf) =
    destroyMdocBf(addr destr[]))
  {.emit: "new ((void*)result) mdoc_bf(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_an`
# Declared in mdoc.h:133
proc cnewMdocAn*(): ptr MdocAn {.importc: r"new mdoc_an()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_an]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_an`
# Declared in mdoc.h:133
proc destroyMdocAn*(obj: ptr MdocAn): void {.importc: r"#.~mdoc_an()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_an]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_an`
# Declared in mdoc.h:133
proc newMdocAn*(): ref MdocAn =
  ## @import{[[code:struct!mdoc_an]]}
  newImportAux()
  new(result, proc (destr: ref MdocAn) =
    destroyMdocAn(addr destr[]))
  {.emit: "new ((void*)result) mdoc_an(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_rs`
# Declared in mdoc.h:137
proc cnewMdocRs*(): ptr MdocRs {.importc: r"new mdoc_rs()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_rs]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_rs`
# Declared in mdoc.h:137
proc destroyMdocRs*(obj: ptr MdocRs): void {.importc: r"#.~mdoc_rs()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_rs]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_rs`
# Declared in mdoc.h:137
proc newMdocRs*(): ref MdocRs =
  ## @import{[[code:struct!mdoc_rs]]}
  newImportAux()
  new(result, proc (destr: ref MdocRs) =
    destroyMdocRs(addr destr[]))
  {.emit: "new ((void*)result) mdoc_rs(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mdoc_data`
# Declared in mdoc.h:146
proc cnewMdocData*(): ptr MdocData {.importc: r"new mdoc_data()",
                                     header: allHeaders.}
  ## @import{[[code:union!mdoc_data]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mdoc_data`
# Declared in mdoc.h:146
proc destroyMdocData*(obj: ptr MdocData): void {.importc: r"#.~mdoc_data()",
    header: allHeaders.}
  ## @import{[[code:union!mdoc_data]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mdoc_data`
# Declared in mdoc.h:146
proc newMdocData*(): ref MdocData =
  ## @import{[[code:union!mdoc_data]]}
  newImportAux()
  new(result, proc (destr: ref MdocData) =
    destroyMdocData(addr destr[]))
  {.emit: "new ((void*)result) mdoc_data(); /* Placement new */".}



const
  arrEqnBoxtmapping: array[EqnBoxt, tuple[name: string, cEnum: EqnBoxtC,
      cName: string, value: cint]] = [
    (name: "EQN_TEXT", cEnum: eqnBoxt_EQN_TEXT, cName: "eqn_boxt::EQN_TEXT",
     value: cint(0)),
    (name: "EQN_SUBEXPR", cEnum: eqnBoxt_EQN_SUBEXPR,
     cName: "eqn_boxt::EQN_SUBEXPR", value: cint(1)),
    (name: "EQN_LIST", cEnum: eqnBoxt_EQN_LIST, cName: "eqn_boxt::EQN_LIST",
     value: cint(2)),
    (name: "EQN_PILE", cEnum: eqnBoxt_EQN_PILE, cName: "eqn_boxt::EQN_PILE",
     value: cint(3)),
    (name: "EQN_MATRIX", cEnum: eqnBoxt_EQN_MATRIX,
     cName: "eqn_boxt::EQN_MATRIX", value: cint(4))]
proc toCInt*(en: EqnBoxt): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrEqnBoxtmapping[en].value

proc toCInt*(en: set[EqnBoxt]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrEqnBoxtmapping[val].value)

proc `$`*(en: EqnBoxtC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of eqnBoxt_EQN_TEXT:
    result = "eqn_boxt::EQN_TEXT"
  of eqnBoxt_EQN_SUBEXPR:
    result = "eqn_boxt::EQN_SUBEXPR"
  of eqnBoxt_EQN_LIST:
    result = "eqn_boxt::EQN_LIST"
  of eqnBoxt_EQN_PILE:
    result = "eqn_boxt::EQN_PILE"
  of eqnBoxt_EQN_MATRIX:
    result = "eqn_boxt::EQN_MATRIX"
  
func toEqnBoxt*(en: EqnBoxtC): EqnBoxt {.inline.} =
  case en
  of eqnBoxt_EQN_TEXT:
    ebText
  of eqnBoxt_EQN_SUBEXPR:
    ebSubexpr
  of eqnBoxt_EQN_LIST:
    ebList
  of eqnBoxt_EQN_PILE:
    ebPile
  of eqnBoxt_EQN_MATRIX:
    ebMatrix
  
converter toEqnBoxtC*(en: EqnBoxt): EqnBoxtC {.inline.} =
  arrEqnBoxtmapping[en].cEnum




const
  arrEqnFonttmapping: array[EqnFontt, tuple[name: string, cEnum: EqnFonttC,
      cName: string, value: cint]] = [
    (name: "EQNFONT_NONE", cEnum: eqnFontt_EQNFONT_NONE,
     cName: "eqn_fontt::EQNFONT_NONE", value: cint(0)),
    (name: "EQNFONT_ROMAN", cEnum: eqnFontt_EQNFONT_ROMAN,
     cName: "eqn_fontt::EQNFONT_ROMAN", value: cint(1)),
    (name: "EQNFONT_BOLD", cEnum: eqnFontt_EQNFONT_BOLD,
     cName: "eqn_fontt::EQNFONT_BOLD", value: cint(2)),
    (name: "EQNFONT_FAT", cEnum: eqnFontt_EQNFONT_FAT,
     cName: "eqn_fontt::EQNFONT_FAT", value: cint(3)),
    (name: "EQNFONT_ITALIC", cEnum: eqnFontt_EQNFONT_ITALIC,
     cName: "eqn_fontt::EQNFONT_ITALIC", value: cint(4)),
    (name: "EQNFONT__MAX", cEnum: eqnFontt_EQNFONT_MAX,
     cName: "eqn_fontt::EQNFONT__MAX", value: cint(5))]
proc toCInt*(en: EqnFontt): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrEqnFonttmapping[en].value

proc toCInt*(en: set[EqnFontt]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrEqnFonttmapping[val].value)

proc `$`*(en: EqnFonttC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of eqnFontt_EQNFONT_NONE:
    result = "eqn_fontt::EQNFONT_NONE"
  of eqnFontt_EQNFONT_ROMAN:
    result = "eqn_fontt::EQNFONT_ROMAN"
  of eqnFontt_EQNFONT_BOLD:
    result = "eqn_fontt::EQNFONT_BOLD"
  of eqnFontt_EQNFONT_FAT:
    result = "eqn_fontt::EQNFONT_FAT"
  of eqnFontt_EQNFONT_ITALIC:
    result = "eqn_fontt::EQNFONT_ITALIC"
  of eqnFontt_EQNFONT_MAX:
    result = "eqn_fontt::EQNFONT__MAX"
  
func toEqnFontt*(en: EqnFonttC): EqnFontt {.inline.} =
  case en
  of eqnFontt_EQNFONT_NONE:
    efNone
  of eqnFontt_EQNFONT_ROMAN:
    efRoman
  of eqnFontt_EQNFONT_BOLD:
    efBold
  of eqnFontt_EQNFONT_FAT:
    efFat
  of eqnFontt_EQNFONT_ITALIC:
    efItalic
  of eqnFontt_EQNFONT_MAX:
    efMax
  
converter toEqnFonttC*(en: EqnFontt): EqnFonttC {.inline.} =
  arrEqnFonttmapping[en].cEnum




const
  arrEqnPostmapping: array[EqnPost, tuple[name: string, cEnum: EqnPostC,
      cName: string, value: cint]] = [
    (name: "EQNPOS_NONE", cEnum: eqnPost_EQNPOS_NONE,
     cName: "eqn_post::EQNPOS_NONE", value: cint(0)),
    (name: "EQNPOS_SUP", cEnum: eqnPost_EQNPOS_SUP,
     cName: "eqn_post::EQNPOS_SUP", value: cint(1)),
    (name: "EQNPOS_SUBSUP", cEnum: eqnPost_EQNPOS_SUBSUP,
     cName: "eqn_post::EQNPOS_SUBSUP", value: cint(2)),
    (name: "EQNPOS_SUB", cEnum: eqnPost_EQNPOS_SUB,
     cName: "eqn_post::EQNPOS_SUB", value: cint(3)),
    (name: "EQNPOS_TO", cEnum: eqnPost_EQNPOS_TO, cName: "eqn_post::EQNPOS_TO",
     value: cint(4)),
    (name: "EQNPOS_FROM", cEnum: eqnPost_EQNPOS_FROM,
     cName: "eqn_post::EQNPOS_FROM", value: cint(5)),
    (name: "EQNPOS_FROMTO", cEnum: eqnPost_EQNPOS_FROMTO,
     cName: "eqn_post::EQNPOS_FROMTO", value: cint(6)),
    (name: "EQNPOS_OVER", cEnum: eqnPost_EQNPOS_OVER,
     cName: "eqn_post::EQNPOS_OVER", value: cint(7)),
    (name: "EQNPOS_SQRT", cEnum: eqnPost_EQNPOS_SQRT,
     cName: "eqn_post::EQNPOS_SQRT", value: cint(8)),
    (name: "EQNPOS__MAX", cEnum: eqnPost_EQNPOS_MAX,
     cName: "eqn_post::EQNPOS__MAX", value: cint(9))]
proc toCInt*(en: EqnPost): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrEqnPostmapping[en].value

proc toCInt*(en: set[EqnPost]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrEqnPostmapping[val].value)

proc `$`*(en: EqnPostC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of eqnPost_EQNPOS_NONE:
    result = "eqn_post::EQNPOS_NONE"
  of eqnPost_EQNPOS_SUP:
    result = "eqn_post::EQNPOS_SUP"
  of eqnPost_EQNPOS_SUBSUP:
    result = "eqn_post::EQNPOS_SUBSUP"
  of eqnPost_EQNPOS_SUB:
    result = "eqn_post::EQNPOS_SUB"
  of eqnPost_EQNPOS_TO:
    result = "eqn_post::EQNPOS_TO"
  of eqnPost_EQNPOS_FROM:
    result = "eqn_post::EQNPOS_FROM"
  of eqnPost_EQNPOS_FROMTO:
    result = "eqn_post::EQNPOS_FROMTO"
  of eqnPost_EQNPOS_OVER:
    result = "eqn_post::EQNPOS_OVER"
  of eqnPost_EQNPOS_SQRT:
    result = "eqn_post::EQNPOS_SQRT"
  of eqnPost_EQNPOS_MAX:
    result = "eqn_post::EQNPOS__MAX"
  
func toEqnPost*(en: EqnPostC): EqnPost {.inline.} =
  case en
  of eqnPost_EQNPOS_NONE:
    epNone
  of eqnPost_EQNPOS_SUP:
    epSup
  of eqnPost_EQNPOS_SUBSUP:
    epSubsup
  of eqnPost_EQNPOS_SUB:
    epSub
  of eqnPost_EQNPOS_TO:
    epTo
  of eqnPost_EQNPOS_FROM:
    epFrom
  of eqnPost_EQNPOS_FROMTO:
    epFromto
  of eqnPost_EQNPOS_OVER:
    epOver
  of eqnPost_EQNPOS_SQRT:
    epSqrt
  of eqnPost_EQNPOS_MAX:
    epMax
  
converter toEqnPostC*(en: EqnPost): EqnPostC {.inline.} =
  arrEqnPostmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `eqn_box`
# Declared in eqn.h:54
proc cnewEqnBox*(): ptr EqnBox {.importc: r"new eqn_box()", header: allHeaders.}
  ## @import{[[code:struct!eqn_box]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `eqn_box`
# Declared in eqn.h:54
proc destroyEqnBox*(obj: ptr EqnBox): void {.importc: r"#.~eqn_box()",
    header: allHeaders.}
  ## @import{[[code:struct!eqn_box]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `eqn_box`
# Declared in eqn.h:54
proc newEqnBox*(): ref EqnBox =
  ## @import{[[code:struct!eqn_box]]}
  newImportAux()
  new(result, proc (destr: ref EqnBox) =
    destroyEqnBox(addr destr[]))
  {.emit: "new ((void*)result) eqn_box(); /* Placement new */".}


