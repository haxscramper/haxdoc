
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / stddef, ./manconf_mansearch,
  ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  hmisc / wrappers / wraphelp



export
  wraphelp, main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  manconf_mansearch




import
  mandoc_common





# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mansearch`
# Declared in mansearch.h:111
proc mansearch*(cfg: ptr Mansearch; paths: ptr Manpaths; argc: cint;
                argv: ptr cstring; res: ptr ptr Manpage; ressz: ptr SizeT): cint {.
    importc: r"mansearch", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[mansearch], ptr[manpaths], int, tkIncompleteArray, ptr[ptr[manpage]], ptr[tkTypedef]): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mansearch_free`
# Declared in mansearch.h:117
proc mansearchFree*(a0: ptr Manpage; a1: SizeT): void {.
    importc: r"mansearch_free", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[manpage], tkTypedef): void]]}

