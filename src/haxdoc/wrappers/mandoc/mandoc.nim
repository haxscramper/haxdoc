
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / stddef, file, hmisc / wrappers / wraphelp



export
  wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(1258, 42)
  MaAscii* = enum
    maBreak = 29,             ## @import{[[code:cmacro!tkInvalid]]}
    maHyph = 30                ## @import{[[code:cmacro!tkInvalid]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mandoclevel`
  # Declared in mandoc.h:31
  MandoclevelC* {.importc: "enum mandoclevel", header: allHeaders.} = enum ## @import{[[code:enum!mandoclevel]]}
    mandoclevel_MANDOCLEVEL_OK = 0, mandoclevel_MANDOCLEVEL_STYLE = 1,
    mandoclevel_MANDOCLEVEL_WARNING = 2, mandoclevel_MANDOCLEVEL_ERROR = 3,
    mandoclevel_MANDOCLEVEL_UNSUPP = 4, mandoclevel_MANDOCLEVEL_BADARG = 5,
    mandoclevel_MANDOCLEVEL_SYSERR = 6, mandoclevel_MANDOCLEVEL_MAX = 7



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mandocerr`
  # Declared in mandoc.h:46
  MandocerrC* {.importc: "enum mandocerr", header: allHeaders.} = enum ## @import{[[code:enum!mandocerr]]}
    mandocerr_MANDOCERR_OK = 0, mandocerr_MANDOCERR_BASE = 1,
    mandocerr_MANDOCERR_MDOCDATE = 2, mandocerr_MANDOCERR_MDOCDATE_MISSING = 3,
    mandocerr_MANDOCERR_ARCH_BAD = 4, mandocerr_MANDOCERR_OS_ARG = 5,
    mandocerr_MANDOCERR_RCS_MISSING = 6, mandocerr_MANDOCERR_XR_BAD = 7,
    mandocerr_MANDOCERR_STYLE = 8, mandocerr_MANDOCERR_DATE_LEGACY = 9,
    mandocerr_MANDOCERR_DATE_NORM = 10, mandocerr_MANDOCERR_TITLE_CASE = 11,
    mandocerr_MANDOCERR_RCS_REP = 12, mandocerr_MANDOCERR_SEC_TYPO = 13,
    mandocerr_MANDOCERR_ARG_QUOTE = 14, mandocerr_MANDOCERR_MACRO_USELESS = 15,
    mandocerr_MANDOCERR_BX = 16, mandocerr_MANDOCERR_ER_ORDER = 17,
    mandocerr_MANDOCERR_ER_REP = 18, mandocerr_MANDOCERR_DELIM = 19,
    mandocerr_MANDOCERR_DELIM_NB = 20, mandocerr_MANDOCERR_FI_SKIP = 21,
    mandocerr_MANDOCERR_NF_SKIP = 22, mandocerr_MANDOCERR_DASHDASH = 23,
    mandocerr_MANDOCERR_FUNC = 24, mandocerr_MANDOCERR_SPACE_EOL = 25,
    mandocerr_MANDOCERR_COMMENT_BAD = 26, mandocerr_MANDOCERR_WARNING = 27,
    mandocerr_MANDOCERR_DT_NOTITLE = 28, mandocerr_MANDOCERR_TH_NOTITLE = 29,
    mandocerr_MANDOCERR_MSEC_MISSING = 30, mandocerr_MANDOCERR_MSEC_BAD = 31,
    mandocerr_MANDOCERR_DATE_MISSING = 32, mandocerr_MANDOCERR_DATE_BAD = 33,
    mandocerr_MANDOCERR_DATE_FUTURE = 34, mandocerr_MANDOCERR_OS_MISSING = 35,
    mandocerr_MANDOCERR_PROLOG_LATE = 36, mandocerr_MANDOCERR_PROLOG_ORDER = 37,
    mandocerr_MANDOCERR_SO = 38, mandocerr_MANDOCERR_DOC_EMPTY = 39,
    mandocerr_MANDOCERR_SEC_BEFORE = 40, mandocerr_MANDOCERR_NAMESEC_FIRST = 41,
    mandocerr_MANDOCERR_NAMESEC_NONM = 42, mandocerr_MANDOCERR_NAMESEC_NOND = 43,
    mandocerr_MANDOCERR_NAMESEC_ND = 44, mandocerr_MANDOCERR_NAMESEC_BAD = 45,
    mandocerr_MANDOCERR_NAMESEC_PUNCT = 46, mandocerr_MANDOCERR_ND_EMPTY = 47,
    mandocerr_MANDOCERR_ND_LATE = 48, mandocerr_MANDOCERR_SEC_ORDER = 49,
    mandocerr_MANDOCERR_SEC_REP = 50, mandocerr_MANDOCERR_SEC_MSEC = 51,
    mandocerr_MANDOCERR_XR_SELF = 52, mandocerr_MANDOCERR_XR_ORDER = 53,
    mandocerr_MANDOCERR_XR_PUNCT = 54, mandocerr_MANDOCERR_AN_MISSING = 55,
    mandocerr_MANDOCERR_MACRO_OBS = 56, mandocerr_MANDOCERR_MACRO_CALL = 57,
    mandocerr_MANDOCERR_PAR_SKIP = 58, mandocerr_MANDOCERR_PAR_MOVE = 59,
    mandocerr_MANDOCERR_NS_SKIP = 60, mandocerr_MANDOCERR_BLK_NEST = 61,
    mandocerr_MANDOCERR_BD_NEST = 62, mandocerr_MANDOCERR_BL_MOVE = 63,
    mandocerr_MANDOCERR_TA_LINE = 64, mandocerr_MANDOCERR_BLK_LINE = 65,
    mandocerr_MANDOCERR_BLK_BLANK = 66, mandocerr_MANDOCERR_REQ_EMPTY = 67,
    mandocerr_MANDOCERR_COND_EMPTY = 68, mandocerr_MANDOCERR_MACRO_EMPTY = 69,
    mandocerr_MANDOCERR_BLK_EMPTY = 70, mandocerr_MANDOCERR_ARG_EMPTY = 71,
    mandocerr_MANDOCERR_BD_NOTYPE = 72, mandocerr_MANDOCERR_BL_LATETYPE = 73,
    mandocerr_MANDOCERR_BL_NOWIDTH = 74, mandocerr_MANDOCERR_EX_NONAME = 75,
    mandocerr_MANDOCERR_FO_NOHEAD = 76, mandocerr_MANDOCERR_IT_NOHEAD = 77,
    mandocerr_MANDOCERR_IT_NOBODY = 78, mandocerr_MANDOCERR_IT_NOARG = 79,
    mandocerr_MANDOCERR_BF_NOFONT = 80, mandocerr_MANDOCERR_BF_BADFONT = 81,
    mandocerr_MANDOCERR_PF_SKIP = 82, mandocerr_MANDOCERR_RS_EMPTY = 83,
    mandocerr_MANDOCERR_XR_NOSEC = 84, mandocerr_MANDOCERR_ARG_STD = 85,
    mandocerr_MANDOCERR_OP_EMPTY = 86, mandocerr_MANDOCERR_UR_NOHEAD = 87,
    mandocerr_MANDOCERR_EQN_NOBOX = 88, mandocerr_MANDOCERR_ARG_REP = 89,
    mandocerr_MANDOCERR_AN_REP = 90, mandocerr_MANDOCERR_BD_REP = 91,
    mandocerr_MANDOCERR_BL_REP = 92, mandocerr_MANDOCERR_BL_SKIPW = 93,
    mandocerr_MANDOCERR_BL_COL = 94, mandocerr_MANDOCERR_AT_BAD = 95,
    mandocerr_MANDOCERR_FA_COMMA = 96, mandocerr_MANDOCERR_FN_PAREN = 97,
    mandocerr_MANDOCERR_LB_BAD = 98, mandocerr_MANDOCERR_RS_BAD = 99,
    mandocerr_MANDOCERR_SM_BAD = 100, mandocerr_MANDOCERR_CHAR_FONT = 101,
    mandocerr_MANDOCERR_FT_BAD = 102, mandocerr_MANDOCERR_TR_ODD = 103,
    mandocerr_MANDOCERR_FI_BLANK = 104, mandocerr_MANDOCERR_FI_TAB = 105,
    mandocerr_MANDOCERR_EOS = 106, mandocerr_MANDOCERR_ESC_BAD = 107,
    mandocerr_MANDOCERR_ESC_UNDEF = 108, mandocerr_MANDOCERR_STR_UNDEF = 109,
    mandocerr_MANDOCERR_TBLLAYOUT_SPAN = 110,
    mandocerr_MANDOCERR_TBLLAYOUT_DOWN = 111,
    mandocerr_MANDOCERR_TBLLAYOUT_VERT = 112, mandocerr_MANDOCERR_ERROR = 113,
    mandocerr_MANDOCERR_TBLOPT_ALPHA = 114, mandocerr_MANDOCERR_TBLOPT_BAD = 115,
    mandocerr_MANDOCERR_TBLOPT_NOARG = 116,
    mandocerr_MANDOCERR_TBLOPT_ARGSZ = 117,
    mandocerr_MANDOCERR_TBLLAYOUT_NONE = 118,
    mandocerr_MANDOCERR_TBLLAYOUT_CHAR = 119,
    mandocerr_MANDOCERR_TBLLAYOUT_PAR = 120,
    mandocerr_MANDOCERR_TBLDATA_NONE = 121,
    mandocerr_MANDOCERR_TBLDATA_SPAN = 122,
    mandocerr_MANDOCERR_TBLDATA_EXTRA = 123,
    mandocerr_MANDOCERR_TBLDATA_BLK = 124, mandocerr_MANDOCERR_FILE = 125,
    mandocerr_MANDOCERR_PROLOG_REP = 126, mandocerr_MANDOCERR_DT_LATE = 127,
    mandocerr_MANDOCERR_ROFFLOOP = 128, mandocerr_MANDOCERR_CHAR_BAD = 129,
    mandocerr_MANDOCERR_MACRO = 130, mandocerr_MANDOCERR_REQ_NOMAC = 131,
    mandocerr_MANDOCERR_REQ_INSEC = 132, mandocerr_MANDOCERR_IT_STRAY = 133,
    mandocerr_MANDOCERR_TA_STRAY = 134, mandocerr_MANDOCERR_BLK_NOTOPEN = 135,
    mandocerr_MANDOCERR_RE_NOTOPEN = 136, mandocerr_MANDOCERR_BLK_BROKEN = 137,
    mandocerr_MANDOCERR_BLK_NOEND = 138, mandocerr_MANDOCERR_NAMESC = 139,
    mandocerr_MANDOCERR_ARG_UNDEF = 140, mandocerr_MANDOCERR_ARG_NONUM = 141,
    mandocerr_MANDOCERR_BD_FILE = 142, mandocerr_MANDOCERR_BD_NOARG = 143,
    mandocerr_MANDOCERR_BL_NOTYPE = 144, mandocerr_MANDOCERR_CE_NONUM = 145,
    mandocerr_MANDOCERR_CHAR_ARG = 146, mandocerr_MANDOCERR_NM_NONAME = 147,
    mandocerr_MANDOCERR_OS_UNAME = 148, mandocerr_MANDOCERR_ST_BAD = 149,
    mandocerr_MANDOCERR_IT_NONUM = 150, mandocerr_MANDOCERR_SHIFT = 151,
    mandocerr_MANDOCERR_SO_PATH = 152, mandocerr_MANDOCERR_SO_FAIL = 153,
    mandocerr_MANDOCERR_ARG_SKIP = 154, mandocerr_MANDOCERR_ARG_EXCESS = 155,
    mandocerr_MANDOCERR_DIVZERO = 156, mandocerr_MANDOCERR_UNSUPP = 157,
    mandocerr_MANDOCERR_TOOLARGE = 158, mandocerr_MANDOCERR_CHAR_UNSUPP = 159,
    mandocerr_MANDOCERR_ESC_UNSUPP = 160, mandocerr_MANDOCERR_REQ_UNSUPP = 161,
    mandocerr_MANDOCERR_WHILE_NEST = 162, mandocerr_MANDOCERR_WHILE_OUTOF = 163,
    mandocerr_MANDOCERR_WHILE_INTO = 164, mandocerr_MANDOCERR_WHILE_FAIL = 165,
    mandocerr_MANDOCERR_TBLOPT_EQN = 166, mandocerr_MANDOCERR_TBLLAYOUT_MOD = 167,
    mandocerr_MANDOCERR_TBLMACRO = 168, mandocerr_MANDOCERR_MAX = 169



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  Mandoclevel* = enum
    mlOk,                     ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_OK]]}
    mlStyle,                  ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_STYLE]]}
    mlWarning,                ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_WARNING]]}
    mlError,                  ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_ERROR]]}
    mlUnsupp,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_UNSUPP]]}
    mlBadarg,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_BADARG]]}
    mlSyserr,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_SYSERR]]}
    mlMax                      ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_MAX]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  Mandocerr* = enum
    meOk,                     ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_OK]]}
    meBase,                   ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BASE]]}
    meMdocdate,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MDOCDATE]]}
    meMdocdateMissing,        ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MDOCDATE_MISSING]]}
    meArchBad,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARCH_BAD]]}
    meOsArg,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_OS_ARG]]}
    meRcsMissing,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_RCS_MISSING]]}
    meXrBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_XR_BAD]]}
    meStyle,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_STYLE]]}
    meDateLegacy,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DATE_LEGACY]]}
    meDateNorm,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DATE_NORM]]}
    meTitleCase,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TITLE_CASE]]}
    meRcsRep,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_RCS_REP]]}
    meSecTypo,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SEC_TYPO]]}
    meArgQuote,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_QUOTE]]}
    meMacroUseless,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MACRO_USELESS]]}
    meBx,                     ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BX]]}
    meErOrder,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ER_ORDER]]}
    meErRep,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ER_REP]]}
    meDelim,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DELIM]]}
    meDelimNb,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DELIM_NB]]}
    meFiSkip,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FI_SKIP]]}
    meNfSkip,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NF_SKIP]]}
    meDashdash,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DASHDASH]]}
    meFunc,                   ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FUNC]]}
    meSpaceEol,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SPACE_EOL]]}
    meCommentBad,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_COMMENT_BAD]]}
    meWarning,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_WARNING]]}
    meDtNotitle,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DT_NOTITLE]]}
    meThNotitle,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TH_NOTITLE]]}
    meMsecMissing,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MSEC_MISSING]]}
    meMsecBad,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MSEC_BAD]]}
    meDateMissing,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DATE_MISSING]]}
    meDateBad,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DATE_BAD]]}
    meDateFuture,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DATE_FUTURE]]}
    meOsMissing,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_OS_MISSING]]}
    mePrologLate,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PROLOG_LATE]]}
    mePrologOrder,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PROLOG_ORDER]]}
    meSo,                     ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SO]]}
    meDocEmpty,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DOC_EMPTY]]}
    meSecBefore,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SEC_BEFORE]]}
    meNamesecFirst,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_FIRST]]}
    meNamesecNonm,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_NONM]]}
    meNamesecNond,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_NOND]]}
    meNamesecNd,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_ND]]}
    meNamesecBad,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_BAD]]}
    meNamesecPunct,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESEC_PUNCT]]}
    meNdEmpty,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ND_EMPTY]]}
    meNdLate,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ND_LATE]]}
    meSecOrder,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SEC_ORDER]]}
    meSecRep,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SEC_REP]]}
    meSecMsec,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SEC_MSEC]]}
    meXrSelf,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_XR_SELF]]}
    meXrOrder,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_XR_ORDER]]}
    meXrPunct,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_XR_PUNCT]]}
    meAnMissing,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_AN_MISSING]]}
    meMacroObs,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MACRO_OBS]]}
    meMacroCall,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MACRO_CALL]]}
    meParSkip,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PAR_SKIP]]}
    meParMove,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PAR_MOVE]]}
    meNsSkip,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NS_SKIP]]}
    meBlkNest,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_NEST]]}
    meBdNest,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BD_NEST]]}
    meBlMove,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_MOVE]]}
    meTaLine,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TA_LINE]]}
    meBlkLine,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_LINE]]}
    meBlkBlank,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_BLANK]]}
    meReqEmpty,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_REQ_EMPTY]]}
    meCondEmpty,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_COND_EMPTY]]}
    meMacroEmpty,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MACRO_EMPTY]]}
    meBlkEmpty,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_EMPTY]]}
    meArgEmpty,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_EMPTY]]}
    meBdNotype,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BD_NOTYPE]]}
    meBlLatetype,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_LATETYPE]]}
    meBlNowidth,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_NOWIDTH]]}
    meExNoname,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_EX_NONAME]]}
    meFoNohead,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FO_NOHEAD]]}
    meItNohead,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_IT_NOHEAD]]}
    meItNobody,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_IT_NOBODY]]}
    meItNoarg,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_IT_NOARG]]}
    meBfNofont,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BF_NOFONT]]}
    meBfBadfont,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BF_BADFONT]]}
    mePfSkip,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PF_SKIP]]}
    meRsEmpty,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_RS_EMPTY]]}
    meXrNosec,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_XR_NOSEC]]}
    meArgStd,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_STD]]}
    meOpEmpty,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_OP_EMPTY]]}
    meUrNohead,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_UR_NOHEAD]]}
    meEqnNobox,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_EQN_NOBOX]]}
    meArgRep,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_REP]]}
    meAnRep,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_AN_REP]]}
    meBdRep,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BD_REP]]}
    meBlRep,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_REP]]}
    meBlSkipw,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_SKIPW]]}
    meBlCol,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_COL]]}
    meAtBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_AT_BAD]]}
    meFaComma,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FA_COMMA]]}
    meFnParen,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FN_PAREN]]}
    meLbBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_LB_BAD]]}
    meRsBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_RS_BAD]]}
    meSmBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SM_BAD]]}
    meCharFont,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_CHAR_FONT]]}
    meFtBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FT_BAD]]}
    meTrOdd,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TR_ODD]]}
    meFiBlank,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FI_BLANK]]}
    meFiTab,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FI_TAB]]}
    meEos,                    ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_EOS]]}
    meEscBad,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ESC_BAD]]}
    meEscUndef,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ESC_UNDEF]]}
    meStrUndef,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_STR_UNDEF]]}
    meTbllayoutSpan,          ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_SPAN]]}
    meTbllayoutDown,          ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_DOWN]]}
    meTbllayoutVert,          ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_VERT]]}
    meError,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ERROR]]}
    meTbloptAlpha,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLOPT_ALPHA]]}
    meTbloptBad,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLOPT_BAD]]}
    meTbloptNoarg,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLOPT_NOARG]]}
    meTbloptArgsz,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLOPT_ARGSZ]]}
    meTbllayoutNone,          ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_NONE]]}
    meTbllayoutChar,          ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_CHAR]]}
    meTbllayoutPar,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_PAR]]}
    meTbldataNone,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLDATA_NONE]]}
    meTbldataSpan,            ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLDATA_SPAN]]}
    meTbldataExtra,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLDATA_EXTRA]]}
    meTbldataBlk,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLDATA_BLK]]}
    meFile,                   ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_FILE]]}
    mePrologRep,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_PROLOG_REP]]}
    meDtLate,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DT_LATE]]}
    meRoffloop,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ROFFLOOP]]}
    meCharBad,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_CHAR_BAD]]}
    meMacro,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MACRO]]}
    meReqNomac,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_REQ_NOMAC]]}
    meReqInsec,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_REQ_INSEC]]}
    meItStray,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_IT_STRAY]]}
    meTaStray,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TA_STRAY]]}
    meBlkNotopen,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_NOTOPEN]]}
    meReNotopen,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_RE_NOTOPEN]]}
    meBlkBroken,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_BROKEN]]}
    meBlkNoend,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BLK_NOEND]]}
    meNamesc,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NAMESC]]}
    meArgUndef,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_UNDEF]]}
    meArgNonum,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_NONUM]]}
    meBdFile,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BD_FILE]]}
    meBdNoarg,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BD_NOARG]]}
    meBlNotype,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_BL_NOTYPE]]}
    meCeNonum,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_CE_NONUM]]}
    meCharArg,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_CHAR_ARG]]}
    meNmNoname,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_NM_NONAME]]}
    meOsUname,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_OS_UNAME]]}
    meStBad,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ST_BAD]]}
    meItNonum,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_IT_NONUM]]}
    meShift,                  ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SHIFT]]}
    meSoPath,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SO_PATH]]}
    meSoFail,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_SO_FAIL]]}
    meArgSkip,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_SKIP]]}
    meArgExcess,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ARG_EXCESS]]}
    meDivzero,                ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_DIVZERO]]}
    meUnsupp,                 ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_UNSUPP]]}
    meToolarge,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TOOLARGE]]}
    meCharUnsupp,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_CHAR_UNSUPP]]}
    meEscUnsupp,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_ESC_UNSUPP]]}
    meReqUnsupp,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_REQ_UNSUPP]]}
    meWhileNest,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_WHILE_NEST]]}
    meWhileOutof,             ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_WHILE_OUTOF]]}
    meWhileInto,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_WHILE_INTO]]}
    meWhileFail,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_WHILE_FAIL]]}
    meTbloptEqn,              ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLOPT_EQN]]}
    meTbllayoutMod,           ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLLAYOUT_MOD]]}
    meTblmacro,               ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_TBLMACRO]]}
    meMax                      ## @import{[[code:enum!mandocerr.enumField!MANDOCERR_MAX]]}



  # Declaration created in: hc_wrapgen.nim(1299, 44)
  MandocEsc* = enum
    mscError,                 ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_ERROR]]}
    mscUnsupp,                ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_UNSUPP]]}
    mscIgnore,                ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_IGNORE]]}
    mscUndef,                 ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_UNDEF]]}
    mscSpecial,               ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_SPECIAL]]}
    mscFont,                  ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONT]]}
    mscFontbold,              ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTBOLD]]}
    mscFontitalic,            ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTITALIC]]}
    mscFontbi,                ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTBI]]}
    mscFontroman,             ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTROMAN]]}
    mscFontcw,                ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTCW]]}
    mscFontprev,              ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_FONTPREV]]}
    mscNumbered,              ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_NUMBERED]]}
    mscUnicode,               ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_UNICODE]]}
    mscDevice,                ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_DEVICE]]}
    mscBreak,                 ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_BREAK]]}
    mscNospace,               ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_NOSPACE]]}
    mscHoriz,                 ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_HORIZ]]}
    mscHline,                 ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_HLINE]]}
    mscSkipchar,              ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_SKIPCHAR]]}
    mscOverstrike              ## @import{[[code:enum!mandoc_esc.enumField!ESCAPE_OVERSTRIKE]]}



  # Declaration created in: hc_wrapgen.nim(1287, 44)
  # Wrapper for `mandoc_esc`
  # Declared in mandoc.h:248
  MandocEscC* {.importc: "enum mandoc_esc", header: allHeaders.} = enum ## @import{[[code:enum!mandoc_esc]]}
    mandocEsc_ESCAPE_ERROR = 0, mandocEsc_ESCAPE_UNSUPP = 1,
    mandocEsc_ESCAPE_IGNORE = 2, mandocEsc_ESCAPE_UNDEF = 3,
    mandocEsc_ESCAPE_SPECIAL = 4, mandocEsc_ESCAPE_FONT = 5,
    mandocEsc_ESCAPE_FONTBOLD = 6, mandocEsc_ESCAPE_FONTITALIC = 7,
    mandocEsc_ESCAPE_FONTBI = 8, mandocEsc_ESCAPE_FONTROMAN = 9,
    mandocEsc_ESCAPE_FONTCW = 10, mandocEsc_ESCAPE_FONTPREV = 11,
    mandocEsc_ESCAPE_NUMBERED = 12, mandocEsc_ESCAPE_UNICODE = 13,
    mandocEsc_ESCAPE_DEVICE = 14, mandocEsc_ESCAPE_BREAK = 15,
    mandocEsc_ESCAPE_NOSPACE = 16, mandocEsc_ESCAPE_HORIZ = 17,
    mandocEsc_ESCAPE_HLINE = 18, mandocEsc_ESCAPE_SKIPCHAR = 19,
    mandocEsc_ESCAPE_OVERSTRIKE = 20




const
  arrMandoclevelmapping: array[Mandoclevel, tuple[name: string,
      cEnum: MandoclevelC, cName: string, value: cint]] = [
    (name: "MANDOCLEVEL_OK", cEnum: mandoclevel_MANDOCLEVEL_OK,
     cName: "mandoclevel::MANDOCLEVEL_OK", value: cint(0)),
    (name: "MANDOCLEVEL_STYLE", cEnum: mandoclevel_MANDOCLEVEL_STYLE,
     cName: "mandoclevel::MANDOCLEVEL_STYLE", value: cint(1)),
    (name: "MANDOCLEVEL_WARNING", cEnum: mandoclevel_MANDOCLEVEL_WARNING,
     cName: "mandoclevel::MANDOCLEVEL_WARNING", value: cint(2)),
    (name: "MANDOCLEVEL_ERROR", cEnum: mandoclevel_MANDOCLEVEL_ERROR,
     cName: "mandoclevel::MANDOCLEVEL_ERROR", value: cint(3)),
    (name: "MANDOCLEVEL_UNSUPP", cEnum: mandoclevel_MANDOCLEVEL_UNSUPP,
     cName: "mandoclevel::MANDOCLEVEL_UNSUPP", value: cint(4)),
    (name: "MANDOCLEVEL_BADARG", cEnum: mandoclevel_MANDOCLEVEL_BADARG,
     cName: "mandoclevel::MANDOCLEVEL_BADARG", value: cint(5)),
    (name: "MANDOCLEVEL_SYSERR", cEnum: mandoclevel_MANDOCLEVEL_SYSERR,
     cName: "mandoclevel::MANDOCLEVEL_SYSERR", value: cint(6)),
    (name: "MANDOCLEVEL_MAX", cEnum: mandoclevel_MANDOCLEVEL_MAX,
     cName: "mandoclevel::MANDOCLEVEL_MAX", value: cint(7))]
proc toCInt*(en: Mandoclevel): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMandoclevelmapping[en].value

proc toCInt*(en: set[Mandoclevel]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMandoclevelmapping[val].value)

proc `$`*(en: MandoclevelC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mandoclevel_MANDOCLEVEL_OK:
    result = "mandoclevel::MANDOCLEVEL_OK"
  of mandoclevel_MANDOCLEVEL_STYLE:
    result = "mandoclevel::MANDOCLEVEL_STYLE"
  of mandoclevel_MANDOCLEVEL_WARNING:
    result = "mandoclevel::MANDOCLEVEL_WARNING"
  of mandoclevel_MANDOCLEVEL_ERROR:
    result = "mandoclevel::MANDOCLEVEL_ERROR"
  of mandoclevel_MANDOCLEVEL_UNSUPP:
    result = "mandoclevel::MANDOCLEVEL_UNSUPP"
  of mandoclevel_MANDOCLEVEL_BADARG:
    result = "mandoclevel::MANDOCLEVEL_BADARG"
  of mandoclevel_MANDOCLEVEL_SYSERR:
    result = "mandoclevel::MANDOCLEVEL_SYSERR"
  of mandoclevel_MANDOCLEVEL_MAX:
    result = "mandoclevel::MANDOCLEVEL_MAX"
  
func toMandoclevel*(en: MandoclevelC): Mandoclevel {.inline.} =
  case en
  of mandoclevel_MANDOCLEVEL_OK:
    mlOk
  of mandoclevel_MANDOCLEVEL_STYLE:
    mlStyle
  of mandoclevel_MANDOCLEVEL_WARNING:
    mlWarning
  of mandoclevel_MANDOCLEVEL_ERROR:
    mlError
  of mandoclevel_MANDOCLEVEL_UNSUPP:
    mlUnsupp
  of mandoclevel_MANDOCLEVEL_BADARG:
    mlBadarg
  of mandoclevel_MANDOCLEVEL_SYSERR:
    mlSyserr
  of mandoclevel_MANDOCLEVEL_MAX:
    mlMax
  
converter toMandoclevelC*(en: Mandoclevel): MandoclevelC {.inline.} =
  arrMandoclevelmapping[en].cEnum




const
  arrMandocerrmapping: array[Mandocerr, tuple[name: string, cEnum: MandocerrC,
      cName: string, value: cint]] = [
    (name: "MANDOCERR_OK", cEnum: mandocerr_MANDOCERR_OK,
     cName: "mandocerr::MANDOCERR_OK", value: cint(0)),
    (name: "MANDOCERR_BASE", cEnum: mandocerr_MANDOCERR_BASE,
     cName: "mandocerr::MANDOCERR_BASE", value: cint(1)),
    (name: "MANDOCERR_MDOCDATE", cEnum: mandocerr_MANDOCERR_MDOCDATE,
     cName: "mandocerr::MANDOCERR_MDOCDATE", value: cint(2)),
    (name: "MANDOCERR_MDOCDATE_MISSING",
     cEnum: mandocerr_MANDOCERR_MDOCDATE_MISSING,
     cName: "mandocerr::MANDOCERR_MDOCDATE_MISSING", value: cint(3)),
    (name: "MANDOCERR_ARCH_BAD", cEnum: mandocerr_MANDOCERR_ARCH_BAD,
     cName: "mandocerr::MANDOCERR_ARCH_BAD", value: cint(4)),
    (name: "MANDOCERR_OS_ARG", cEnum: mandocerr_MANDOCERR_OS_ARG,
     cName: "mandocerr::MANDOCERR_OS_ARG", value: cint(5)),
    (name: "MANDOCERR_RCS_MISSING", cEnum: mandocerr_MANDOCERR_RCS_MISSING,
     cName: "mandocerr::MANDOCERR_RCS_MISSING", value: cint(6)),
    (name: "MANDOCERR_XR_BAD", cEnum: mandocerr_MANDOCERR_XR_BAD,
     cName: "mandocerr::MANDOCERR_XR_BAD", value: cint(7)),
    (name: "MANDOCERR_STYLE", cEnum: mandocerr_MANDOCERR_STYLE,
     cName: "mandocerr::MANDOCERR_STYLE", value: cint(8)),
    (name: "MANDOCERR_DATE_LEGACY", cEnum: mandocerr_MANDOCERR_DATE_LEGACY,
     cName: "mandocerr::MANDOCERR_DATE_LEGACY", value: cint(9)),
    (name: "MANDOCERR_DATE_NORM", cEnum: mandocerr_MANDOCERR_DATE_NORM,
     cName: "mandocerr::MANDOCERR_DATE_NORM", value: cint(10)),
    (name: "MANDOCERR_TITLE_CASE", cEnum: mandocerr_MANDOCERR_TITLE_CASE,
     cName: "mandocerr::MANDOCERR_TITLE_CASE", value: cint(11)),
    (name: "MANDOCERR_RCS_REP", cEnum: mandocerr_MANDOCERR_RCS_REP,
     cName: "mandocerr::MANDOCERR_RCS_REP", value: cint(12)),
    (name: "MANDOCERR_SEC_TYPO", cEnum: mandocerr_MANDOCERR_SEC_TYPO,
     cName: "mandocerr::MANDOCERR_SEC_TYPO", value: cint(13)),
    (name: "MANDOCERR_ARG_QUOTE", cEnum: mandocerr_MANDOCERR_ARG_QUOTE,
     cName: "mandocerr::MANDOCERR_ARG_QUOTE", value: cint(14)),
    (name: "MANDOCERR_MACRO_USELESS", cEnum: mandocerr_MANDOCERR_MACRO_USELESS,
     cName: "mandocerr::MANDOCERR_MACRO_USELESS", value: cint(15)),
    (name: "MANDOCERR_BX", cEnum: mandocerr_MANDOCERR_BX,
     cName: "mandocerr::MANDOCERR_BX", value: cint(16)),
    (name: "MANDOCERR_ER_ORDER", cEnum: mandocerr_MANDOCERR_ER_ORDER,
     cName: "mandocerr::MANDOCERR_ER_ORDER", value: cint(17)),
    (name: "MANDOCERR_ER_REP", cEnum: mandocerr_MANDOCERR_ER_REP,
     cName: "mandocerr::MANDOCERR_ER_REP", value: cint(18)),
    (name: "MANDOCERR_DELIM", cEnum: mandocerr_MANDOCERR_DELIM,
     cName: "mandocerr::MANDOCERR_DELIM", value: cint(19)),
    (name: "MANDOCERR_DELIM_NB", cEnum: mandocerr_MANDOCERR_DELIM_NB,
     cName: "mandocerr::MANDOCERR_DELIM_NB", value: cint(20)),
    (name: "MANDOCERR_FI_SKIP", cEnum: mandocerr_MANDOCERR_FI_SKIP,
     cName: "mandocerr::MANDOCERR_FI_SKIP", value: cint(21)),
    (name: "MANDOCERR_NF_SKIP", cEnum: mandocerr_MANDOCERR_NF_SKIP,
     cName: "mandocerr::MANDOCERR_NF_SKIP", value: cint(22)),
    (name: "MANDOCERR_DASHDASH", cEnum: mandocerr_MANDOCERR_DASHDASH,
     cName: "mandocerr::MANDOCERR_DASHDASH", value: cint(23)),
    (name: "MANDOCERR_FUNC", cEnum: mandocerr_MANDOCERR_FUNC,
     cName: "mandocerr::MANDOCERR_FUNC", value: cint(24)),
    (name: "MANDOCERR_SPACE_EOL", cEnum: mandocerr_MANDOCERR_SPACE_EOL,
     cName: "mandocerr::MANDOCERR_SPACE_EOL", value: cint(25)),
    (name: "MANDOCERR_COMMENT_BAD", cEnum: mandocerr_MANDOCERR_COMMENT_BAD,
     cName: "mandocerr::MANDOCERR_COMMENT_BAD", value: cint(26)),
    (name: "MANDOCERR_WARNING", cEnum: mandocerr_MANDOCERR_WARNING,
     cName: "mandocerr::MANDOCERR_WARNING", value: cint(27)),
    (name: "MANDOCERR_DT_NOTITLE", cEnum: mandocerr_MANDOCERR_DT_NOTITLE,
     cName: "mandocerr::MANDOCERR_DT_NOTITLE", value: cint(28)),
    (name: "MANDOCERR_TH_NOTITLE", cEnum: mandocerr_MANDOCERR_TH_NOTITLE,
     cName: "mandocerr::MANDOCERR_TH_NOTITLE", value: cint(29)),
    (name: "MANDOCERR_MSEC_MISSING", cEnum: mandocerr_MANDOCERR_MSEC_MISSING,
     cName: "mandocerr::MANDOCERR_MSEC_MISSING", value: cint(30)),
    (name: "MANDOCERR_MSEC_BAD", cEnum: mandocerr_MANDOCERR_MSEC_BAD,
     cName: "mandocerr::MANDOCERR_MSEC_BAD", value: cint(31)),
    (name: "MANDOCERR_DATE_MISSING", cEnum: mandocerr_MANDOCERR_DATE_MISSING,
     cName: "mandocerr::MANDOCERR_DATE_MISSING", value: cint(32)),
    (name: "MANDOCERR_DATE_BAD", cEnum: mandocerr_MANDOCERR_DATE_BAD,
     cName: "mandocerr::MANDOCERR_DATE_BAD", value: cint(33)),
    (name: "MANDOCERR_DATE_FUTURE", cEnum: mandocerr_MANDOCERR_DATE_FUTURE,
     cName: "mandocerr::MANDOCERR_DATE_FUTURE", value: cint(34)),
    (name: "MANDOCERR_OS_MISSING", cEnum: mandocerr_MANDOCERR_OS_MISSING,
     cName: "mandocerr::MANDOCERR_OS_MISSING", value: cint(35)),
    (name: "MANDOCERR_PROLOG_LATE", cEnum: mandocerr_MANDOCERR_PROLOG_LATE,
     cName: "mandocerr::MANDOCERR_PROLOG_LATE", value: cint(36)),
    (name: "MANDOCERR_PROLOG_ORDER", cEnum: mandocerr_MANDOCERR_PROLOG_ORDER,
     cName: "mandocerr::MANDOCERR_PROLOG_ORDER", value: cint(37)),
    (name: "MANDOCERR_SO", cEnum: mandocerr_MANDOCERR_SO,
     cName: "mandocerr::MANDOCERR_SO", value: cint(38)),
    (name: "MANDOCERR_DOC_EMPTY", cEnum: mandocerr_MANDOCERR_DOC_EMPTY,
     cName: "mandocerr::MANDOCERR_DOC_EMPTY", value: cint(39)),
    (name: "MANDOCERR_SEC_BEFORE", cEnum: mandocerr_MANDOCERR_SEC_BEFORE,
     cName: "mandocerr::MANDOCERR_SEC_BEFORE", value: cint(40)),
    (name: "MANDOCERR_NAMESEC_FIRST", cEnum: mandocerr_MANDOCERR_NAMESEC_FIRST,
     cName: "mandocerr::MANDOCERR_NAMESEC_FIRST", value: cint(41)),
    (name: "MANDOCERR_NAMESEC_NONM", cEnum: mandocerr_MANDOCERR_NAMESEC_NONM,
     cName: "mandocerr::MANDOCERR_NAMESEC_NONM", value: cint(42)),
    (name: "MANDOCERR_NAMESEC_NOND", cEnum: mandocerr_MANDOCERR_NAMESEC_NOND,
     cName: "mandocerr::MANDOCERR_NAMESEC_NOND", value: cint(43)),
    (name: "MANDOCERR_NAMESEC_ND", cEnum: mandocerr_MANDOCERR_NAMESEC_ND,
     cName: "mandocerr::MANDOCERR_NAMESEC_ND", value: cint(44)),
    (name: "MANDOCERR_NAMESEC_BAD", cEnum: mandocerr_MANDOCERR_NAMESEC_BAD,
     cName: "mandocerr::MANDOCERR_NAMESEC_BAD", value: cint(45)),
    (name: "MANDOCERR_NAMESEC_PUNCT", cEnum: mandocerr_MANDOCERR_NAMESEC_PUNCT,
     cName: "mandocerr::MANDOCERR_NAMESEC_PUNCT", value: cint(46)),
    (name: "MANDOCERR_ND_EMPTY", cEnum: mandocerr_MANDOCERR_ND_EMPTY,
     cName: "mandocerr::MANDOCERR_ND_EMPTY", value: cint(47)),
    (name: "MANDOCERR_ND_LATE", cEnum: mandocerr_MANDOCERR_ND_LATE,
     cName: "mandocerr::MANDOCERR_ND_LATE", value: cint(48)),
    (name: "MANDOCERR_SEC_ORDER", cEnum: mandocerr_MANDOCERR_SEC_ORDER,
     cName: "mandocerr::MANDOCERR_SEC_ORDER", value: cint(49)),
    (name: "MANDOCERR_SEC_REP", cEnum: mandocerr_MANDOCERR_SEC_REP,
     cName: "mandocerr::MANDOCERR_SEC_REP", value: cint(50)),
    (name: "MANDOCERR_SEC_MSEC", cEnum: mandocerr_MANDOCERR_SEC_MSEC,
     cName: "mandocerr::MANDOCERR_SEC_MSEC", value: cint(51)),
    (name: "MANDOCERR_XR_SELF", cEnum: mandocerr_MANDOCERR_XR_SELF,
     cName: "mandocerr::MANDOCERR_XR_SELF", value: cint(52)),
    (name: "MANDOCERR_XR_ORDER", cEnum: mandocerr_MANDOCERR_XR_ORDER,
     cName: "mandocerr::MANDOCERR_XR_ORDER", value: cint(53)),
    (name: "MANDOCERR_XR_PUNCT", cEnum: mandocerr_MANDOCERR_XR_PUNCT,
     cName: "mandocerr::MANDOCERR_XR_PUNCT", value: cint(54)),
    (name: "MANDOCERR_AN_MISSING", cEnum: mandocerr_MANDOCERR_AN_MISSING,
     cName: "mandocerr::MANDOCERR_AN_MISSING", value: cint(55)),
    (name: "MANDOCERR_MACRO_OBS", cEnum: mandocerr_MANDOCERR_MACRO_OBS,
     cName: "mandocerr::MANDOCERR_MACRO_OBS", value: cint(56)),
    (name: "MANDOCERR_MACRO_CALL", cEnum: mandocerr_MANDOCERR_MACRO_CALL,
     cName: "mandocerr::MANDOCERR_MACRO_CALL", value: cint(57)),
    (name: "MANDOCERR_PAR_SKIP", cEnum: mandocerr_MANDOCERR_PAR_SKIP,
     cName: "mandocerr::MANDOCERR_PAR_SKIP", value: cint(58)),
    (name: "MANDOCERR_PAR_MOVE", cEnum: mandocerr_MANDOCERR_PAR_MOVE,
     cName: "mandocerr::MANDOCERR_PAR_MOVE", value: cint(59)),
    (name: "MANDOCERR_NS_SKIP", cEnum: mandocerr_MANDOCERR_NS_SKIP,
     cName: "mandocerr::MANDOCERR_NS_SKIP", value: cint(60)),
    (name: "MANDOCERR_BLK_NEST", cEnum: mandocerr_MANDOCERR_BLK_NEST,
     cName: "mandocerr::MANDOCERR_BLK_NEST", value: cint(61)),
    (name: "MANDOCERR_BD_NEST", cEnum: mandocerr_MANDOCERR_BD_NEST,
     cName: "mandocerr::MANDOCERR_BD_NEST", value: cint(62)),
    (name: "MANDOCERR_BL_MOVE", cEnum: mandocerr_MANDOCERR_BL_MOVE,
     cName: "mandocerr::MANDOCERR_BL_MOVE", value: cint(63)),
    (name: "MANDOCERR_TA_LINE", cEnum: mandocerr_MANDOCERR_TA_LINE,
     cName: "mandocerr::MANDOCERR_TA_LINE", value: cint(64)),
    (name: "MANDOCERR_BLK_LINE", cEnum: mandocerr_MANDOCERR_BLK_LINE,
     cName: "mandocerr::MANDOCERR_BLK_LINE", value: cint(65)),
    (name: "MANDOCERR_BLK_BLANK", cEnum: mandocerr_MANDOCERR_BLK_BLANK,
     cName: "mandocerr::MANDOCERR_BLK_BLANK", value: cint(66)),
    (name: "MANDOCERR_REQ_EMPTY", cEnum: mandocerr_MANDOCERR_REQ_EMPTY,
     cName: "mandocerr::MANDOCERR_REQ_EMPTY", value: cint(67)),
    (name: "MANDOCERR_COND_EMPTY", cEnum: mandocerr_MANDOCERR_COND_EMPTY,
     cName: "mandocerr::MANDOCERR_COND_EMPTY", value: cint(68)),
    (name: "MANDOCERR_MACRO_EMPTY", cEnum: mandocerr_MANDOCERR_MACRO_EMPTY,
     cName: "mandocerr::MANDOCERR_MACRO_EMPTY", value: cint(69)),
    (name: "MANDOCERR_BLK_EMPTY", cEnum: mandocerr_MANDOCERR_BLK_EMPTY,
     cName: "mandocerr::MANDOCERR_BLK_EMPTY", value: cint(70)),
    (name: "MANDOCERR_ARG_EMPTY", cEnum: mandocerr_MANDOCERR_ARG_EMPTY,
     cName: "mandocerr::MANDOCERR_ARG_EMPTY", value: cint(71)),
    (name: "MANDOCERR_BD_NOTYPE", cEnum: mandocerr_MANDOCERR_BD_NOTYPE,
     cName: "mandocerr::MANDOCERR_BD_NOTYPE", value: cint(72)),
    (name: "MANDOCERR_BL_LATETYPE", cEnum: mandocerr_MANDOCERR_BL_LATETYPE,
     cName: "mandocerr::MANDOCERR_BL_LATETYPE", value: cint(73)),
    (name: "MANDOCERR_BL_NOWIDTH", cEnum: mandocerr_MANDOCERR_BL_NOWIDTH,
     cName: "mandocerr::MANDOCERR_BL_NOWIDTH", value: cint(74)),
    (name: "MANDOCERR_EX_NONAME", cEnum: mandocerr_MANDOCERR_EX_NONAME,
     cName: "mandocerr::MANDOCERR_EX_NONAME", value: cint(75)),
    (name: "MANDOCERR_FO_NOHEAD", cEnum: mandocerr_MANDOCERR_FO_NOHEAD,
     cName: "mandocerr::MANDOCERR_FO_NOHEAD", value: cint(76)),
    (name: "MANDOCERR_IT_NOHEAD", cEnum: mandocerr_MANDOCERR_IT_NOHEAD,
     cName: "mandocerr::MANDOCERR_IT_NOHEAD", value: cint(77)),
    (name: "MANDOCERR_IT_NOBODY", cEnum: mandocerr_MANDOCERR_IT_NOBODY,
     cName: "mandocerr::MANDOCERR_IT_NOBODY", value: cint(78)),
    (name: "MANDOCERR_IT_NOARG", cEnum: mandocerr_MANDOCERR_IT_NOARG,
     cName: "mandocerr::MANDOCERR_IT_NOARG", value: cint(79)),
    (name: "MANDOCERR_BF_NOFONT", cEnum: mandocerr_MANDOCERR_BF_NOFONT,
     cName: "mandocerr::MANDOCERR_BF_NOFONT", value: cint(80)),
    (name: "MANDOCERR_BF_BADFONT", cEnum: mandocerr_MANDOCERR_BF_BADFONT,
     cName: "mandocerr::MANDOCERR_BF_BADFONT", value: cint(81)),
    (name: "MANDOCERR_PF_SKIP", cEnum: mandocerr_MANDOCERR_PF_SKIP,
     cName: "mandocerr::MANDOCERR_PF_SKIP", value: cint(82)),
    (name: "MANDOCERR_RS_EMPTY", cEnum: mandocerr_MANDOCERR_RS_EMPTY,
     cName: "mandocerr::MANDOCERR_RS_EMPTY", value: cint(83)),
    (name: "MANDOCERR_XR_NOSEC", cEnum: mandocerr_MANDOCERR_XR_NOSEC,
     cName: "mandocerr::MANDOCERR_XR_NOSEC", value: cint(84)),
    (name: "MANDOCERR_ARG_STD", cEnum: mandocerr_MANDOCERR_ARG_STD,
     cName: "mandocerr::MANDOCERR_ARG_STD", value: cint(85)),
    (name: "MANDOCERR_OP_EMPTY", cEnum: mandocerr_MANDOCERR_OP_EMPTY,
     cName: "mandocerr::MANDOCERR_OP_EMPTY", value: cint(86)),
    (name: "MANDOCERR_UR_NOHEAD", cEnum: mandocerr_MANDOCERR_UR_NOHEAD,
     cName: "mandocerr::MANDOCERR_UR_NOHEAD", value: cint(87)),
    (name: "MANDOCERR_EQN_NOBOX", cEnum: mandocerr_MANDOCERR_EQN_NOBOX,
     cName: "mandocerr::MANDOCERR_EQN_NOBOX", value: cint(88)),
    (name: "MANDOCERR_ARG_REP", cEnum: mandocerr_MANDOCERR_ARG_REP,
     cName: "mandocerr::MANDOCERR_ARG_REP", value: cint(89)),
    (name: "MANDOCERR_AN_REP", cEnum: mandocerr_MANDOCERR_AN_REP,
     cName: "mandocerr::MANDOCERR_AN_REP", value: cint(90)),
    (name: "MANDOCERR_BD_REP", cEnum: mandocerr_MANDOCERR_BD_REP,
     cName: "mandocerr::MANDOCERR_BD_REP", value: cint(91)),
    (name: "MANDOCERR_BL_REP", cEnum: mandocerr_MANDOCERR_BL_REP,
     cName: "mandocerr::MANDOCERR_BL_REP", value: cint(92)),
    (name: "MANDOCERR_BL_SKIPW", cEnum: mandocerr_MANDOCERR_BL_SKIPW,
     cName: "mandocerr::MANDOCERR_BL_SKIPW", value: cint(93)),
    (name: "MANDOCERR_BL_COL", cEnum: mandocerr_MANDOCERR_BL_COL,
     cName: "mandocerr::MANDOCERR_BL_COL", value: cint(94)),
    (name: "MANDOCERR_AT_BAD", cEnum: mandocerr_MANDOCERR_AT_BAD,
     cName: "mandocerr::MANDOCERR_AT_BAD", value: cint(95)),
    (name: "MANDOCERR_FA_COMMA", cEnum: mandocerr_MANDOCERR_FA_COMMA,
     cName: "mandocerr::MANDOCERR_FA_COMMA", value: cint(96)),
    (name: "MANDOCERR_FN_PAREN", cEnum: mandocerr_MANDOCERR_FN_PAREN,
     cName: "mandocerr::MANDOCERR_FN_PAREN", value: cint(97)),
    (name: "MANDOCERR_LB_BAD", cEnum: mandocerr_MANDOCERR_LB_BAD,
     cName: "mandocerr::MANDOCERR_LB_BAD", value: cint(98)),
    (name: "MANDOCERR_RS_BAD", cEnum: mandocerr_MANDOCERR_RS_BAD,
     cName: "mandocerr::MANDOCERR_RS_BAD", value: cint(99)),
    (name: "MANDOCERR_SM_BAD", cEnum: mandocerr_MANDOCERR_SM_BAD,
     cName: "mandocerr::MANDOCERR_SM_BAD", value: cint(100)),
    (name: "MANDOCERR_CHAR_FONT", cEnum: mandocerr_MANDOCERR_CHAR_FONT,
     cName: "mandocerr::MANDOCERR_CHAR_FONT", value: cint(101)),
    (name: "MANDOCERR_FT_BAD", cEnum: mandocerr_MANDOCERR_FT_BAD,
     cName: "mandocerr::MANDOCERR_FT_BAD", value: cint(102)),
    (name: "MANDOCERR_TR_ODD", cEnum: mandocerr_MANDOCERR_TR_ODD,
     cName: "mandocerr::MANDOCERR_TR_ODD", value: cint(103)),
    (name: "MANDOCERR_FI_BLANK", cEnum: mandocerr_MANDOCERR_FI_BLANK,
     cName: "mandocerr::MANDOCERR_FI_BLANK", value: cint(104)),
    (name: "MANDOCERR_FI_TAB", cEnum: mandocerr_MANDOCERR_FI_TAB,
     cName: "mandocerr::MANDOCERR_FI_TAB", value: cint(105)),
    (name: "MANDOCERR_EOS", cEnum: mandocerr_MANDOCERR_EOS,
     cName: "mandocerr::MANDOCERR_EOS", value: cint(106)),
    (name: "MANDOCERR_ESC_BAD", cEnum: mandocerr_MANDOCERR_ESC_BAD,
     cName: "mandocerr::MANDOCERR_ESC_BAD", value: cint(107)),
    (name: "MANDOCERR_ESC_UNDEF", cEnum: mandocerr_MANDOCERR_ESC_UNDEF,
     cName: "mandocerr::MANDOCERR_ESC_UNDEF", value: cint(108)),
    (name: "MANDOCERR_STR_UNDEF", cEnum: mandocerr_MANDOCERR_STR_UNDEF,
     cName: "mandocerr::MANDOCERR_STR_UNDEF", value: cint(109)),
    (name: "MANDOCERR_TBLLAYOUT_SPAN",
     cEnum: mandocerr_MANDOCERR_TBLLAYOUT_SPAN,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_SPAN", value: cint(110)),
    (name: "MANDOCERR_TBLLAYOUT_DOWN",
     cEnum: mandocerr_MANDOCERR_TBLLAYOUT_DOWN,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_DOWN", value: cint(111)),
    (name: "MANDOCERR_TBLLAYOUT_VERT",
     cEnum: mandocerr_MANDOCERR_TBLLAYOUT_VERT,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_VERT", value: cint(112)),
    (name: "MANDOCERR_ERROR", cEnum: mandocerr_MANDOCERR_ERROR,
     cName: "mandocerr::MANDOCERR_ERROR", value: cint(113)),
    (name: "MANDOCERR_TBLOPT_ALPHA", cEnum: mandocerr_MANDOCERR_TBLOPT_ALPHA,
     cName: "mandocerr::MANDOCERR_TBLOPT_ALPHA", value: cint(114)),
    (name: "MANDOCERR_TBLOPT_BAD", cEnum: mandocerr_MANDOCERR_TBLOPT_BAD,
     cName: "mandocerr::MANDOCERR_TBLOPT_BAD", value: cint(115)),
    (name: "MANDOCERR_TBLOPT_NOARG", cEnum: mandocerr_MANDOCERR_TBLOPT_NOARG,
     cName: "mandocerr::MANDOCERR_TBLOPT_NOARG", value: cint(116)),
    (name: "MANDOCERR_TBLOPT_ARGSZ", cEnum: mandocerr_MANDOCERR_TBLOPT_ARGSZ,
     cName: "mandocerr::MANDOCERR_TBLOPT_ARGSZ", value: cint(117)),
    (name: "MANDOCERR_TBLLAYOUT_NONE",
     cEnum: mandocerr_MANDOCERR_TBLLAYOUT_NONE,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_NONE", value: cint(118)),
    (name: "MANDOCERR_TBLLAYOUT_CHAR",
     cEnum: mandocerr_MANDOCERR_TBLLAYOUT_CHAR,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_CHAR", value: cint(119)),
    (name: "MANDOCERR_TBLLAYOUT_PAR", cEnum: mandocerr_MANDOCERR_TBLLAYOUT_PAR,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_PAR", value: cint(120)),
    (name: "MANDOCERR_TBLDATA_NONE", cEnum: mandocerr_MANDOCERR_TBLDATA_NONE,
     cName: "mandocerr::MANDOCERR_TBLDATA_NONE", value: cint(121)),
    (name: "MANDOCERR_TBLDATA_SPAN", cEnum: mandocerr_MANDOCERR_TBLDATA_SPAN,
     cName: "mandocerr::MANDOCERR_TBLDATA_SPAN", value: cint(122)),
    (name: "MANDOCERR_TBLDATA_EXTRA", cEnum: mandocerr_MANDOCERR_TBLDATA_EXTRA,
     cName: "mandocerr::MANDOCERR_TBLDATA_EXTRA", value: cint(123)),
    (name: "MANDOCERR_TBLDATA_BLK", cEnum: mandocerr_MANDOCERR_TBLDATA_BLK,
     cName: "mandocerr::MANDOCERR_TBLDATA_BLK", value: cint(124)),
    (name: "MANDOCERR_FILE", cEnum: mandocerr_MANDOCERR_FILE,
     cName: "mandocerr::MANDOCERR_FILE", value: cint(125)),
    (name: "MANDOCERR_PROLOG_REP", cEnum: mandocerr_MANDOCERR_PROLOG_REP,
     cName: "mandocerr::MANDOCERR_PROLOG_REP", value: cint(126)),
    (name: "MANDOCERR_DT_LATE", cEnum: mandocerr_MANDOCERR_DT_LATE,
     cName: "mandocerr::MANDOCERR_DT_LATE", value: cint(127)),
    (name: "MANDOCERR_ROFFLOOP", cEnum: mandocerr_MANDOCERR_ROFFLOOP,
     cName: "mandocerr::MANDOCERR_ROFFLOOP", value: cint(128)),
    (name: "MANDOCERR_CHAR_BAD", cEnum: mandocerr_MANDOCERR_CHAR_BAD,
     cName: "mandocerr::MANDOCERR_CHAR_BAD", value: cint(129)),
    (name: "MANDOCERR_MACRO", cEnum: mandocerr_MANDOCERR_MACRO,
     cName: "mandocerr::MANDOCERR_MACRO", value: cint(130)),
    (name: "MANDOCERR_REQ_NOMAC", cEnum: mandocerr_MANDOCERR_REQ_NOMAC,
     cName: "mandocerr::MANDOCERR_REQ_NOMAC", value: cint(131)),
    (name: "MANDOCERR_REQ_INSEC", cEnum: mandocerr_MANDOCERR_REQ_INSEC,
     cName: "mandocerr::MANDOCERR_REQ_INSEC", value: cint(132)),
    (name: "MANDOCERR_IT_STRAY", cEnum: mandocerr_MANDOCERR_IT_STRAY,
     cName: "mandocerr::MANDOCERR_IT_STRAY", value: cint(133)),
    (name: "MANDOCERR_TA_STRAY", cEnum: mandocerr_MANDOCERR_TA_STRAY,
     cName: "mandocerr::MANDOCERR_TA_STRAY", value: cint(134)),
    (name: "MANDOCERR_BLK_NOTOPEN", cEnum: mandocerr_MANDOCERR_BLK_NOTOPEN,
     cName: "mandocerr::MANDOCERR_BLK_NOTOPEN", value: cint(135)),
    (name: "MANDOCERR_RE_NOTOPEN", cEnum: mandocerr_MANDOCERR_RE_NOTOPEN,
     cName: "mandocerr::MANDOCERR_RE_NOTOPEN", value: cint(136)),
    (name: "MANDOCERR_BLK_BROKEN", cEnum: mandocerr_MANDOCERR_BLK_BROKEN,
     cName: "mandocerr::MANDOCERR_BLK_BROKEN", value: cint(137)),
    (name: "MANDOCERR_BLK_NOEND", cEnum: mandocerr_MANDOCERR_BLK_NOEND,
     cName: "mandocerr::MANDOCERR_BLK_NOEND", value: cint(138)),
    (name: "MANDOCERR_NAMESC", cEnum: mandocerr_MANDOCERR_NAMESC,
     cName: "mandocerr::MANDOCERR_NAMESC", value: cint(139)),
    (name: "MANDOCERR_ARG_UNDEF", cEnum: mandocerr_MANDOCERR_ARG_UNDEF,
     cName: "mandocerr::MANDOCERR_ARG_UNDEF", value: cint(140)),
    (name: "MANDOCERR_ARG_NONUM", cEnum: mandocerr_MANDOCERR_ARG_NONUM,
     cName: "mandocerr::MANDOCERR_ARG_NONUM", value: cint(141)),
    (name: "MANDOCERR_BD_FILE", cEnum: mandocerr_MANDOCERR_BD_FILE,
     cName: "mandocerr::MANDOCERR_BD_FILE", value: cint(142)),
    (name: "MANDOCERR_BD_NOARG", cEnum: mandocerr_MANDOCERR_BD_NOARG,
     cName: "mandocerr::MANDOCERR_BD_NOARG", value: cint(143)),
    (name: "MANDOCERR_BL_NOTYPE", cEnum: mandocerr_MANDOCERR_BL_NOTYPE,
     cName: "mandocerr::MANDOCERR_BL_NOTYPE", value: cint(144)),
    (name: "MANDOCERR_CE_NONUM", cEnum: mandocerr_MANDOCERR_CE_NONUM,
     cName: "mandocerr::MANDOCERR_CE_NONUM", value: cint(145)),
    (name: "MANDOCERR_CHAR_ARG", cEnum: mandocerr_MANDOCERR_CHAR_ARG,
     cName: "mandocerr::MANDOCERR_CHAR_ARG", value: cint(146)),
    (name: "MANDOCERR_NM_NONAME", cEnum: mandocerr_MANDOCERR_NM_NONAME,
     cName: "mandocerr::MANDOCERR_NM_NONAME", value: cint(147)),
    (name: "MANDOCERR_OS_UNAME", cEnum: mandocerr_MANDOCERR_OS_UNAME,
     cName: "mandocerr::MANDOCERR_OS_UNAME", value: cint(148)),
    (name: "MANDOCERR_ST_BAD", cEnum: mandocerr_MANDOCERR_ST_BAD,
     cName: "mandocerr::MANDOCERR_ST_BAD", value: cint(149)),
    (name: "MANDOCERR_IT_NONUM", cEnum: mandocerr_MANDOCERR_IT_NONUM,
     cName: "mandocerr::MANDOCERR_IT_NONUM", value: cint(150)),
    (name: "MANDOCERR_SHIFT", cEnum: mandocerr_MANDOCERR_SHIFT,
     cName: "mandocerr::MANDOCERR_SHIFT", value: cint(151)),
    (name: "MANDOCERR_SO_PATH", cEnum: mandocerr_MANDOCERR_SO_PATH,
     cName: "mandocerr::MANDOCERR_SO_PATH", value: cint(152)),
    (name: "MANDOCERR_SO_FAIL", cEnum: mandocerr_MANDOCERR_SO_FAIL,
     cName: "mandocerr::MANDOCERR_SO_FAIL", value: cint(153)),
    (name: "MANDOCERR_ARG_SKIP", cEnum: mandocerr_MANDOCERR_ARG_SKIP,
     cName: "mandocerr::MANDOCERR_ARG_SKIP", value: cint(154)),
    (name: "MANDOCERR_ARG_EXCESS", cEnum: mandocerr_MANDOCERR_ARG_EXCESS,
     cName: "mandocerr::MANDOCERR_ARG_EXCESS", value: cint(155)),
    (name: "MANDOCERR_DIVZERO", cEnum: mandocerr_MANDOCERR_DIVZERO,
     cName: "mandocerr::MANDOCERR_DIVZERO", value: cint(156)),
    (name: "MANDOCERR_UNSUPP", cEnum: mandocerr_MANDOCERR_UNSUPP,
     cName: "mandocerr::MANDOCERR_UNSUPP", value: cint(157)),
    (name: "MANDOCERR_TOOLARGE", cEnum: mandocerr_MANDOCERR_TOOLARGE,
     cName: "mandocerr::MANDOCERR_TOOLARGE", value: cint(158)),
    (name: "MANDOCERR_CHAR_UNSUPP", cEnum: mandocerr_MANDOCERR_CHAR_UNSUPP,
     cName: "mandocerr::MANDOCERR_CHAR_UNSUPP", value: cint(159)),
    (name: "MANDOCERR_ESC_UNSUPP", cEnum: mandocerr_MANDOCERR_ESC_UNSUPP,
     cName: "mandocerr::MANDOCERR_ESC_UNSUPP", value: cint(160)),
    (name: "MANDOCERR_REQ_UNSUPP", cEnum: mandocerr_MANDOCERR_REQ_UNSUPP,
     cName: "mandocerr::MANDOCERR_REQ_UNSUPP", value: cint(161)),
    (name: "MANDOCERR_WHILE_NEST", cEnum: mandocerr_MANDOCERR_WHILE_NEST,
     cName: "mandocerr::MANDOCERR_WHILE_NEST", value: cint(162)),
    (name: "MANDOCERR_WHILE_OUTOF", cEnum: mandocerr_MANDOCERR_WHILE_OUTOF,
     cName: "mandocerr::MANDOCERR_WHILE_OUTOF", value: cint(163)),
    (name: "MANDOCERR_WHILE_INTO", cEnum: mandocerr_MANDOCERR_WHILE_INTO,
     cName: "mandocerr::MANDOCERR_WHILE_INTO", value: cint(164)),
    (name: "MANDOCERR_WHILE_FAIL", cEnum: mandocerr_MANDOCERR_WHILE_FAIL,
     cName: "mandocerr::MANDOCERR_WHILE_FAIL", value: cint(165)),
    (name: "MANDOCERR_TBLOPT_EQN", cEnum: mandocerr_MANDOCERR_TBLOPT_EQN,
     cName: "mandocerr::MANDOCERR_TBLOPT_EQN", value: cint(166)),
    (name: "MANDOCERR_TBLLAYOUT_MOD", cEnum: mandocerr_MANDOCERR_TBLLAYOUT_MOD,
     cName: "mandocerr::MANDOCERR_TBLLAYOUT_MOD", value: cint(167)),
    (name: "MANDOCERR_TBLMACRO", cEnum: mandocerr_MANDOCERR_TBLMACRO,
     cName: "mandocerr::MANDOCERR_TBLMACRO", value: cint(168)),
    (name: "MANDOCERR_MAX", cEnum: mandocerr_MANDOCERR_MAX,
     cName: "mandocerr::MANDOCERR_MAX", value: cint(169))]
proc toCInt*(en: Mandocerr): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMandocerrmapping[en].value

proc toCInt*(en: set[Mandocerr]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMandocerrmapping[val].value)

proc `$`*(en: MandocerrC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mandocerr_MANDOCERR_OK:
    result = "mandocerr::MANDOCERR_OK"
  of mandocerr_MANDOCERR_BASE:
    result = "mandocerr::MANDOCERR_BASE"
  of mandocerr_MANDOCERR_MDOCDATE:
    result = "mandocerr::MANDOCERR_MDOCDATE"
  of mandocerr_MANDOCERR_MDOCDATE_MISSING:
    result = "mandocerr::MANDOCERR_MDOCDATE_MISSING"
  of mandocerr_MANDOCERR_ARCH_BAD:
    result = "mandocerr::MANDOCERR_ARCH_BAD"
  of mandocerr_MANDOCERR_OS_ARG:
    result = "mandocerr::MANDOCERR_OS_ARG"
  of mandocerr_MANDOCERR_RCS_MISSING:
    result = "mandocerr::MANDOCERR_RCS_MISSING"
  of mandocerr_MANDOCERR_XR_BAD:
    result = "mandocerr::MANDOCERR_XR_BAD"
  of mandocerr_MANDOCERR_STYLE:
    result = "mandocerr::MANDOCERR_STYLE"
  of mandocerr_MANDOCERR_DATE_LEGACY:
    result = "mandocerr::MANDOCERR_DATE_LEGACY"
  of mandocerr_MANDOCERR_DATE_NORM:
    result = "mandocerr::MANDOCERR_DATE_NORM"
  of mandocerr_MANDOCERR_TITLE_CASE:
    result = "mandocerr::MANDOCERR_TITLE_CASE"
  of mandocerr_MANDOCERR_RCS_REP:
    result = "mandocerr::MANDOCERR_RCS_REP"
  of mandocerr_MANDOCERR_SEC_TYPO:
    result = "mandocerr::MANDOCERR_SEC_TYPO"
  of mandocerr_MANDOCERR_ARG_QUOTE:
    result = "mandocerr::MANDOCERR_ARG_QUOTE"
  of mandocerr_MANDOCERR_MACRO_USELESS:
    result = "mandocerr::MANDOCERR_MACRO_USELESS"
  of mandocerr_MANDOCERR_BX:
    result = "mandocerr::MANDOCERR_BX"
  of mandocerr_MANDOCERR_ER_ORDER:
    result = "mandocerr::MANDOCERR_ER_ORDER"
  of mandocerr_MANDOCERR_ER_REP:
    result = "mandocerr::MANDOCERR_ER_REP"
  of mandocerr_MANDOCERR_DELIM:
    result = "mandocerr::MANDOCERR_DELIM"
  of mandocerr_MANDOCERR_DELIM_NB:
    result = "mandocerr::MANDOCERR_DELIM_NB"
  of mandocerr_MANDOCERR_FI_SKIP:
    result = "mandocerr::MANDOCERR_FI_SKIP"
  of mandocerr_MANDOCERR_NF_SKIP:
    result = "mandocerr::MANDOCERR_NF_SKIP"
  of mandocerr_MANDOCERR_DASHDASH:
    result = "mandocerr::MANDOCERR_DASHDASH"
  of mandocerr_MANDOCERR_FUNC:
    result = "mandocerr::MANDOCERR_FUNC"
  of mandocerr_MANDOCERR_SPACE_EOL:
    result = "mandocerr::MANDOCERR_SPACE_EOL"
  of mandocerr_MANDOCERR_COMMENT_BAD:
    result = "mandocerr::MANDOCERR_COMMENT_BAD"
  of mandocerr_MANDOCERR_WARNING:
    result = "mandocerr::MANDOCERR_WARNING"
  of mandocerr_MANDOCERR_DT_NOTITLE:
    result = "mandocerr::MANDOCERR_DT_NOTITLE"
  of mandocerr_MANDOCERR_TH_NOTITLE:
    result = "mandocerr::MANDOCERR_TH_NOTITLE"
  of mandocerr_MANDOCERR_MSEC_MISSING:
    result = "mandocerr::MANDOCERR_MSEC_MISSING"
  of mandocerr_MANDOCERR_MSEC_BAD:
    result = "mandocerr::MANDOCERR_MSEC_BAD"
  of mandocerr_MANDOCERR_DATE_MISSING:
    result = "mandocerr::MANDOCERR_DATE_MISSING"
  of mandocerr_MANDOCERR_DATE_BAD:
    result = "mandocerr::MANDOCERR_DATE_BAD"
  of mandocerr_MANDOCERR_DATE_FUTURE:
    result = "mandocerr::MANDOCERR_DATE_FUTURE"
  of mandocerr_MANDOCERR_OS_MISSING:
    result = "mandocerr::MANDOCERR_OS_MISSING"
  of mandocerr_MANDOCERR_PROLOG_LATE:
    result = "mandocerr::MANDOCERR_PROLOG_LATE"
  of mandocerr_MANDOCERR_PROLOG_ORDER:
    result = "mandocerr::MANDOCERR_PROLOG_ORDER"
  of mandocerr_MANDOCERR_SO:
    result = "mandocerr::MANDOCERR_SO"
  of mandocerr_MANDOCERR_DOC_EMPTY:
    result = "mandocerr::MANDOCERR_DOC_EMPTY"
  of mandocerr_MANDOCERR_SEC_BEFORE:
    result = "mandocerr::MANDOCERR_SEC_BEFORE"
  of mandocerr_MANDOCERR_NAMESEC_FIRST:
    result = "mandocerr::MANDOCERR_NAMESEC_FIRST"
  of mandocerr_MANDOCERR_NAMESEC_NONM:
    result = "mandocerr::MANDOCERR_NAMESEC_NONM"
  of mandocerr_MANDOCERR_NAMESEC_NOND:
    result = "mandocerr::MANDOCERR_NAMESEC_NOND"
  of mandocerr_MANDOCERR_NAMESEC_ND:
    result = "mandocerr::MANDOCERR_NAMESEC_ND"
  of mandocerr_MANDOCERR_NAMESEC_BAD:
    result = "mandocerr::MANDOCERR_NAMESEC_BAD"
  of mandocerr_MANDOCERR_NAMESEC_PUNCT:
    result = "mandocerr::MANDOCERR_NAMESEC_PUNCT"
  of mandocerr_MANDOCERR_ND_EMPTY:
    result = "mandocerr::MANDOCERR_ND_EMPTY"
  of mandocerr_MANDOCERR_ND_LATE:
    result = "mandocerr::MANDOCERR_ND_LATE"
  of mandocerr_MANDOCERR_SEC_ORDER:
    result = "mandocerr::MANDOCERR_SEC_ORDER"
  of mandocerr_MANDOCERR_SEC_REP:
    result = "mandocerr::MANDOCERR_SEC_REP"
  of mandocerr_MANDOCERR_SEC_MSEC:
    result = "mandocerr::MANDOCERR_SEC_MSEC"
  of mandocerr_MANDOCERR_XR_SELF:
    result = "mandocerr::MANDOCERR_XR_SELF"
  of mandocerr_MANDOCERR_XR_ORDER:
    result = "mandocerr::MANDOCERR_XR_ORDER"
  of mandocerr_MANDOCERR_XR_PUNCT:
    result = "mandocerr::MANDOCERR_XR_PUNCT"
  of mandocerr_MANDOCERR_AN_MISSING:
    result = "mandocerr::MANDOCERR_AN_MISSING"
  of mandocerr_MANDOCERR_MACRO_OBS:
    result = "mandocerr::MANDOCERR_MACRO_OBS"
  of mandocerr_MANDOCERR_MACRO_CALL:
    result = "mandocerr::MANDOCERR_MACRO_CALL"
  of mandocerr_MANDOCERR_PAR_SKIP:
    result = "mandocerr::MANDOCERR_PAR_SKIP"
  of mandocerr_MANDOCERR_PAR_MOVE:
    result = "mandocerr::MANDOCERR_PAR_MOVE"
  of mandocerr_MANDOCERR_NS_SKIP:
    result = "mandocerr::MANDOCERR_NS_SKIP"
  of mandocerr_MANDOCERR_BLK_NEST:
    result = "mandocerr::MANDOCERR_BLK_NEST"
  of mandocerr_MANDOCERR_BD_NEST:
    result = "mandocerr::MANDOCERR_BD_NEST"
  of mandocerr_MANDOCERR_BL_MOVE:
    result = "mandocerr::MANDOCERR_BL_MOVE"
  of mandocerr_MANDOCERR_TA_LINE:
    result = "mandocerr::MANDOCERR_TA_LINE"
  of mandocerr_MANDOCERR_BLK_LINE:
    result = "mandocerr::MANDOCERR_BLK_LINE"
  of mandocerr_MANDOCERR_BLK_BLANK:
    result = "mandocerr::MANDOCERR_BLK_BLANK"
  of mandocerr_MANDOCERR_REQ_EMPTY:
    result = "mandocerr::MANDOCERR_REQ_EMPTY"
  of mandocerr_MANDOCERR_COND_EMPTY:
    result = "mandocerr::MANDOCERR_COND_EMPTY"
  of mandocerr_MANDOCERR_MACRO_EMPTY:
    result = "mandocerr::MANDOCERR_MACRO_EMPTY"
  of mandocerr_MANDOCERR_BLK_EMPTY:
    result = "mandocerr::MANDOCERR_BLK_EMPTY"
  of mandocerr_MANDOCERR_ARG_EMPTY:
    result = "mandocerr::MANDOCERR_ARG_EMPTY"
  of mandocerr_MANDOCERR_BD_NOTYPE:
    result = "mandocerr::MANDOCERR_BD_NOTYPE"
  of mandocerr_MANDOCERR_BL_LATETYPE:
    result = "mandocerr::MANDOCERR_BL_LATETYPE"
  of mandocerr_MANDOCERR_BL_NOWIDTH:
    result = "mandocerr::MANDOCERR_BL_NOWIDTH"
  of mandocerr_MANDOCERR_EX_NONAME:
    result = "mandocerr::MANDOCERR_EX_NONAME"
  of mandocerr_MANDOCERR_FO_NOHEAD:
    result = "mandocerr::MANDOCERR_FO_NOHEAD"
  of mandocerr_MANDOCERR_IT_NOHEAD:
    result = "mandocerr::MANDOCERR_IT_NOHEAD"
  of mandocerr_MANDOCERR_IT_NOBODY:
    result = "mandocerr::MANDOCERR_IT_NOBODY"
  of mandocerr_MANDOCERR_IT_NOARG:
    result = "mandocerr::MANDOCERR_IT_NOARG"
  of mandocerr_MANDOCERR_BF_NOFONT:
    result = "mandocerr::MANDOCERR_BF_NOFONT"
  of mandocerr_MANDOCERR_BF_BADFONT:
    result = "mandocerr::MANDOCERR_BF_BADFONT"
  of mandocerr_MANDOCERR_PF_SKIP:
    result = "mandocerr::MANDOCERR_PF_SKIP"
  of mandocerr_MANDOCERR_RS_EMPTY:
    result = "mandocerr::MANDOCERR_RS_EMPTY"
  of mandocerr_MANDOCERR_XR_NOSEC:
    result = "mandocerr::MANDOCERR_XR_NOSEC"
  of mandocerr_MANDOCERR_ARG_STD:
    result = "mandocerr::MANDOCERR_ARG_STD"
  of mandocerr_MANDOCERR_OP_EMPTY:
    result = "mandocerr::MANDOCERR_OP_EMPTY"
  of mandocerr_MANDOCERR_UR_NOHEAD:
    result = "mandocerr::MANDOCERR_UR_NOHEAD"
  of mandocerr_MANDOCERR_EQN_NOBOX:
    result = "mandocerr::MANDOCERR_EQN_NOBOX"
  of mandocerr_MANDOCERR_ARG_REP:
    result = "mandocerr::MANDOCERR_ARG_REP"
  of mandocerr_MANDOCERR_AN_REP:
    result = "mandocerr::MANDOCERR_AN_REP"
  of mandocerr_MANDOCERR_BD_REP:
    result = "mandocerr::MANDOCERR_BD_REP"
  of mandocerr_MANDOCERR_BL_REP:
    result = "mandocerr::MANDOCERR_BL_REP"
  of mandocerr_MANDOCERR_BL_SKIPW:
    result = "mandocerr::MANDOCERR_BL_SKIPW"
  of mandocerr_MANDOCERR_BL_COL:
    result = "mandocerr::MANDOCERR_BL_COL"
  of mandocerr_MANDOCERR_AT_BAD:
    result = "mandocerr::MANDOCERR_AT_BAD"
  of mandocerr_MANDOCERR_FA_COMMA:
    result = "mandocerr::MANDOCERR_FA_COMMA"
  of mandocerr_MANDOCERR_FN_PAREN:
    result = "mandocerr::MANDOCERR_FN_PAREN"
  of mandocerr_MANDOCERR_LB_BAD:
    result = "mandocerr::MANDOCERR_LB_BAD"
  of mandocerr_MANDOCERR_RS_BAD:
    result = "mandocerr::MANDOCERR_RS_BAD"
  of mandocerr_MANDOCERR_SM_BAD:
    result = "mandocerr::MANDOCERR_SM_BAD"
  of mandocerr_MANDOCERR_CHAR_FONT:
    result = "mandocerr::MANDOCERR_CHAR_FONT"
  of mandocerr_MANDOCERR_FT_BAD:
    result = "mandocerr::MANDOCERR_FT_BAD"
  of mandocerr_MANDOCERR_TR_ODD:
    result = "mandocerr::MANDOCERR_TR_ODD"
  of mandocerr_MANDOCERR_FI_BLANK:
    result = "mandocerr::MANDOCERR_FI_BLANK"
  of mandocerr_MANDOCERR_FI_TAB:
    result = "mandocerr::MANDOCERR_FI_TAB"
  of mandocerr_MANDOCERR_EOS:
    result = "mandocerr::MANDOCERR_EOS"
  of mandocerr_MANDOCERR_ESC_BAD:
    result = "mandocerr::MANDOCERR_ESC_BAD"
  of mandocerr_MANDOCERR_ESC_UNDEF:
    result = "mandocerr::MANDOCERR_ESC_UNDEF"
  of mandocerr_MANDOCERR_STR_UNDEF:
    result = "mandocerr::MANDOCERR_STR_UNDEF"
  of mandocerr_MANDOCERR_TBLLAYOUT_SPAN:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_SPAN"
  of mandocerr_MANDOCERR_TBLLAYOUT_DOWN:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_DOWN"
  of mandocerr_MANDOCERR_TBLLAYOUT_VERT:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_VERT"
  of mandocerr_MANDOCERR_ERROR:
    result = "mandocerr::MANDOCERR_ERROR"
  of mandocerr_MANDOCERR_TBLOPT_ALPHA:
    result = "mandocerr::MANDOCERR_TBLOPT_ALPHA"
  of mandocerr_MANDOCERR_TBLOPT_BAD:
    result = "mandocerr::MANDOCERR_TBLOPT_BAD"
  of mandocerr_MANDOCERR_TBLOPT_NOARG:
    result = "mandocerr::MANDOCERR_TBLOPT_NOARG"
  of mandocerr_MANDOCERR_TBLOPT_ARGSZ:
    result = "mandocerr::MANDOCERR_TBLOPT_ARGSZ"
  of mandocerr_MANDOCERR_TBLLAYOUT_NONE:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_NONE"
  of mandocerr_MANDOCERR_TBLLAYOUT_CHAR:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_CHAR"
  of mandocerr_MANDOCERR_TBLLAYOUT_PAR:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_PAR"
  of mandocerr_MANDOCERR_TBLDATA_NONE:
    result = "mandocerr::MANDOCERR_TBLDATA_NONE"
  of mandocerr_MANDOCERR_TBLDATA_SPAN:
    result = "mandocerr::MANDOCERR_TBLDATA_SPAN"
  of mandocerr_MANDOCERR_TBLDATA_EXTRA:
    result = "mandocerr::MANDOCERR_TBLDATA_EXTRA"
  of mandocerr_MANDOCERR_TBLDATA_BLK:
    result = "mandocerr::MANDOCERR_TBLDATA_BLK"
  of mandocerr_MANDOCERR_FILE:
    result = "mandocerr::MANDOCERR_FILE"
  of mandocerr_MANDOCERR_PROLOG_REP:
    result = "mandocerr::MANDOCERR_PROLOG_REP"
  of mandocerr_MANDOCERR_DT_LATE:
    result = "mandocerr::MANDOCERR_DT_LATE"
  of mandocerr_MANDOCERR_ROFFLOOP:
    result = "mandocerr::MANDOCERR_ROFFLOOP"
  of mandocerr_MANDOCERR_CHAR_BAD:
    result = "mandocerr::MANDOCERR_CHAR_BAD"
  of mandocerr_MANDOCERR_MACRO:
    result = "mandocerr::MANDOCERR_MACRO"
  of mandocerr_MANDOCERR_REQ_NOMAC:
    result = "mandocerr::MANDOCERR_REQ_NOMAC"
  of mandocerr_MANDOCERR_REQ_INSEC:
    result = "mandocerr::MANDOCERR_REQ_INSEC"
  of mandocerr_MANDOCERR_IT_STRAY:
    result = "mandocerr::MANDOCERR_IT_STRAY"
  of mandocerr_MANDOCERR_TA_STRAY:
    result = "mandocerr::MANDOCERR_TA_STRAY"
  of mandocerr_MANDOCERR_BLK_NOTOPEN:
    result = "mandocerr::MANDOCERR_BLK_NOTOPEN"
  of mandocerr_MANDOCERR_RE_NOTOPEN:
    result = "mandocerr::MANDOCERR_RE_NOTOPEN"
  of mandocerr_MANDOCERR_BLK_BROKEN:
    result = "mandocerr::MANDOCERR_BLK_BROKEN"
  of mandocerr_MANDOCERR_BLK_NOEND:
    result = "mandocerr::MANDOCERR_BLK_NOEND"
  of mandocerr_MANDOCERR_NAMESC:
    result = "mandocerr::MANDOCERR_NAMESC"
  of mandocerr_MANDOCERR_ARG_UNDEF:
    result = "mandocerr::MANDOCERR_ARG_UNDEF"
  of mandocerr_MANDOCERR_ARG_NONUM:
    result = "mandocerr::MANDOCERR_ARG_NONUM"
  of mandocerr_MANDOCERR_BD_FILE:
    result = "mandocerr::MANDOCERR_BD_FILE"
  of mandocerr_MANDOCERR_BD_NOARG:
    result = "mandocerr::MANDOCERR_BD_NOARG"
  of mandocerr_MANDOCERR_BL_NOTYPE:
    result = "mandocerr::MANDOCERR_BL_NOTYPE"
  of mandocerr_MANDOCERR_CE_NONUM:
    result = "mandocerr::MANDOCERR_CE_NONUM"
  of mandocerr_MANDOCERR_CHAR_ARG:
    result = "mandocerr::MANDOCERR_CHAR_ARG"
  of mandocerr_MANDOCERR_NM_NONAME:
    result = "mandocerr::MANDOCERR_NM_NONAME"
  of mandocerr_MANDOCERR_OS_UNAME:
    result = "mandocerr::MANDOCERR_OS_UNAME"
  of mandocerr_MANDOCERR_ST_BAD:
    result = "mandocerr::MANDOCERR_ST_BAD"
  of mandocerr_MANDOCERR_IT_NONUM:
    result = "mandocerr::MANDOCERR_IT_NONUM"
  of mandocerr_MANDOCERR_SHIFT:
    result = "mandocerr::MANDOCERR_SHIFT"
  of mandocerr_MANDOCERR_SO_PATH:
    result = "mandocerr::MANDOCERR_SO_PATH"
  of mandocerr_MANDOCERR_SO_FAIL:
    result = "mandocerr::MANDOCERR_SO_FAIL"
  of mandocerr_MANDOCERR_ARG_SKIP:
    result = "mandocerr::MANDOCERR_ARG_SKIP"
  of mandocerr_MANDOCERR_ARG_EXCESS:
    result = "mandocerr::MANDOCERR_ARG_EXCESS"
  of mandocerr_MANDOCERR_DIVZERO:
    result = "mandocerr::MANDOCERR_DIVZERO"
  of mandocerr_MANDOCERR_UNSUPP:
    result = "mandocerr::MANDOCERR_UNSUPP"
  of mandocerr_MANDOCERR_TOOLARGE:
    result = "mandocerr::MANDOCERR_TOOLARGE"
  of mandocerr_MANDOCERR_CHAR_UNSUPP:
    result = "mandocerr::MANDOCERR_CHAR_UNSUPP"
  of mandocerr_MANDOCERR_ESC_UNSUPP:
    result = "mandocerr::MANDOCERR_ESC_UNSUPP"
  of mandocerr_MANDOCERR_REQ_UNSUPP:
    result = "mandocerr::MANDOCERR_REQ_UNSUPP"
  of mandocerr_MANDOCERR_WHILE_NEST:
    result = "mandocerr::MANDOCERR_WHILE_NEST"
  of mandocerr_MANDOCERR_WHILE_OUTOF:
    result = "mandocerr::MANDOCERR_WHILE_OUTOF"
  of mandocerr_MANDOCERR_WHILE_INTO:
    result = "mandocerr::MANDOCERR_WHILE_INTO"
  of mandocerr_MANDOCERR_WHILE_FAIL:
    result = "mandocerr::MANDOCERR_WHILE_FAIL"
  of mandocerr_MANDOCERR_TBLOPT_EQN:
    result = "mandocerr::MANDOCERR_TBLOPT_EQN"
  of mandocerr_MANDOCERR_TBLLAYOUT_MOD:
    result = "mandocerr::MANDOCERR_TBLLAYOUT_MOD"
  of mandocerr_MANDOCERR_TBLMACRO:
    result = "mandocerr::MANDOCERR_TBLMACRO"
  of mandocerr_MANDOCERR_MAX:
    result = "mandocerr::MANDOCERR_MAX"
  
func toMandocerr*(en: MandocerrC): Mandocerr {.inline.} =
  case en
  of mandocerr_MANDOCERR_OK:
    meOk
  of mandocerr_MANDOCERR_BASE:
    meBase
  of mandocerr_MANDOCERR_MDOCDATE:
    meMdocdate
  of mandocerr_MANDOCERR_MDOCDATE_MISSING:
    meMdocdateMissing
  of mandocerr_MANDOCERR_ARCH_BAD:
    meArchBad
  of mandocerr_MANDOCERR_OS_ARG:
    meOsArg
  of mandocerr_MANDOCERR_RCS_MISSING:
    meRcsMissing
  of mandocerr_MANDOCERR_XR_BAD:
    meXrBad
  of mandocerr_MANDOCERR_STYLE:
    meStyle
  of mandocerr_MANDOCERR_DATE_LEGACY:
    meDateLegacy
  of mandocerr_MANDOCERR_DATE_NORM:
    meDateNorm
  of mandocerr_MANDOCERR_TITLE_CASE:
    meTitleCase
  of mandocerr_MANDOCERR_RCS_REP:
    meRcsRep
  of mandocerr_MANDOCERR_SEC_TYPO:
    meSecTypo
  of mandocerr_MANDOCERR_ARG_QUOTE:
    meArgQuote
  of mandocerr_MANDOCERR_MACRO_USELESS:
    meMacroUseless
  of mandocerr_MANDOCERR_BX:
    meBx
  of mandocerr_MANDOCERR_ER_ORDER:
    meErOrder
  of mandocerr_MANDOCERR_ER_REP:
    meErRep
  of mandocerr_MANDOCERR_DELIM:
    meDelim
  of mandocerr_MANDOCERR_DELIM_NB:
    meDelimNb
  of mandocerr_MANDOCERR_FI_SKIP:
    meFiSkip
  of mandocerr_MANDOCERR_NF_SKIP:
    meNfSkip
  of mandocerr_MANDOCERR_DASHDASH:
    meDashdash
  of mandocerr_MANDOCERR_FUNC:
    meFunc
  of mandocerr_MANDOCERR_SPACE_EOL:
    meSpaceEol
  of mandocerr_MANDOCERR_COMMENT_BAD:
    meCommentBad
  of mandocerr_MANDOCERR_WARNING:
    meWarning
  of mandocerr_MANDOCERR_DT_NOTITLE:
    meDtNotitle
  of mandocerr_MANDOCERR_TH_NOTITLE:
    meThNotitle
  of mandocerr_MANDOCERR_MSEC_MISSING:
    meMsecMissing
  of mandocerr_MANDOCERR_MSEC_BAD:
    meMsecBad
  of mandocerr_MANDOCERR_DATE_MISSING:
    meDateMissing
  of mandocerr_MANDOCERR_DATE_BAD:
    meDateBad
  of mandocerr_MANDOCERR_DATE_FUTURE:
    meDateFuture
  of mandocerr_MANDOCERR_OS_MISSING:
    meOsMissing
  of mandocerr_MANDOCERR_PROLOG_LATE:
    mePrologLate
  of mandocerr_MANDOCERR_PROLOG_ORDER:
    mePrologOrder
  of mandocerr_MANDOCERR_SO:
    meSo
  of mandocerr_MANDOCERR_DOC_EMPTY:
    meDocEmpty
  of mandocerr_MANDOCERR_SEC_BEFORE:
    meSecBefore
  of mandocerr_MANDOCERR_NAMESEC_FIRST:
    meNamesecFirst
  of mandocerr_MANDOCERR_NAMESEC_NONM:
    meNamesecNonm
  of mandocerr_MANDOCERR_NAMESEC_NOND:
    meNamesecNond
  of mandocerr_MANDOCERR_NAMESEC_ND:
    meNamesecNd
  of mandocerr_MANDOCERR_NAMESEC_BAD:
    meNamesecBad
  of mandocerr_MANDOCERR_NAMESEC_PUNCT:
    meNamesecPunct
  of mandocerr_MANDOCERR_ND_EMPTY:
    meNdEmpty
  of mandocerr_MANDOCERR_ND_LATE:
    meNdLate
  of mandocerr_MANDOCERR_SEC_ORDER:
    meSecOrder
  of mandocerr_MANDOCERR_SEC_REP:
    meSecRep
  of mandocerr_MANDOCERR_SEC_MSEC:
    meSecMsec
  of mandocerr_MANDOCERR_XR_SELF:
    meXrSelf
  of mandocerr_MANDOCERR_XR_ORDER:
    meXrOrder
  of mandocerr_MANDOCERR_XR_PUNCT:
    meXrPunct
  of mandocerr_MANDOCERR_AN_MISSING:
    meAnMissing
  of mandocerr_MANDOCERR_MACRO_OBS:
    meMacroObs
  of mandocerr_MANDOCERR_MACRO_CALL:
    meMacroCall
  of mandocerr_MANDOCERR_PAR_SKIP:
    meParSkip
  of mandocerr_MANDOCERR_PAR_MOVE:
    meParMove
  of mandocerr_MANDOCERR_NS_SKIP:
    meNsSkip
  of mandocerr_MANDOCERR_BLK_NEST:
    meBlkNest
  of mandocerr_MANDOCERR_BD_NEST:
    meBdNest
  of mandocerr_MANDOCERR_BL_MOVE:
    meBlMove
  of mandocerr_MANDOCERR_TA_LINE:
    meTaLine
  of mandocerr_MANDOCERR_BLK_LINE:
    meBlkLine
  of mandocerr_MANDOCERR_BLK_BLANK:
    meBlkBlank
  of mandocerr_MANDOCERR_REQ_EMPTY:
    meReqEmpty
  of mandocerr_MANDOCERR_COND_EMPTY:
    meCondEmpty
  of mandocerr_MANDOCERR_MACRO_EMPTY:
    meMacroEmpty
  of mandocerr_MANDOCERR_BLK_EMPTY:
    meBlkEmpty
  of mandocerr_MANDOCERR_ARG_EMPTY:
    meArgEmpty
  of mandocerr_MANDOCERR_BD_NOTYPE:
    meBdNotype
  of mandocerr_MANDOCERR_BL_LATETYPE:
    meBlLatetype
  of mandocerr_MANDOCERR_BL_NOWIDTH:
    meBlNowidth
  of mandocerr_MANDOCERR_EX_NONAME:
    meExNoname
  of mandocerr_MANDOCERR_FO_NOHEAD:
    meFoNohead
  of mandocerr_MANDOCERR_IT_NOHEAD:
    meItNohead
  of mandocerr_MANDOCERR_IT_NOBODY:
    meItNobody
  of mandocerr_MANDOCERR_IT_NOARG:
    meItNoarg
  of mandocerr_MANDOCERR_BF_NOFONT:
    meBfNofont
  of mandocerr_MANDOCERR_BF_BADFONT:
    meBfBadfont
  of mandocerr_MANDOCERR_PF_SKIP:
    mePfSkip
  of mandocerr_MANDOCERR_RS_EMPTY:
    meRsEmpty
  of mandocerr_MANDOCERR_XR_NOSEC:
    meXrNosec
  of mandocerr_MANDOCERR_ARG_STD:
    meArgStd
  of mandocerr_MANDOCERR_OP_EMPTY:
    meOpEmpty
  of mandocerr_MANDOCERR_UR_NOHEAD:
    meUrNohead
  of mandocerr_MANDOCERR_EQN_NOBOX:
    meEqnNobox
  of mandocerr_MANDOCERR_ARG_REP:
    meArgRep
  of mandocerr_MANDOCERR_AN_REP:
    meAnRep
  of mandocerr_MANDOCERR_BD_REP:
    meBdRep
  of mandocerr_MANDOCERR_BL_REP:
    meBlRep
  of mandocerr_MANDOCERR_BL_SKIPW:
    meBlSkipw
  of mandocerr_MANDOCERR_BL_COL:
    meBlCol
  of mandocerr_MANDOCERR_AT_BAD:
    meAtBad
  of mandocerr_MANDOCERR_FA_COMMA:
    meFaComma
  of mandocerr_MANDOCERR_FN_PAREN:
    meFnParen
  of mandocerr_MANDOCERR_LB_BAD:
    meLbBad
  of mandocerr_MANDOCERR_RS_BAD:
    meRsBad
  of mandocerr_MANDOCERR_SM_BAD:
    meSmBad
  of mandocerr_MANDOCERR_CHAR_FONT:
    meCharFont
  of mandocerr_MANDOCERR_FT_BAD:
    meFtBad
  of mandocerr_MANDOCERR_TR_ODD:
    meTrOdd
  of mandocerr_MANDOCERR_FI_BLANK:
    meFiBlank
  of mandocerr_MANDOCERR_FI_TAB:
    meFiTab
  of mandocerr_MANDOCERR_EOS:
    meEos
  of mandocerr_MANDOCERR_ESC_BAD:
    meEscBad
  of mandocerr_MANDOCERR_ESC_UNDEF:
    meEscUndef
  of mandocerr_MANDOCERR_STR_UNDEF:
    meStrUndef
  of mandocerr_MANDOCERR_TBLLAYOUT_SPAN:
    meTbllayoutSpan
  of mandocerr_MANDOCERR_TBLLAYOUT_DOWN:
    meTbllayoutDown
  of mandocerr_MANDOCERR_TBLLAYOUT_VERT:
    meTbllayoutVert
  of mandocerr_MANDOCERR_ERROR:
    meError
  of mandocerr_MANDOCERR_TBLOPT_ALPHA:
    meTbloptAlpha
  of mandocerr_MANDOCERR_TBLOPT_BAD:
    meTbloptBad
  of mandocerr_MANDOCERR_TBLOPT_NOARG:
    meTbloptNoarg
  of mandocerr_MANDOCERR_TBLOPT_ARGSZ:
    meTbloptArgsz
  of mandocerr_MANDOCERR_TBLLAYOUT_NONE:
    meTbllayoutNone
  of mandocerr_MANDOCERR_TBLLAYOUT_CHAR:
    meTbllayoutChar
  of mandocerr_MANDOCERR_TBLLAYOUT_PAR:
    meTbllayoutPar
  of mandocerr_MANDOCERR_TBLDATA_NONE:
    meTbldataNone
  of mandocerr_MANDOCERR_TBLDATA_SPAN:
    meTbldataSpan
  of mandocerr_MANDOCERR_TBLDATA_EXTRA:
    meTbldataExtra
  of mandocerr_MANDOCERR_TBLDATA_BLK:
    meTbldataBlk
  of mandocerr_MANDOCERR_FILE:
    meFile
  of mandocerr_MANDOCERR_PROLOG_REP:
    mePrologRep
  of mandocerr_MANDOCERR_DT_LATE:
    meDtLate
  of mandocerr_MANDOCERR_ROFFLOOP:
    meRoffloop
  of mandocerr_MANDOCERR_CHAR_BAD:
    meCharBad
  of mandocerr_MANDOCERR_MACRO:
    meMacro
  of mandocerr_MANDOCERR_REQ_NOMAC:
    meReqNomac
  of mandocerr_MANDOCERR_REQ_INSEC:
    meReqInsec
  of mandocerr_MANDOCERR_IT_STRAY:
    meItStray
  of mandocerr_MANDOCERR_TA_STRAY:
    meTaStray
  of mandocerr_MANDOCERR_BLK_NOTOPEN:
    meBlkNotopen
  of mandocerr_MANDOCERR_RE_NOTOPEN:
    meReNotopen
  of mandocerr_MANDOCERR_BLK_BROKEN:
    meBlkBroken
  of mandocerr_MANDOCERR_BLK_NOEND:
    meBlkNoend
  of mandocerr_MANDOCERR_NAMESC:
    meNamesc
  of mandocerr_MANDOCERR_ARG_UNDEF:
    meArgUndef
  of mandocerr_MANDOCERR_ARG_NONUM:
    meArgNonum
  of mandocerr_MANDOCERR_BD_FILE:
    meBdFile
  of mandocerr_MANDOCERR_BD_NOARG:
    meBdNoarg
  of mandocerr_MANDOCERR_BL_NOTYPE:
    meBlNotype
  of mandocerr_MANDOCERR_CE_NONUM:
    meCeNonum
  of mandocerr_MANDOCERR_CHAR_ARG:
    meCharArg
  of mandocerr_MANDOCERR_NM_NONAME:
    meNmNoname
  of mandocerr_MANDOCERR_OS_UNAME:
    meOsUname
  of mandocerr_MANDOCERR_ST_BAD:
    meStBad
  of mandocerr_MANDOCERR_IT_NONUM:
    meItNonum
  of mandocerr_MANDOCERR_SHIFT:
    meShift
  of mandocerr_MANDOCERR_SO_PATH:
    meSoPath
  of mandocerr_MANDOCERR_SO_FAIL:
    meSoFail
  of mandocerr_MANDOCERR_ARG_SKIP:
    meArgSkip
  of mandocerr_MANDOCERR_ARG_EXCESS:
    meArgExcess
  of mandocerr_MANDOCERR_DIVZERO:
    meDivzero
  of mandocerr_MANDOCERR_UNSUPP:
    meUnsupp
  of mandocerr_MANDOCERR_TOOLARGE:
    meToolarge
  of mandocerr_MANDOCERR_CHAR_UNSUPP:
    meCharUnsupp
  of mandocerr_MANDOCERR_ESC_UNSUPP:
    meEscUnsupp
  of mandocerr_MANDOCERR_REQ_UNSUPP:
    meReqUnsupp
  of mandocerr_MANDOCERR_WHILE_NEST:
    meWhileNest
  of mandocerr_MANDOCERR_WHILE_OUTOF:
    meWhileOutof
  of mandocerr_MANDOCERR_WHILE_INTO:
    meWhileInto
  of mandocerr_MANDOCERR_WHILE_FAIL:
    meWhileFail
  of mandocerr_MANDOCERR_TBLOPT_EQN:
    meTbloptEqn
  of mandocerr_MANDOCERR_TBLLAYOUT_MOD:
    meTbllayoutMod
  of mandocerr_MANDOCERR_TBLMACRO:
    meTblmacro
  of mandocerr_MANDOCERR_MAX:
    meMax
  
converter toMandocerrC*(en: Mandocerr): MandocerrC {.inline.} =
  arrMandocerrmapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_font`
# Declared in mandoc.h:273
proc mandocFont*(a1: cstring; sz: cint): MandocEsc {.importc: r"mandoc_font",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_font(ptr[const[char]], int): mandoc_esc]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_escape`
# Declared in mandoc.h:274
proc mandocEscape*(a1: cstringArray; a2: cstringArray; a3: ptr cint): MandocEsc {.
    importc: r"mandoc_escape", header: allHeaders.}
  ## @import{[[code:proc!mandoc_escape(ptr[ptr[const[char]]], ptr[ptr[const[char]]], ptr[int]): mandoc_esc]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_setoutfile`
# Declared in mandoc.h:275
proc mandocMsgSetoutfile*(a0: ptr FILE): void {.
    importc: r"mandoc_msg_setoutfile", header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_setoutfile(ptr[tkTypedef]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_getinfilename`
# Declared in mandoc.h:276
proc mandocMsgGetinfilename*(): cstring {.importc: r"mandoc_msg_getinfilename",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_getinfilename(): ptr[const[char]]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_setinfilename`
# Declared in mandoc.h:277
proc mandocMsgSetinfilename*(a0: cstring): void {.
    importc: r"mandoc_msg_setinfilename", header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_setinfilename(ptr[const[char]]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_getmin`
# Declared in mandoc.h:278
proc mandocMsgGetmin*(): Mandocerr {.importc: r"mandoc_msg_getmin",
                                     header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_getmin(): mandocerr]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_setmin`
# Declared in mandoc.h:279
proc mandocMsgSetmin*(a0: MandocerrC): void {.importc: r"mandoc_msg_setmin",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_setmin(mandocerr): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_getrc`
# Declared in mandoc.h:280
proc mandocMsgGetrc*(): Mandoclevel {.importc: r"mandoc_msg_getrc",
                                      header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_getrc(): mandoclevel]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg_setrc`
# Declared in mandoc.h:281
proc mandocMsgSetrc*(a0: MandoclevelC): void {.importc: r"mandoc_msg_setrc",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg_setrc(mandoclevel): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mandoc_msg`
# Declared in mandoc.h:282
proc mandocMsg*(a1: MandocerrC; a2: cint; a3: cint; a4: cstring): void {.
    varargs, importc: r"mandoc_msg", header: allHeaders.}
  ## @import{[[code:proc!mandoc_msg(mandocerr, int, int, ptr[const[char]]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_alloc`
# Declared in mandoc.h:284
proc mcharsAlloc*(): void {.importc: r"mchars_alloc", header: allHeaders.}
  ## @import{[[code:proc!mchars_alloc(): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_free`
# Declared in mandoc.h:285
proc mcharsFree*(): void {.importc: r"mchars_free", header: allHeaders.}
  ## @import{[[code:proc!mchars_free(): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_num2char`
# Declared in mandoc.h:286
proc mcharsNum2char*(a0: cstring; a1: SizeT): cint {.
    importc: r"mchars_num2char", header: allHeaders.}
  ## @import{[[code:proc!mchars_num2char(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_uc2str`
# Declared in mandoc.h:287
proc mcharsUc2str*(a0: cint): cstring {.importc: r"mchars_uc2str",
                                        header: allHeaders.}
  ## @import{[[code:proc!mchars_uc2str(int): ptr[const[char]]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_num2uc`
# Declared in mandoc.h:288
proc mcharsNum2uc*(a0: cstring; a1: SizeT): cint {.importc: r"mchars_num2uc",
    header: allHeaders.}
  ## @import{[[code:proc!mchars_num2uc(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_spec2cp`
# Declared in mandoc.h:289
proc mcharsSpec2cp*(a0: cstring; a1: SizeT): cint {.importc: r"mchars_spec2cp",
    header: allHeaders.}
  ## @import{[[code:proc!mchars_spec2cp(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mchars_spec2str`
# Declared in mandoc.h:290
proc mcharsSpec2str*(a0: cstring; a1: SizeT; a2: ptr SizeT): cstring {.
    importc: r"mchars_spec2str", header: allHeaders.}
  ## @import{[[code:proc!mchars_spec2str(ptr[const[char]], tkTypedef, ptr[tkTypedef]): ptr[const[char]]]]}


const
  arrMandocEscmapping: array[MandocEsc, tuple[name: string, cEnum: MandocEscC,
      cName: string, value: cint]] = [
    (name: "ESCAPE_ERROR", cEnum: mandocEsc_ESCAPE_ERROR,
     cName: "mandoc_esc::ESCAPE_ERROR", value: cint(0)),
    (name: "ESCAPE_UNSUPP", cEnum: mandocEsc_ESCAPE_UNSUPP,
     cName: "mandoc_esc::ESCAPE_UNSUPP", value: cint(1)),
    (name: "ESCAPE_IGNORE", cEnum: mandocEsc_ESCAPE_IGNORE,
     cName: "mandoc_esc::ESCAPE_IGNORE", value: cint(2)),
    (name: "ESCAPE_UNDEF", cEnum: mandocEsc_ESCAPE_UNDEF,
     cName: "mandoc_esc::ESCAPE_UNDEF", value: cint(3)),
    (name: "ESCAPE_SPECIAL", cEnum: mandocEsc_ESCAPE_SPECIAL,
     cName: "mandoc_esc::ESCAPE_SPECIAL", value: cint(4)),
    (name: "ESCAPE_FONT", cEnum: mandocEsc_ESCAPE_FONT,
     cName: "mandoc_esc::ESCAPE_FONT", value: cint(5)),
    (name: "ESCAPE_FONTBOLD", cEnum: mandocEsc_ESCAPE_FONTBOLD,
     cName: "mandoc_esc::ESCAPE_FONTBOLD", value: cint(6)),
    (name: "ESCAPE_FONTITALIC", cEnum: mandocEsc_ESCAPE_FONTITALIC,
     cName: "mandoc_esc::ESCAPE_FONTITALIC", value: cint(7)),
    (name: "ESCAPE_FONTBI", cEnum: mandocEsc_ESCAPE_FONTBI,
     cName: "mandoc_esc::ESCAPE_FONTBI", value: cint(8)),
    (name: "ESCAPE_FONTROMAN", cEnum: mandocEsc_ESCAPE_FONTROMAN,
     cName: "mandoc_esc::ESCAPE_FONTROMAN", value: cint(9)),
    (name: "ESCAPE_FONTCW", cEnum: mandocEsc_ESCAPE_FONTCW,
     cName: "mandoc_esc::ESCAPE_FONTCW", value: cint(10)),
    (name: "ESCAPE_FONTPREV", cEnum: mandocEsc_ESCAPE_FONTPREV,
     cName: "mandoc_esc::ESCAPE_FONTPREV", value: cint(11)),
    (name: "ESCAPE_NUMBERED", cEnum: mandocEsc_ESCAPE_NUMBERED,
     cName: "mandoc_esc::ESCAPE_NUMBERED", value: cint(12)),
    (name: "ESCAPE_UNICODE", cEnum: mandocEsc_ESCAPE_UNICODE,
     cName: "mandoc_esc::ESCAPE_UNICODE", value: cint(13)),
    (name: "ESCAPE_DEVICE", cEnum: mandocEsc_ESCAPE_DEVICE,
     cName: "mandoc_esc::ESCAPE_DEVICE", value: cint(14)),
    (name: "ESCAPE_BREAK", cEnum: mandocEsc_ESCAPE_BREAK,
     cName: "mandoc_esc::ESCAPE_BREAK", value: cint(15)),
    (name: "ESCAPE_NOSPACE", cEnum: mandocEsc_ESCAPE_NOSPACE,
     cName: "mandoc_esc::ESCAPE_NOSPACE", value: cint(16)),
    (name: "ESCAPE_HORIZ", cEnum: mandocEsc_ESCAPE_HORIZ,
     cName: "mandoc_esc::ESCAPE_HORIZ", value: cint(17)),
    (name: "ESCAPE_HLINE", cEnum: mandocEsc_ESCAPE_HLINE,
     cName: "mandoc_esc::ESCAPE_HLINE", value: cint(18)),
    (name: "ESCAPE_SKIPCHAR", cEnum: mandocEsc_ESCAPE_SKIPCHAR,
     cName: "mandoc_esc::ESCAPE_SKIPCHAR", value: cint(19)),
    (name: "ESCAPE_OVERSTRIKE", cEnum: mandocEsc_ESCAPE_OVERSTRIKE,
     cName: "mandoc_esc::ESCAPE_OVERSTRIKE", value: cint(20))]
proc toCInt*(en: MandocEsc): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrMandocEscmapping[en].value

proc toCInt*(en: set[MandocEsc]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrMandocEscmapping[val].value)

proc `$`*(en: MandocEscC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of mandocEsc_ESCAPE_ERROR:
    result = "mandoc_esc::ESCAPE_ERROR"
  of mandocEsc_ESCAPE_UNSUPP:
    result = "mandoc_esc::ESCAPE_UNSUPP"
  of mandocEsc_ESCAPE_IGNORE:
    result = "mandoc_esc::ESCAPE_IGNORE"
  of mandocEsc_ESCAPE_UNDEF:
    result = "mandoc_esc::ESCAPE_UNDEF"
  of mandocEsc_ESCAPE_SPECIAL:
    result = "mandoc_esc::ESCAPE_SPECIAL"
  of mandocEsc_ESCAPE_FONT:
    result = "mandoc_esc::ESCAPE_FONT"
  of mandocEsc_ESCAPE_FONTBOLD:
    result = "mandoc_esc::ESCAPE_FONTBOLD"
  of mandocEsc_ESCAPE_FONTITALIC:
    result = "mandoc_esc::ESCAPE_FONTITALIC"
  of mandocEsc_ESCAPE_FONTBI:
    result = "mandoc_esc::ESCAPE_FONTBI"
  of mandocEsc_ESCAPE_FONTROMAN:
    result = "mandoc_esc::ESCAPE_FONTROMAN"
  of mandocEsc_ESCAPE_FONTCW:
    result = "mandoc_esc::ESCAPE_FONTCW"
  of mandocEsc_ESCAPE_FONTPREV:
    result = "mandoc_esc::ESCAPE_FONTPREV"
  of mandocEsc_ESCAPE_NUMBERED:
    result = "mandoc_esc::ESCAPE_NUMBERED"
  of mandocEsc_ESCAPE_UNICODE:
    result = "mandoc_esc::ESCAPE_UNICODE"
  of mandocEsc_ESCAPE_DEVICE:
    result = "mandoc_esc::ESCAPE_DEVICE"
  of mandocEsc_ESCAPE_BREAK:
    result = "mandoc_esc::ESCAPE_BREAK"
  of mandocEsc_ESCAPE_NOSPACE:
    result = "mandoc_esc::ESCAPE_NOSPACE"
  of mandocEsc_ESCAPE_HORIZ:
    result = "mandoc_esc::ESCAPE_HORIZ"
  of mandocEsc_ESCAPE_HLINE:
    result = "mandoc_esc::ESCAPE_HLINE"
  of mandocEsc_ESCAPE_SKIPCHAR:
    result = "mandoc_esc::ESCAPE_SKIPCHAR"
  of mandocEsc_ESCAPE_OVERSTRIKE:
    result = "mandoc_esc::ESCAPE_OVERSTRIKE"
  
func toMandocEsc*(en: MandocEscC): MandocEsc {.inline.} =
  case en
  of mandocEsc_ESCAPE_ERROR:
    mscError
  of mandocEsc_ESCAPE_UNSUPP:
    mscUnsupp
  of mandocEsc_ESCAPE_IGNORE:
    mscIgnore
  of mandocEsc_ESCAPE_UNDEF:
    mscUndef
  of mandocEsc_ESCAPE_SPECIAL:
    mscSpecial
  of mandocEsc_ESCAPE_FONT:
    mscFont
  of mandocEsc_ESCAPE_FONTBOLD:
    mscFontbold
  of mandocEsc_ESCAPE_FONTITALIC:
    mscFontitalic
  of mandocEsc_ESCAPE_FONTBI:
    mscFontbi
  of mandocEsc_ESCAPE_FONTROMAN:
    mscFontroman
  of mandocEsc_ESCAPE_FONTCW:
    mscFontcw
  of mandocEsc_ESCAPE_FONTPREV:
    mscFontprev
  of mandocEsc_ESCAPE_NUMBERED:
    mscNumbered
  of mandocEsc_ESCAPE_UNICODE:
    mscUnicode
  of mandocEsc_ESCAPE_DEVICE:
    mscDevice
  of mandocEsc_ESCAPE_BREAK:
    mscBreak
  of mandocEsc_ESCAPE_NOSPACE:
    mscNospace
  of mandocEsc_ESCAPE_HORIZ:
    mscHoriz
  of mandocEsc_ESCAPE_HLINE:
    mscHline
  of mandocEsc_ESCAPE_SKIPCHAR:
    mscSkipchar
  of mandocEsc_ESCAPE_OVERSTRIKE:
    mscOverstrike
  
converter toMandocEscC*(en: MandocEsc): MandocEscC {.inline.} =
  arrMandocEscmapping[en].cEnum




proc toCInt*(en: MaAscii): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[MaAscii]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



