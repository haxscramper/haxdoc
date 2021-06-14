
{.push, warning[UnusedImport]: off.}


import
  hcparse / wraphelp, std / bitops, cstd / stddef,
  ./mandoc_parse_roff_eqn_main_tbl_mdoc



export
  mandoc_parse_roff_eqn_main_tbl_mdoc




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(1221, 42)
  TcTbl_cell* = enum
    tcCellTalign = 4,         ## @import{[[code:cmacro!TBL_CELL_TALIGN]]}
    tcCellUp = 8,             ## @import{[[code:cmacro!TBL_CELL_UP]]}
    tcCellBalign = 16,        ## @import{[[code:cmacro!TBL_CELL_BALIGN]]}
    tcCellWign = 32,          ## @import{[[code:cmacro!TBL_CELL_WIGN]]}
    tcCellEqual = 64,         ## @import{[[code:cmacro!TBL_CELL_EQUAL]]}
    tcCellWmax = 128           ## @import{[[code:cmacro!TBL_CELL_WMAX]]}




proc toCInt*(en: TcTbl_cell): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[TcTbl_cell]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)



