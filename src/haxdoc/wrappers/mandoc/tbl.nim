
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / stddef, ./mandoc_parse_roff_eqn_main_tbl_mdoc,
  hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(1258, 42)
  TcTbl_cell* = enum
    tcCellTalign = 4,         ## @import{[[code:cmacro!tkInvalid]]}
    tcCellUp = 8,             ## @import{[[code:cmacro!tkInvalid]]}
    tcCellBalign = 16,        ## @import{[[code:cmacro!tkInvalid]]}
    tcCellWign = 32,          ## @import{[[code:cmacro!tkInvalid]]}
    tcCellEqual = 64,         ## @import{[[code:cmacro!tkInvalid]]}
    tcCellWmax = 128           ## @import{[[code:cmacro!tkInvalid]]}




proc toCInt*(en: TcTbl_cell): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[TcTbl_cell]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



