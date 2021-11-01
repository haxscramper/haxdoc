
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  ./mandoc_parse_roff_eqn_main_tbl_mdoc, hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, wraphelp,
  main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl




import
  mandoc_common




proc toCInt*(en: TcTbl_cell): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[TcTbl_cell]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



