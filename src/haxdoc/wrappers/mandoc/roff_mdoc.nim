
{.push, warning[UnusedImport]: off.}


import
  std / bitops, hmisc / wrappers / wraphelp



export
  wraphelp




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(743, 20)
  # Wrapper for `mdoc_argv`
  # Declared in mdoc.h:56
  MdocArgv* {.bycopy, importc: "struct mdoc_argv", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_argv]]}
    arg* {.importc: "arg".}: MdocargtC ## @import{[[code:struct!mdoc_argv.field!arg]]}
    line* {.importc: "line".}: cint ## @import{[[code:struct!mdoc_argv.field!line]]}
    pos* {.importc: "pos".}: cint ## @import{[[code:struct!mdoc_argv.field!pos]]}
    sz* {.importc: "sz".}: SizeT ## @import{[[code:struct!mdoc_argv.field!sz]]}
    value* {.importc: "value".}: cstringArray ## @import{[[code:struct!mdoc_argv.field!value]]}
    



  # Declaration created in: hc_wrapgen.nim(743, 20)
  # Wrapper for `mdoc_arg`
  # Declared in mdoc.h:69
  MdocArg* {.bycopy, importc: "struct mdoc_arg", header: allHeaders.} = object
    ## @import{[[code:struct!mdoc_arg]]}
    argc* {.importc: "argc".}: SizeT ## @import{[[code:struct!mdoc_arg.field!argc]]}
    argv* {.importc: "argv".}: ptr MdocArgv ## @import{[[code:struct!mdoc_arg.field!argv]]}
    refcnt* {.importc: "refcnt".}: cuint ## @import{[[code:struct!mdoc_arg.field!refcnt]]}
    





# Declaration created in: hc_wrapgen.nim(457, 24)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc destroyMdocArgv*(obj: ptr MdocArgv): void {.importc: r"#.~mdoc_argv()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_argv]]}



# Declaration created in: hc_wrapgen.nim(468, 24)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc cnewMdocArgv*(): ptr MdocArgv {.importc: r"new mdoc_argv()",
                                     header: allHeaders.}
  ## @import{[[code:struct!mdoc_argv]]}



# Declaration created in: hc_wrapgen.nim(476, 24)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc newMdocArgv*(): ref MdocArgv =
  ## @import{[[code:struct!mdoc_argv]]}
  newImportAux()
  new(result, proc (self: ref MdocArgv) =
    destroyMdocArgv(addr self[]))
  {.emit: "new ((void*)result) mdoc_argv(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(486, 24)
# Wrapper for `mdoc_argv`
# Declared in mdoc.h:56
proc initMdocArgv*(): MdocArgv {.importc: r"{className}()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_argv]]}



# Declaration created in: hc_wrapgen.nim(457, 24)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc destroyMdocArg*(obj: ptr MdocArg): void {.importc: r"#.~mdoc_arg()",
    header: allHeaders.}
  ## @import{[[code:struct!mdoc_arg]]}



# Declaration created in: hc_wrapgen.nim(468, 24)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc cnewMdocArg*(): ptr MdocArg {.importc: r"new mdoc_arg()",
                                   header: allHeaders.}
  ## @import{[[code:struct!mdoc_arg]]}



# Declaration created in: hc_wrapgen.nim(476, 24)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc newMdocArg*(): ref MdocArg =
  ## @import{[[code:struct!mdoc_arg]]}
  newImportAux()
  new(result, proc (self: ref MdocArg) =
    destroyMdocArg(addr self[]))
  {.emit: "new ((void*)result) mdoc_arg(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(486, 24)
# Wrapper for `mdoc_arg`
# Declared in mdoc.h:69
proc initMdocArg*(): MdocArg {.importc: r"{className}()", header: allHeaders.}
  ## @import{[[code:struct!mdoc_arg]]}

