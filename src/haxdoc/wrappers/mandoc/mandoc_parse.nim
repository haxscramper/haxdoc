
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./mandoc_parse_roff_eqn_main_tbl_mdoc,
  hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(796, 20)
  # Wrapper for `mparse`
  # Declared in mandoc_parse.h:35
  Mparse* {.bycopy, importc: "struct mparse", header: allHeaders.} = object
    ## @import{[[code:struct!mparse]]}
    



  # Declaration created in: hc_wrapgen.nim(1258, 42)
  MpMparse* = enum
    mpMan = 2,                ## @import{[[code:cmacro!tkInvalid]]}
    mpSo = 4,                 ## @import{[[code:cmacro!tkInvalid]]}
    mpQuick = 8,              ## @import{[[code:cmacro!tkInvalid]]}
    mpUtF8 = 16,              ## @import{[[code:cmacro!tkInvalid]]}
    mpLatiN1 = 32,            ## @import{[[code:cmacro!tkInvalid]]}
    mpValidate = 64            ## @import{[[code:cmacro!tkInvalid]]}





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `mparse`
# Declared in mandoc_parse.h:35
proc cnewMparse*(): ptr Mparse {.importc: r"new mparse()", header: allHeaders.}
  ## @import{[[code:struct!mparse]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `mparse`
# Declared in mandoc_parse.h:35
proc destroyMparse*(obj: ptr Mparse): void {.importc: r"#.~mparse()",
    header: allHeaders.}
  ## @import{[[code:struct!mparse]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `mparse`
# Declared in mandoc_parse.h:35
proc newMparse*(): ref Mparse =
  ## @import{[[code:struct!mparse]]}
  newImportAux()
  new(result, proc (destr: ref Mparse) =
    destroyMparse(addr destr[]))
  {.emit: "new ((void*)result) mparse(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_alloc`
# Declared in mandoc_parse.h:37
proc mparseAlloc*(a1: cint; a2: MandocOsC; a3: cstring): ptr Mparse {.
    importc: r"mparse_alloc", header: allHeaders.}
  ## @import{[[code:proc!mparse_alloc(int, mandoc_os, ptr[const[char]]): ptr[mparse]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_copy`
# Declared in mandoc_parse.h:38
proc mparseCopy*(a0: ptr Mparse): void {.importc: r"mparse_copy",
    header: allHeaders.}
  ## @import{[[code:proc!mparse_copy(ptr[mparse]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_free`
# Declared in mandoc_parse.h:39
proc mparseFree*(a0: ptr Mparse): void {.importc: r"mparse_free",
    header: allHeaders.}
  ## @import{[[code:proc!mparse_free(ptr[mparse]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_open`
# Declared in mandoc_parse.h:40
proc mparseOpenRaw*(a0: ptr Mparse; a1: cstring): cint {.
    importc: r"mparse_open", header: allHeaders.}
  ## @import{[[code:proc!mparse_open(ptr[mparse], ptr[const[char]]): int]]}



# Declaration created in: hc_impls.nim(104, 56)
# Wrapper for `mparse_open`
# Declared in mandoc_parse.h:40
proc mparseOpen*(a0: ptr Mparse; a1: cstring): cint =
  ## @import{[[code:proc!mparse_open(ptr[mparse], ptr[const[char]]): int]]}
  result = mparseOpenRaw(a0, a1)
  if result notin cint(0) .. cint(2147483647):
    var errMsg = "Return value of the mparse_open is not in valid range - expected [0 .. high(cint)], but got " &
        $result &
        ". Cannot open file. Arguments were \'"
    errMsg &= $(a1)
    errMsg &= "\'."
    raise newException(ValueError, errMsg)




# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_readfd`
# Declared in mandoc_parse.h:41
proc mparseReadfd*(a0: ptr Mparse; a1: cint; a2: cstring): void {.
    importc: r"mparse_readfd", header: allHeaders.}
  ## @import{[[code:proc!mparse_readfd(ptr[mparse], int, ptr[const[char]]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_reset`
# Declared in mandoc_parse.h:42
proc mparseReset*(a0: ptr Mparse): void {.importc: r"mparse_reset",
    header: allHeaders.}
  ## @import{[[code:proc!mparse_reset(ptr[mparse]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `mparse_result`
# Declared in mandoc_parse.h:43
proc mparseResult*(a1: ptr Mparse): ptr RoffMeta {.importc: r"mparse_result",
    header: allHeaders.}
  ## @import{[[code:proc!mparse_result(ptr[mparse]): ptr[roff_meta]]]}


proc toCInt*(en: MpMparse): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[MpMparse]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



