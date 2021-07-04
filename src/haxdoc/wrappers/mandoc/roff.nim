
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
  # Wrapper for `ohash`
  # Declared in roff.h:21
  Ohash* {.bycopy, importc: "struct ohash", header: allHeaders.} = object
    ## @import{[[code:struct!ohash]]}
    



  # Declaration created in: hc_wrapgen.nim(1258, 42)
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





# Declaration created in: hc_wrapgen.nim(441, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc cnewOhash*(): ptr Ohash {.importc: r"new ohash()", header: allHeaders.}
  ## @import{[[code:struct!ohash]]}



# Declaration created in: hc_wrapgen.nim(455, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc destroyOhash*(obj: ptr Ohash): void {.importc: r"#.~ohash()",
    header: allHeaders.}
  ## @import{[[code:struct!ohash]]}



# Declaration created in: hc_wrapgen.nim(465, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc newOhash*(): ref Ohash =
  ## @import{[[code:struct!ohash]]}
  newImportAux()
  new(result, proc (destr: ref Ohash) =
    destroyOhash(addr destr[]))
  {.emit: "new ((void*)result) ohash(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `arch_valid`
# Declared in roff.h:551
proc archValid*(a0: cstring; a1: MandocOsC): cint {.importc: r"arch_valid",
    header: allHeaders.}
  ## @import{[[code:proc!arch_valid(ptr[const[char]], mandoc_os): int]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `deroff`
# Declared in roff.h:552
proc deroff*(a0: cstringArray; a1: ptr RoffNode): void {.importc: r"deroff",
    header: allHeaders.}
  ## @import{[[code:proc!deroff(ptr[ptr[char]], ptr[roff_node]): void]]}


proc toCInt*(en: MnNode): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[MnNode]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



