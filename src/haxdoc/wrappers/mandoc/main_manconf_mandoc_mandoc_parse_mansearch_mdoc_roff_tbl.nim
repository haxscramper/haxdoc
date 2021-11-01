
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / stddef, hmisc / wrappers / wraphelp



export
  wraphelp, stddef




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `roff_man`
  # Declared in mdoc.h:20
  RoffMan* {.bycopy, importc: "struct roff_man", header: allHeaders.} = object
    ## @import{[[code:struct!roff_man]]}
    



  # Declaration created in: hc_wrapgen.nim(1222, 48)
  MaAscii* = enum
    maBreak = 29,             ## @import{[[code:cmacro!tkInvalid]]}
    maHyph = 30                ## @import{[[code:cmacro!tkInvalid]]}



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  MdocFont* = enum
    mfNone,                   ## @import{[[code:enum!mdoc_font.enumField!FONT__NONE]]}
    mfEm,                     ## @import{[[code:enum!mdoc_font.enumField!FONT_Em]]}
    mfLi,                     ## @import{[[code:enum!mdoc_font.enumField!FONT_Li]]}
    mfSy                       ## @import{[[code:enum!mdoc_font.enumField!FONT_Sy]]}



  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `mparse`
  # Declared in mandoc_parse.h:35
  Mparse* {.bycopy, importc: "struct mparse", header: allHeaders.} = object
    ## @import{[[code:struct!mparse]]}
    



  # Declaration created in: hc_wrapgen.nim(1262, 50)
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



  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `manconf`
  # Declared in manconf.h:43
  Manconf* {.bycopy, importc: "struct manconf", header: allHeaders.} = object
    ## @import{[[code:struct!manconf]]}
    output* {.importc: "output".}: Manoutput ## @import{[[code:struct!manconf.field!output]]}
    manpath* {.importc: "manpath".}: Manpaths ## @import{[[code:struct!manconf.field!manpath]]}
    



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mdoc_auth`
  # Declared in mdoc.h:100
  MdocAuthC* {.importc: "enum mdoc_auth", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_auth]]}
    mdocAuthAUTHNONE = 0, mdocAuthAUTHSplit = 1, mdocAuthAUTHNosplit = 2



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `tbl_cellt`
  # Declared in tbl.h:36
  TblCelltC* {.importc: "enum tbl_cellt", header: allHeaders.} = enum ## @import{[[code:enum!tbl_cellt]]}
    tblCelltTBLCELLCENTRE = 0, tblCelltTBLCELLRIGHT = 1, tblCelltTBLCELLLEFT = 2,
    tblCelltTBLCELLNUMBER = 3, tblCelltTBLCELLSPAN = 4, tblCelltTBLCELLLONG = 5,
    tblCelltTBLCELLDOWN = 6, tblCelltTBLCELLHORIZ = 7, tblCelltTBLCELLDHORIZ = 8,
    tblCelltTBLCELLMAX = 9



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  Argmode* = enum
    aFile,                    ## @import{[[code:enum!argmode.enumField!ARG_FILE]]}
    aName,                    ## @import{[[code:enum!argmode.enumField!ARG_NAME]]}
    aWord,                    ## @import{[[code:enum!argmode.enumField!ARG_WORD]]}
    aExpr                      ## @import{[[code:enum!argmode.enumField!ARG_EXPR]]}



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mdoc_disp`
  # Declared in mdoc.h:91
  MdocDispC* {.importc: "enum mdoc_disp", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_disp]]}
    mdocDispDISPNONE = 0, mdocDispDISPCentered = 1, mdocDispDISPRagged = 2,
    mdocDispDISPUnfilled = 3, mdocDispDISPFilled = 4, mdocDispDISPLiteral = 5



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mandoclevel`
  # Declared in mandoc.h:31
  MandoclevelC* {.importc: "enum mandoclevel", header: allHeaders.} = enum ## @import{[[code:enum!mandoclevel]]}
    mandoclevelMANDOCLEVELOK = 0, mandoclevelMANDOCLEVELSTYLE = 1,
    mandoclevelMANDOCLEVELWARNING = 2, mandoclevelMANDOCLEVELERROR = 3,
    mandoclevelMANDOCLEVELUNSUPP = 4, mandoclevelMANDOCLEVELBADARG = 5,
    mandoclevelMANDOCLEVELSYSERR = 6, mandoclevelMANDOCLEVELMAX = 7



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mandocerr`
  # Declared in mandoc.h:46
  MandocerrC* {.importc: "enum mandocerr", header: allHeaders.} = enum ## @import{[[code:enum!mandocerr]]}
    mandocerrMANDOCERROK = 0, mandocerrMANDOCERRBASE = 1,
    mandocerrMANDOCERRMDOCDATE = 2, mandocerrMANDOCERRMDOCDATEMISSING = 3,
    mandocerrMANDOCERRARCHBAD = 4, mandocerrMANDOCERROSARG = 5,
    mandocerrMANDOCERRRCSMISSING = 6, mandocerrMANDOCERRXRBAD = 7,
    mandocerrMANDOCERRSTYLE = 8, mandocerrMANDOCERRDATELEGACY = 9,
    mandocerrMANDOCERRDATENORM = 10, mandocerrMANDOCERRTITLECASE = 11,
    mandocerrMANDOCERRRCSREP = 12, mandocerrMANDOCERRSECTYPO = 13,
    mandocerrMANDOCERRARGQUOTE = 14, mandocerrMANDOCERRMACROUSELESS = 15,
    mandocerrMANDOCERRBX = 16, mandocerrMANDOCERRERORDER = 17,
    mandocerrMANDOCERRERREP = 18, mandocerrMANDOCERRDELIM = 19,
    mandocerrMANDOCERRDELIMNB = 20, mandocerrMANDOCERRFISKIP = 21,
    mandocerrMANDOCERRNFSKIP = 22, mandocerrMANDOCERRDASHDASH = 23,
    mandocerrMANDOCERRFUNC = 24, mandocerrMANDOCERRSPACEEOL = 25,
    mandocerrMANDOCERRCOMMENTBAD = 26, mandocerrMANDOCERRWARNING = 27,
    mandocerrMANDOCERRDTNOTITLE = 28, mandocerrMANDOCERRTHNOTITLE = 29,
    mandocerrMANDOCERRMSECMISSING = 30, mandocerrMANDOCERRMSECBAD = 31,
    mandocerrMANDOCERRDATEMISSING = 32, mandocerrMANDOCERRDATEBAD = 33,
    mandocerrMANDOCERRDATEFUTURE = 34, mandocerrMANDOCERROSMISSING = 35,
    mandocerrMANDOCERRPROLOGLATE = 36, mandocerrMANDOCERRPROLOGORDER = 37,
    mandocerrMANDOCERRSO = 38, mandocerrMANDOCERRDOCEMPTY = 39,
    mandocerrMANDOCERRSECBEFORE = 40, mandocerrMANDOCERRNAMESECFIRST = 41,
    mandocerrMANDOCERRNAMESECNONM = 42, mandocerrMANDOCERRNAMESECNOND = 43,
    mandocerrMANDOCERRNAMESECND = 44, mandocerrMANDOCERRNAMESECBAD = 45,
    mandocerrMANDOCERRNAMESECPUNCT = 46, mandocerrMANDOCERRNDEMPTY = 47,
    mandocerrMANDOCERRNDLATE = 48, mandocerrMANDOCERRSECORDER = 49,
    mandocerrMANDOCERRSECREP = 50, mandocerrMANDOCERRSECMSEC = 51,
    mandocerrMANDOCERRXRSELF = 52, mandocerrMANDOCERRXRORDER = 53,
    mandocerrMANDOCERRXRPUNCT = 54, mandocerrMANDOCERRANMISSING = 55,
    mandocerrMANDOCERRMACROOBS = 56, mandocerrMANDOCERRMACROCALL = 57,
    mandocerrMANDOCERRPARSKIP = 58, mandocerrMANDOCERRPARMOVE = 59,
    mandocerrMANDOCERRNSSKIP = 60, mandocerrMANDOCERRBLKNEST = 61,
    mandocerrMANDOCERRBDNEST = 62, mandocerrMANDOCERRBLMOVE = 63,
    mandocerrMANDOCERRTALINE = 64, mandocerrMANDOCERRBLKLINE = 65,
    mandocerrMANDOCERRBLKBLANK = 66, mandocerrMANDOCERRREQEMPTY = 67,
    mandocerrMANDOCERRCONDEMPTY = 68, mandocerrMANDOCERRMACROEMPTY = 69,
    mandocerrMANDOCERRBLKEMPTY = 70, mandocerrMANDOCERRARGEMPTY = 71,
    mandocerrMANDOCERRBDNOTYPE = 72, mandocerrMANDOCERRBLLATETYPE = 73,
    mandocerrMANDOCERRBLNOWIDTH = 74, mandocerrMANDOCERREXNONAME = 75,
    mandocerrMANDOCERRFONOHEAD = 76, mandocerrMANDOCERRITNOHEAD = 77,
    mandocerrMANDOCERRITNOBODY = 78, mandocerrMANDOCERRITNOARG = 79,
    mandocerrMANDOCERRBFNOFONT = 80, mandocerrMANDOCERRBFBADFONT = 81,
    mandocerrMANDOCERRPFSKIP = 82, mandocerrMANDOCERRRSEMPTY = 83,
    mandocerrMANDOCERRXRNOSEC = 84, mandocerrMANDOCERRARGSTD = 85,
    mandocerrMANDOCERROPEMPTY = 86, mandocerrMANDOCERRURNOHEAD = 87,
    mandocerrMANDOCERREQNNOBOX = 88, mandocerrMANDOCERRARGREP = 89,
    mandocerrMANDOCERRANREP = 90, mandocerrMANDOCERRBDREP = 91,
    mandocerrMANDOCERRBLREP = 92, mandocerrMANDOCERRBLSKIPW = 93,
    mandocerrMANDOCERRBLCOL = 94, mandocerrMANDOCERRATBAD = 95,
    mandocerrMANDOCERRFACOMMA = 96, mandocerrMANDOCERRFNPAREN = 97,
    mandocerrMANDOCERRLBBAD = 98, mandocerrMANDOCERRRSBAD = 99,
    mandocerrMANDOCERRSMBAD = 100, mandocerrMANDOCERRCHARFONT = 101,
    mandocerrMANDOCERRFTBAD = 102, mandocerrMANDOCERRTRODD = 103,
    mandocerrMANDOCERRFIBLANK = 104, mandocerrMANDOCERRFITAB = 105,
    mandocerrMANDOCERREOS = 106, mandocerrMANDOCERRESCBAD = 107,
    mandocerrMANDOCERRESCUNDEF = 108, mandocerrMANDOCERRSTRUNDEF = 109,
    mandocerrMANDOCERRTBLLAYOUTSPAN = 110, mandocerrMANDOCERRTBLLAYOUTDOWN = 111,
    mandocerrMANDOCERRTBLLAYOUTVERT = 112, mandocerrMANDOCERRERROR = 113,
    mandocerrMANDOCERRTBLOPTALPHA = 114, mandocerrMANDOCERRTBLOPTBAD = 115,
    mandocerrMANDOCERRTBLOPTNOARG = 116, mandocerrMANDOCERRTBLOPTARGSZ = 117,
    mandocerrMANDOCERRTBLLAYOUTNONE = 118, mandocerrMANDOCERRTBLLAYOUTCHAR = 119,
    mandocerrMANDOCERRTBLLAYOUTPAR = 120, mandocerrMANDOCERRTBLDATANONE = 121,
    mandocerrMANDOCERRTBLDATASPAN = 122, mandocerrMANDOCERRTBLDATAEXTRA = 123,
    mandocerrMANDOCERRTBLDATABLK = 124, mandocerrMANDOCERRFILE = 125,
    mandocerrMANDOCERRPROLOGREP = 126, mandocerrMANDOCERRDTLATE = 127,
    mandocerrMANDOCERRROFFLOOP = 128, mandocerrMANDOCERRCHARBAD = 129,
    mandocerrMANDOCERRMACRO = 130, mandocerrMANDOCERRREQNOMAC = 131,
    mandocerrMANDOCERRREQINSEC = 132, mandocerrMANDOCERRITSTRAY = 133,
    mandocerrMANDOCERRTASTRAY = 134, mandocerrMANDOCERRBLKNOTOPEN = 135,
    mandocerrMANDOCERRRENOTOPEN = 136, mandocerrMANDOCERRBLKBROKEN = 137,
    mandocerrMANDOCERRBLKNOEND = 138, mandocerrMANDOCERRNAMESC = 139,
    mandocerrMANDOCERRARGUNDEF = 140, mandocerrMANDOCERRARGNONUM = 141,
    mandocerrMANDOCERRBDFILE = 142, mandocerrMANDOCERRBDNOARG = 143,
    mandocerrMANDOCERRBLNOTYPE = 144, mandocerrMANDOCERRCENONUM = 145,
    mandocerrMANDOCERRCHARARG = 146, mandocerrMANDOCERRNMNONAME = 147,
    mandocerrMANDOCERROSUNAME = 148, mandocerrMANDOCERRSTBAD = 149,
    mandocerrMANDOCERRITNONUM = 150, mandocerrMANDOCERRSHIFT = 151,
    mandocerrMANDOCERRSOPATH = 152, mandocerrMANDOCERRSOFAIL = 153,
    mandocerrMANDOCERRARGSKIP = 154, mandocerrMANDOCERRARGEXCESS = 155,
    mandocerrMANDOCERRDIVZERO = 156, mandocerrMANDOCERRUNSUPP = 157,
    mandocerrMANDOCERRTOOLARGE = 158, mandocerrMANDOCERRCHARUNSUPP = 159,
    mandocerrMANDOCERRESCUNSUPP = 160, mandocerrMANDOCERRREQUNSUPP = 161,
    mandocerrMANDOCERRWHILENEST = 162, mandocerrMANDOCERRWHILEOUTOF = 163,
    mandocerrMANDOCERRWHILEINTO = 164, mandocerrMANDOCERRWHILEFAIL = 165,
    mandocerrMANDOCERRTBLOPTEQN = 166, mandocerrMANDOCERRTBLLAYOUTMOD = 167,
    mandocerrMANDOCERRTBLMACRO = 168, mandocerrMANDOCERRMAX = 169



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  Mandoclevel* = enum
    mlOk,                     ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_OK]]}
    mlStyle,                  ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_STYLE]]}
    mlWarning,                ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_WARNING]]}
    mlError,                  ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_ERROR]]}
    mlUnsupp,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_UNSUPP]]}
    mlBadarg,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_BADARG]]}
    mlSyserr,                 ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_SYSERR]]}
    mlMax                      ## @import{[[code:enum!mandoclevel.enumField!MANDOCLEVEL_MAX]]}



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `form`
  # Declared in mansearch.h:78
  FormC* {.importc: "enum form", header: allHeaders.} = enum ## @import{[[code:enum!form]]}
    formFORMSRC = 1, formFORMCAT = 2, formFORMNONE = 3



  # Declaration created in: hc_wrapgen.nim(1262, 50)
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



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mdoc_list`
  # Declared in mdoc.h:75
  MdocListC* {.importc: "enum mdoc_list", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_list]]}
    mdocListLISTNONE = 0, mdocListLISTBullet = 1, mdocListLISTColumn = 2,
    mdocListLISTDash = 3, mdocListLISTDiag = 4, mdocListLISTEnum = 5,
    mdocListLISTHang = 6, mdocListLISTHyphen = 7, mdocListLISTInset = 8,
    mdocListLISTItem = 9, mdocListLISTOhang = 10, mdocListLISTTag = 11,
    mdocListLISTMAX = 12



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `argmode`
  # Declared in mansearch.h:84
  ArgmodeC* {.importc: "enum argmode", header: allHeaders.} = enum ## @import{[[code:enum!argmode]]}
    argmodeARGFILE = 0, argmodeARGNAME = 1, argmodeARGWORD = 2, argmodeARGEXPR = 3



  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `manpage`
  # Declared in mansearch.h:91
  Manpage* {.bycopy, importc: "struct manpage", header: allHeaders.} = object
    ## @import{[[code:struct!manpage]]}
    file* {.importc: "file".}: cstring ## @import{[[code:struct!manpage.field!file]]}
    names* {.importc: "names".}: cstring ## @import{[[code:struct!manpage.field!names]]}
    output* {.importc: "output".}: cstring ## @import{[[code:struct!manpage.field!output]]}
    ipath* {.importc: "ipath".}: SizeT ## @import{[[code:struct!manpage.field!ipath]]}
    sec* {.importc: "sec".}: cint ## @import{[[code:struct!manpage.field!sec]]}
    form* {.importc: "form".}: FormC ## @import{[[code:struct!manpage.field!form]]}
    



  # Declaration created in: hc_wrapgen.nim(1262, 50)
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



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mdocargt`
  # Declared in mdoc.h:22
  MdocargtC* {.importc: "enum mdocargt", header: allHeaders.} = enum ## @import{[[code:enum!mdocargt]]}
    mdocargtMDOCSplit = 0, mdocargtMDOCNosplit = 1, mdocargtMDOCRagged = 2,
    mdocargtMDOCUnfilled = 3, mdocargtMDOCLiteral = 4, mdocargtMDOCFile = 5,
    mdocargtMDOCOffset = 6, mdocargtMDOCBullet = 7, mdocargtMDOCDash = 8,
    mdocargtMDOCHyphen = 9, mdocargtMDOCItem = 10, mdocargtMDOCEnum = 11,
    mdocargtMDOCTag = 12, mdocargtMDOCDiag = 13, mdocargtMDOCHang = 14,
    mdocargtMDOCOhang = 15, mdocargtMDOCInset = 16, mdocargtMDOCColumn = 17,
    mdocargtMDOCWidth = 18, mdocargtMDOCCompact = 19, mdocargtMDOCStd = 20,
    mdocargtMDOCFilled = 21, mdocargtMDOCWords = 22, mdocargtMDOCEmphasis = 23,
    mdocargtMDOCSymbolic = 24, mdocargtMDOCNested = 25, mdocargtMDOCCentred = 26,
    mdocargtMDOCARGMAX = 27



  # Declaration created in: hc_wrapgen.nim(744, 20)
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
    



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  TblDatt* = enum
    tdNone,                   ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NONE]]}
    tdData,                   ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_DATA]]}
    tdHoriz,                  ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_HORIZ]]}
    tdDhoriz,                 ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_DHORIZ]]}
    tdNhoriz,                 ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NHORIZ]]}
    tdNdhoriz                  ## @import{[[code:enum!tbl_datt.enumField!TBL_DATA_NDHORIZ]]}



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  MdocAuth* = enum
    maNone,                   ## @import{[[code:enum!mdoc_auth.enumField!AUTH__NONE]]}
    maSplit,                  ## @import{[[code:enum!mdoc_auth.enumField!AUTH_split]]}
    maNosplit                  ## @import{[[code:enum!mdoc_auth.enumField!AUTH_nosplit]]}



  # Declaration created in: hc_wrapgen.nim(1222, 48)
  TcTbl_cell* = enum
    tcCellTalign = 4,         ## @import{[[code:cmacro!tkInvalid]]}
    tcCellUp = 8,             ## @import{[[code:cmacro!tkInvalid]]}
    tcCellBalign = 16,        ## @import{[[code:cmacro!tkInvalid]]}
    tcCellWign = 32,          ## @import{[[code:cmacro!tkInvalid]]}
    tcCellEqual = 64,         ## @import{[[code:cmacro!tkInvalid]]}
    tcCellWmax = 128           ## @import{[[code:cmacro!tkInvalid]]}



  # Declaration created in: hc_wrapgen.nim(1262, 50)
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



  # Declaration created in: hc_wrapgen.nim(1222, 48)
  MpMparse* = enum
    mpMan = 2,                ## @import{[[code:cmacro!tkInvalid]]}
    mpSo = 4,                 ## @import{[[code:cmacro!tkInvalid]]}
    mpQuick = 8,              ## @import{[[code:cmacro!tkInvalid]]}
    mpUtF8 = 16,              ## @import{[[code:cmacro!tkInvalid]]}
    mpLatiN1 = 32,            ## @import{[[code:cmacro!tkInvalid]]}
    mpValidate = 64            ## @import{[[code:cmacro!tkInvalid]]}



  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `ohash`
  # Declared in roff.h:21
  Ohash* {.bycopy, importc: "struct ohash", header: allHeaders.} = object
    ## @import{[[code:struct!ohash]]}
    



  # Declaration created in: hc_wrapgen.nim(1222, 48)
  MnNode* = enum
    mnEnded = 2,              ## @import{[[code:cmacro!tkInvalid]]}
    mnBroken = 4,             ## @import{[[code:cmacro!tkInvalid]]}
    mnLine = 8,               ## @import{[[code:cmacro!tkInvalid]]}
    mnDelimo = 16,            ## @import{[[code:cmacro!tkInvalid]]}
    mnDelimc = 32,            ## @import{[[code:cmacro!tkInvalid]]}
    mnEos = 64,               ## @import{[[code:cmacro!tkInvalid]]}
    mnSynpretty = 128,        ## @import{[[code:cmacro!tkInvalid]]}
    mnNofill = 256,           ## @import{[[code:cmacro!tkInvalid]]}
    mnNosrc = 512,            ## @import{[[code:cmacro!tkInvalid]]}
    mnNoprt = 1024             ## @import{[[code:cmacro!tkInvalid]]}



  # Declaration created in: hc_wrapgen.nim(1262, 50)
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



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  Form* = enum
    fSrc,                     ## @import{[[code:enum!form.enumField!FORM_SRC]]}
    fCat,                     ## @import{[[code:enum!form.enumField!FORM_CAT]]}
    fNone                      ## @import{[[code:enum!form.enumField!FORM_NONE]]}



  # Declaration created in: hc_wrapgen.nim(744, 20)
  # Wrapper for `mansearch`
  # Declared in mansearch.h:100
  Mansearch* {.bycopy, importc: "struct mansearch", header: allHeaders.} = object
    ## @import{[[code:struct!mansearch]]}
    arch* {.importc: "arch".}: cstring ## @import{[[code:struct!mansearch.field!arch]]}
    sec* {.importc: "sec".}: cstring ## @import{[[code:struct!mansearch.field!sec]]}
    outkey* {.importc: "outkey".}: cstring ## @import{[[code:struct!mansearch.field!outkey]]}
    argmode* {.importc: "argmode".}: ArgmodeC ## @import{[[code:struct!mansearch.field!argmode]]}
    firstmatch* {.importc: "firstmatch".}: cint ## @import{[[code:struct!mansearch.field!firstmatch]]}
    



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `tbl_datt`
  # Declared in tbl.h:81
  TblDattC* {.importc: "enum tbl_datt", header: allHeaders.} = enum ## @import{[[code:enum!tbl_datt]]}
    tblDattTBLDATANONE = 0, tblDattTBLDATADATA = 1, tblDattTBLDATAHORIZ = 2,
    tblDattTBLDATADHORIZ = 3, tblDattTBLDATANHORIZ = 4, tblDattTBLDATANDHORIZ = 5



  # Declaration created in: hc_wrapgen.nim(1262, 50)
  MdocDisp* = enum
    mdNone,                   ## @import{[[code:enum!mdoc_disp.enumField!DISP__NONE]]}
    mdCentered,               ## @import{[[code:enum!mdoc_disp.enumField!DISP_centered]]}
    mdRagged,                 ## @import{[[code:enum!mdoc_disp.enumField!DISP_ragged]]}
    mdUnfilled,               ## @import{[[code:enum!mdoc_disp.enumField!DISP_unfilled]]}
    mdFilled,                 ## @import{[[code:enum!mdoc_disp.enumField!DISP_filled]]}
    mdLiteral                  ## @import{[[code:enum!mdoc_disp.enumField!DISP_literal]]}



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mdoc_font`
  # Declared in mdoc.h:106
  MdocFontC* {.importc: "enum mdoc_font", header: allHeaders.} = enum ## @import{[[code:enum!mdoc_font]]}
    mdocFontFONTNONE = 0, mdocFontFONTEm = 1, mdocFontFONTLi = 2,
    mdocFontFONTSy = 3



  # Declaration created in: hc_wrapgen.nim(1251, 50)
  # Wrapper for `mandoc_esc`
  # Declared in mandoc.h:248
  MandocEscC* {.importc: "enum mandoc_esc", header: allHeaders.} = enum ## @import{[[code:enum!mandoc_esc]]}
    mandocEscESCAPEERROR = 0, mandocEscESCAPEUNSUPP = 1,
    mandocEscESCAPEIGNORE = 2, mandocEscESCAPEUNDEF = 3,
    mandocEscESCAPESPECIAL = 4, mandocEscESCAPEFONT = 5,
    mandocEscESCAPEFONTBOLD = 6, mandocEscESCAPEFONTITALIC = 7,
    mandocEscESCAPEFONTBI = 8, mandocEscESCAPEFONTROMAN = 9,
    mandocEscESCAPEFONTCW = 10, mandocEscESCAPEFONTPREV = 11,
    mandocEscESCAPENUMBERED = 12, mandocEscESCAPEUNICODE = 13,
    mandocEscESCAPEDEVICE = 14, mandocEscESCAPEBREAK = 15,
    mandocEscESCAPENOSPACE = 16, mandocEscESCAPEHORIZ = 17,
    mandocEscESCAPEHLINE = 18, mandocEscESCAPESKIPCHAR = 19,
    mandocEscESCAPEOVERSTRIKE = 20




const
  arrFormmapping: array[Form, tuple[name: string, cEnum: FormC, cName: string,
                                    value: cint]] = [
    (name: "FORM_SRC", cEnum: form_FORM_SRC, cName: "form::FORM_SRC",
     value: cint(1)),
    (name: "FORM_CAT", cEnum: form_FORM_CAT, cName: "form::FORM_CAT",
     value: cint(2)),
    (name: "FORM_NONE", cEnum: form_FORM_NONE, cName: "form::FORM_NONE",
     value: cint(3))]
proc toCInt*(en: Form): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrFormmapping[en].value

proc toCInt*(en: set[Form]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrFormmapping[val].value)

proc `$`*(en: FormC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of form_FORM_SRC:
    result = "form::FORM_SRC"
  of form_FORM_CAT:
    result = "form::FORM_CAT"
  of form_FORM_NONE:
    result = "form::FORM_NONE"
  
func toForm*(en: FormC): Form {.inline.} =
  case en
  of form_FORM_SRC:
    fSrc
  of form_FORM_CAT:
    fCat
  of form_FORM_NONE:
    fNone
  
converter toFormC*(en: Form): FormC {.inline.} =
  arrFormmapping[en].cEnum




const
  arrArgmodemapping: array[Argmode, tuple[name: string, cEnum: ArgmodeC,
      cName: string, value: cint]] = [
    (name: "ARG_FILE", cEnum: argmode_ARG_FILE, cName: "argmode::ARG_FILE",
     value: cint(0)),
    (name: "ARG_NAME", cEnum: argmode_ARG_NAME, cName: "argmode::ARG_NAME",
     value: cint(1)),
    (name: "ARG_WORD", cEnum: argmode_ARG_WORD, cName: "argmode::ARG_WORD",
     value: cint(2)),
    (name: "ARG_EXPR", cEnum: argmode_ARG_EXPR, cName: "argmode::ARG_EXPR",
     value: cint(3))]
proc toCInt*(en: Argmode): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrArgmodemapping[en].value

proc toCInt*(en: set[Argmode]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrArgmodemapping[val].value)

proc `$`*(en: ArgmodeC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of argmode_ARG_FILE:
    result = "argmode::ARG_FILE"
  of argmode_ARG_NAME:
    result = "argmode::ARG_NAME"
  of argmode_ARG_WORD:
    result = "argmode::ARG_WORD"
  of argmode_ARG_EXPR:
    result = "argmode::ARG_EXPR"
  
func toArgmode*(en: ArgmodeC): Argmode {.inline.} =
  case en
  of argmode_ARG_FILE:
    aFile
  of argmode_ARG_NAME:
    aName
  of argmode_ARG_WORD:
    aWord
  of argmode_ARG_EXPR:
    aExpr
  
converter toArgmodeC*(en: Argmode): ArgmodeC {.inline.} =
  arrArgmodemapping[en].cEnum




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



