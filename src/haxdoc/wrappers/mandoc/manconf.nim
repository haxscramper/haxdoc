import
  hcparse / wraphelp, std / bitops, cstd / stddef, ./manconf_mansearch,
  ./main_manconf



export
  main_manconf, manconf_mansearch




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(776, 20)
  # Wrapper for `manconf`
  # Declared in manconf.h:43
  Manconf* {.bycopy, importc: "struct manconf", header: allHeaders.} = object
    ## @import{[[code:struct!manconf]]}
    output* {.importc: "output".}: Manoutput ## @import{[[code:struct!manconf.field!output]]}
    manpath* {.importc: "manpath".}: Manpaths ## @import{[[code:struct!manconf.field!manpath]]}
    





# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `manconf_parse`
# Declared in manconf.h:49
proc manconfParse*(a0: ptr Manconf; a1: cstring; a2: cstring; a3: cstring): void {.
    importc: r"manconf_parse", header: allHeaders.}
  ## @import{[[code:proc!manconf_parse(ptr[manconf], ptr[const[char]], ptr[char], ptr[char]): void]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `manconf_output`
# Declared in manconf.h:50
proc manconfOutput*(a0: ptr Manoutput; a1: cstring; a2: cint): cint {.
    importc: r"manconf_output", header: allHeaders.}
  ## @import{[[code:proc!manconf_output(ptr[manoutput], ptr[const[char]], int): int]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `manconf_free`
# Declared in manconf.h:51
proc manconfFree*(a0: ptr Manconf): void {.importc: r"manconf_free",
    header: allHeaders.}
  ## @import{[[code:proc!manconf_free(ptr[manconf]): void]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `manpath_base`
# Declared in manconf.h:52
proc manpathBase*(a0: ptr Manpaths): void {.importc: r"manpath_base",
    header: allHeaders.}
  ## @import{[[code:proc!manpath_base(ptr[manpaths]): void]]}



# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `manconf`
# Declared in manconf.h:43
proc cnewManconf*(): ptr Manconf {.importc: r"new manconf()", header: allHeaders.}
  ## @import{[[code:struct!manconf]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `manconf`
# Declared in manconf.h:43
proc destroyManconf*(obj: ptr Manconf): void {.importc: r"#.~manconf()",
    header: allHeaders.}
  ## @import{[[code:struct!manconf]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `manconf`
# Declared in manconf.h:43
proc newManconf*(): ref Manconf =
  ## @import{[[code:struct!manconf]]}
  newImportAux()
  new(result, proc (destr: ref Manconf) =
    destroyManconf(addr destr[]))
  {.emit: "new ((void*)result) manconf(); /* Placement new */".}


