import
  hcparse / wraphelp, std / bitops, cstd / stddef, file




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(776, 20)
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
    





# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc cnewManoutput*(): ptr Manoutput {.importc: r"new manoutput()",
                                       header: allHeaders.}
  ## @import{[[code:struct!manoutput]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc destroyManoutput*(obj: ptr Manoutput): void {.importc: r"#.~manoutput()",
    header: allHeaders.}
  ## @import{[[code:struct!manoutput]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `manoutput`
# Declared in manconf.h:28
proc newManoutput*(): ref Manoutput =
  ## @import{[[code:struct!manoutput]]}
  newImportAux()
  new(result, proc (destr: ref Manoutput) =
    destroyManoutput(addr destr[]))
  {.emit: "new ((void*)result) manoutput(); /* Placement new */".}


