
{.push, warning[UnusedImport]: off.}


import
  std / bitops, hmisc / wrappers / wraphelp



export
  wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(743, 20)
  # Wrapper for `manpaths`
  # Declared in manconf.h:21
  Manpaths* {.bycopy, importc: "struct manpaths", header: allHeaders.} = object
    ## @import{[[code:struct!manpaths]]}
    paths* {.importc: "paths".}: cstringArray ## @import{[[code:struct!manpaths.field!paths]]}
    sz* {.importc: "sz".}: SizeT ## @import{[[code:struct!manpaths.field!sz]]}
    





# Declaration created in: hc_wrapgen.nim(457, 24)
# Wrapper for `manpaths`
# Declared in manconf.h:21
proc destroyManpaths*(obj: ptr Manpaths): void {.importc: r"#.~manpaths()",
    header: allHeaders.}
  ## @import{[[code:struct!manpaths]]}



# Declaration created in: hc_wrapgen.nim(468, 24)
# Wrapper for `manpaths`
# Declared in manconf.h:21
proc cnewManpaths*(): ptr Manpaths {.importc: r"new manpaths()",
                                     header: allHeaders.}
  ## @import{[[code:struct!manpaths]]}



# Declaration created in: hc_wrapgen.nim(476, 24)
# Wrapper for `manpaths`
# Declared in manconf.h:21
proc newManpaths*(): ref Manpaths =
  ## @import{[[code:struct!manpaths]]}
  newImportAux()
  new(result, proc (self: ref Manpaths) =
    destroyManpaths(addr self[]))
  {.emit: "new ((void*)result) manpaths(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(486, 24)
# Wrapper for `manpaths`
# Declared in manconf.h:21
proc initManpaths*(): Manpaths {.importc: r"{className}()", header: allHeaders.}
  ## @import{[[code:struct!manpaths]]}

