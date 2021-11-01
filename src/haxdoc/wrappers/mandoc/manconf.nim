
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./manconf_mansearch, ./main_manconf,
  ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  hmisc / wrappers / wraphelp



export
  wraphelp, main_manconf,
  main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl, manconf_mansearch




import
  mandoc_common





# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `manconf_parse`
# Declared in manconf.h:49
proc manconfParse*(a0: ptr Manconf; a1: cstring; a2: cstring; a3: cstring): void {.
    importc: r"manconf_parse", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[manconf], ptr[const[char]], ptr[char], ptr[char]): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `manconf_output`
# Declared in manconf.h:50
proc manconfOutput*(a0: ptr Manoutput; a1: cstring; a2: cint): cint {.
    importc: r"manconf_output", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[manoutput], ptr[const[char]], int): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `manconf_free`
# Declared in manconf.h:51
proc manconfFree*(a0: ptr Manconf): void {.importc: r"manconf_free",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[manconf]): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `manpath_base`
# Declared in manconf.h:52
proc manpathBase*(a0: ptr Manpaths): void {.importc: r"manpath_base",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[manpaths]): void]]}

