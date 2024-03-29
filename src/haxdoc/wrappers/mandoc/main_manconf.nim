
{.push, warning[UnusedImport]: off.}


import
  std / bitops, hmisc / wrappers / wraphelp



export
  wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(743, 20)
  # Wrapper for `manoutput`
  # Declared in manconf.h:28
  Manoutput* {.bycopy, importc: "struct manoutput", header: allHeaders.} = object
    ## @import{[[code:struct!manoutput]]}
    includes* {.importc: "includes".}: cstring ## @import{[[code:struct!manoutput.field!includes]]}
    man* {.importc: "man".}: cstring ## @import{[[code:struct!manoutput.field!man]]}
    paper* {.importc: "paper".}: cstring ## @import{[[code:struct!manoutput.field!paper]]}
    style* {.importc: "style".}: cstring ## @import{[[code:struct!manoutput.field!style]]}
    tag* {.importc: "tag".}: cstring ## @import{[[code:struct!manoutput.field!tag]]}
    indent* {.importc: "indent".}: SizeT ## @import{[[code:struct!manoutput.field!indent]]}
    width* {.importc: "width".}: SizeT ## @import{[[code:struct!manoutput.field!width]]}
    fragment* {.importc: "fragment".}: cint ## @import{[[code:struct!manoutput.field!fragment]]}
    mdoc* {.importc: "mdoc".}: cint ## @import{[[code:struct!manoutput.field!mdoc]]}
    noval* {.importc: "noval".}: cint ## @import{[[code:struct!manoutput.field!noval]]}
    synopsisonly* {.importc: "synopsisonly".}: cint ## @import{[[code:struct!manoutput.field!synopsisonly]]}
    toc* {.importc: "toc".}: cint ## @import{[[code:struct!manoutput.field!toc]]}
    





# Declaration created in: hc_wrapgen.nim(457, 24)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc destroyManoutput*(obj: ptr Manoutput): void {.importc: r"#.~manoutput()",
    header: allHeaders.}
  ## @import{[[code:struct!manoutput]]}



# Declaration created in: hc_wrapgen.nim(468, 24)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc cnewManoutput*(): ptr Manoutput {.importc: r"new manoutput()",
                                       header: allHeaders.}
  ## @import{[[code:struct!manoutput]]}



# Declaration created in: hc_wrapgen.nim(476, 24)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc newManoutput*(): ref Manoutput =
  ## @import{[[code:struct!manoutput]]}
  newImportAux()
  new(result, proc (self: ref Manoutput) =
    destroyManoutput(addr self[]))
  {.emit: "new ((void*)result) manoutput(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(486, 24)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc initManoutput*(): Manoutput {.importc: r"{className}()", header: allHeaders.}
  ## @import{[[code:struct!manoutput]]}

