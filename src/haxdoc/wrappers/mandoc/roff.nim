
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  ./mandoc_parse_roff_eqn_main_tbl_mdoc, hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, wraphelp,
  main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl




import
  mandoc_common




proc toCInt*(en: MnNode): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[MnNode]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)





# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `arch_valid`
# Declared in roff.h:551
proc archValid*(a0: cstring; a1: MandocOsC): cint {.importc: r"arch_valid",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], mandoc_os): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `deroff`
# Declared in roff.h:552
proc deroff*(a0: cstringArray; a1: ptr RoffNode): void {.importc: r"deroff",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[ptr[char]], ptr[roff_node]): void]]}

