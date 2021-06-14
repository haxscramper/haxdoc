
{.push, warning[UnusedImport]: off.}


import
  hcparse / wraphelp, std / bitops, cstd / stddef,
  ./mandoc_parse_roff_eqn_main_tbl_mdoc



export
  mandoc_parse_roff_eqn_main_tbl_mdoc




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(776, 20)
  # Wrapper for `roff_man`
  # Declared in mdoc.h:20
  RoffMan* {.bycopy, importc: "struct roff_man", header: allHeaders.} = object
    ## @import{[[code:struct!roff_man]]}
    





# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `roff_man`
# Declared in mdoc.h:20
proc cnewRoffMan*(): ptr RoffMan {.importc: r"new roff_man()",
                                   header: allHeaders.}
  ## @import{[[code:struct!roff_man]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `roff_man`
# Declared in mdoc.h:20
proc destroyRoffMan*(obj: ptr RoffMan): void {.importc: r"#.~roff_man()",
    header: allHeaders.}
  ## @import{[[code:struct!roff_man]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `roff_man`
# Declared in mdoc.h:20
proc newRoffMan*(): ref RoffMan =
  ## @import{[[code:struct!roff_man]]}
  newImportAux()
  new(result, proc (destr: ref RoffMan) =
    destroyRoffMan(addr destr[]))
  {.emit: "new ((void*)result) roff_man(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mdoc_validate`
# Declared in mdoc.h:158
proc mdocValidate*(a0: ptr RoffMan): void {.importc: r"mdoc_validate",
    header: allHeaders.}
  ## @import{[[code:proc!mdoc_validate(ptr[roff_man]): void]]}

