
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./roff_mdoc,
  ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  ./mandoc_parse_roff_eqn_main_tbl_mdoc, hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, roff_mdoc, wraphelp,
  main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl




import
  mandoc_common





# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mdoc_validate`
# Declared in mdoc.h:158
proc mdocValidate*(a0: ptr RoffMan): void {.importc: r"mdoc_validate",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[roff_man]): void]]}

