import
  hcparse / wraphelp, std / bitops, ./mandoc_parse_roff_eqn_main_tbl_mdoc



export
  mandoc_parse_roff_eqn_main_tbl_mdoc




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(776, 20)
  # Wrapper for `ohash`
  # Declared in roff.h:21
  Ohash* {.bycopy, importc: "struct ohash", header: allHeaders.} = object
    ## @import{[[code:struct!ohash]]}
    



  # Declaration created in: hc_wrapgen.nim(1221, 42)
  MnNode* = enum
    mnEnded = 2,              ## @import{[[code:cmacro!NODE_ENDED]]}
    mnBroken = 4,             ## @import{[[code:cmacro!NODE_BROKEN]]}
    mnLine = 8,               ## @import{[[code:cmacro!NODE_LINE]]}
    mnDelimo = 16,            ## @import{[[code:cmacro!NODE_DELIMO]]}
    mnDelimc = 32,            ## @import{[[code:cmacro!NODE_DELIMC]]}
    mnEos = 64,               ## @import{[[code:cmacro!NODE_EOS]]}
    mnSynpretty = 128,        ## @import{[[code:cmacro!NODE_SYNPRETTY]]}
    mnNofill = 256,           ## @import{[[code:cmacro!NODE_NOFILL]]}
    mnNosrc = 512,            ## @import{[[code:cmacro!NODE_NOSRC]]}
    mnNoprt = 1024             ## @import{[[code:cmacro!NODE_NOPRT]]}





# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc cnewOhash*(): ptr Ohash {.importc: r"new ohash()", header: allHeaders.}
  ## @import{[[code:struct!ohash]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc destroyOhash*(obj: ptr Ohash): void {.importc: r"#.~ohash()",
    header: allHeaders.}
  ## @import{[[code:struct!ohash]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `ohash`
# Declared in roff.h:21
proc newOhash*(): ref Ohash =
  ## @import{[[code:struct!ohash]]}
  newImportAux()
  new(result, proc (destr: ref Ohash) =
    destroyOhash(addr destr[]))
  {.emit: "new ((void*)result) ohash(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `arch_valid`
# Declared in roff.h:551
proc archValid*(a0: cstring; a1: MandocOsC): cint {.importc: r"arch_valid",
    header: allHeaders.}
  ## @import{[[code:proc!arch_valid(ptr[const[char]], mandoc_os): int]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
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



