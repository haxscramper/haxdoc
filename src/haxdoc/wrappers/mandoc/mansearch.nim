
{.push, warning[UnusedImport]: off.}


import
  hcparse / wraphelp, std / bitops, cstd / stddef, ./manconf_mansearch



export
  manconf_mansearch




import
  mandoc_common




type

  # Declaration created in: hc_wrapgen.nim(1262, 44)
  Argmode* = enum
    aFile,                    ## @import{[[code:enum!argmode.enumField!ARG_FILE]]}
    aName,                    ## @import{[[code:enum!argmode.enumField!ARG_NAME]]}
    aWord,                    ## @import{[[code:enum!argmode.enumField!ARG_WORD]]}
    aExpr                      ## @import{[[code:enum!argmode.enumField!ARG_EXPR]]}



  # Declaration created in: hc_wrapgen.nim(1250, 44)
  # Wrapper for `form`
  # Declared in mansearch.h:78
  FormC* {.importc: "enum form", header: allHeaders.} = enum ## @import{[[code:enum!form]]}
    form_FORM_SRC = 1, form_FORM_CAT = 2, form_FORM_NONE = 3



  # Declaration created in: hc_wrapgen.nim(1250, 44)
  # Wrapper for `argmode`
  # Declared in mansearch.h:84
  ArgmodeC* {.importc: "enum argmode", header: allHeaders.} = enum ## @import{[[code:enum!argmode]]}
    argmode_ARG_FILE = 0, argmode_ARG_NAME = 1, argmode_ARG_WORD = 2,
    argmode_ARG_EXPR = 3



  # Declaration created in: hc_wrapgen.nim(776, 20)
  # Wrapper for `manpage`
  # Declared in mansearch.h:91
  Manpage* {.bycopy, importc: "struct manpage", header: allHeaders.} = object
    ## @import{[[code:struct!manpage]]}
    file* {.importc: "file".}: cstring ## @import{[[code:struct!manpage.field!file]]}
    names* {.importc: "names".}: cstring ## @import{[[code:struct!manpage.field!names]]}
    output* {.importc: "output".}: cstring ## @import{[[code:struct!manpage.field!output]]}
    ipath* {.importc: "ipath".}: SizeT ## @import{[[code:struct!manpage.field!ipath]]}
    sec* {.importc: "sec".}: cint ## @import{[[code:struct!manpage.field!sec]]}
    form* {.importc: "form".}: FormC ## @import{[[code:struct!manpage.field!form]]}
    



  # Declaration created in: hc_wrapgen.nim(1262, 44)
  Form* = enum
    fSrc,                     ## @import{[[code:enum!form.enumField!FORM_SRC]]}
    fCat,                     ## @import{[[code:enum!form.enumField!FORM_CAT]]}
    fNone                      ## @import{[[code:enum!form.enumField!FORM_NONE]]}



  # Declaration created in: hc_wrapgen.nim(776, 20)
  # Wrapper for `mansearch`
  # Declared in mansearch.h:100
  Mansearch* {.bycopy, importc: "struct mansearch", header: allHeaders.} = object
    ## @import{[[code:struct!mansearch]]}
    arch* {.importc: "arch".}: cstring ## @import{[[code:struct!mansearch.field!arch]]}
    sec* {.importc: "sec".}: cstring ## @import{[[code:struct!mansearch.field!sec]]}
    outkey* {.importc: "outkey".}: cstring ## @import{[[code:struct!mansearch.field!outkey]]}
    argmode* {.importc: "argmode".}: ArgmodeC ## @import{[[code:struct!mansearch.field!argmode]]}
    firstmatch* {.importc: "firstmatch".}: cint ## @import{[[code:struct!mansearch.field!firstmatch]]}
    




const
  arrFormmapping: array[Form, tuple[name: string, cEnum: FormC, cName: string,
                                    value: cint]] = [
    (name: "FORM_SRC", cEnum: form_FORM_SRC, cName: "form::FORM_SRC",
     value: cint(1)),
    (name: "FORM_CAT", cEnum: form_FORM_CAT, cName: "form::FORM_CAT",
     value: cint(2)),
    (name: "FORM_NONE", cEnum: form_FORM_NONE, cName: "form::FORM_NONE",
     value: cint(3))]
proc toCInt*(en: Form): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrFormmapping[en].value

proc toCInt*(en: set[Form]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrFormmapping[val].value)

proc `$`*(en: FormC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of form_FORM_SRC:
    result = "form::FORM_SRC"
  of form_FORM_CAT:
    result = "form::FORM_CAT"
  of form_FORM_NONE:
    result = "form::FORM_NONE"
  
func toForm*(en: FormC): Form {.inline.} =
  case en
  of form_FORM_SRC:
    fSrc
  of form_FORM_CAT:
    fCat
  of form_FORM_NONE:
    fNone
  
converter toFormC*(en: Form): FormC {.inline.} =
  arrFormmapping[en].cEnum




const
  arrArgmodemapping: array[Argmode, tuple[name: string, cEnum: ArgmodeC,
      cName: string, value: cint]] = [
    (name: "ARG_FILE", cEnum: argmode_ARG_FILE, cName: "argmode::ARG_FILE",
     value: cint(0)),
    (name: "ARG_NAME", cEnum: argmode_ARG_NAME, cName: "argmode::ARG_NAME",
     value: cint(1)),
    (name: "ARG_WORD", cEnum: argmode_ARG_WORD, cName: "argmode::ARG_WORD",
     value: cint(2)),
    (name: "ARG_EXPR", cEnum: argmode_ARG_EXPR, cName: "argmode::ARG_EXPR",
     value: cint(3))]
proc toCInt*(en: Argmode): cint {.inline.} =
  ## Convert proxy enum to integer value
  arrArgmodemapping[en].value

proc toCInt*(en: set[Argmode]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, arrArgmodemapping[val].value)

proc `$`*(en: ArgmodeC): string {.inline.} =
  ## Return namespaced name of the original enum
  case en
  of argmode_ARG_FILE:
    result = "argmode::ARG_FILE"
  of argmode_ARG_NAME:
    result = "argmode::ARG_NAME"
  of argmode_ARG_WORD:
    result = "argmode::ARG_WORD"
  of argmode_ARG_EXPR:
    result = "argmode::ARG_EXPR"
  
func toArgmode*(en: ArgmodeC): Argmode {.inline.} =
  case en
  of argmode_ARG_FILE:
    aFile
  of argmode_ARG_NAME:
    aName
  of argmode_ARG_WORD:
    aWord
  of argmode_ARG_EXPR:
    aExpr
  
converter toArgmodeC*(en: Argmode): ArgmodeC {.inline.} =
  arrArgmodemapping[en].cEnum





# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `manpage`
# Declared in mansearch.h:91
proc cnewManpage*(): ptr Manpage {.importc: r"new manpage()", header: allHeaders.}
  ## @import{[[code:struct!manpage]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `manpage`
# Declared in mansearch.h:91
proc destroyManpage*(obj: ptr Manpage): void {.importc: r"#.~manpage()",
    header: allHeaders.}
  ## @import{[[code:struct!manpage]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `manpage`
# Declared in mansearch.h:91
proc newManpage*(): ref Manpage =
  ## @import{[[code:struct!manpage]]}
  newImportAux()
  new(result, proc (destr: ref Manpage) =
    destroyManpage(addr destr[]))
  {.emit: "new ((void*)result) manpage(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(423, 22)
# Wrapper for `mansearch`
# Declared in mansearch.h:100
proc cnewMansearch*(): ptr Mansearch {.importc: r"new mansearch()",
                                       header: allHeaders.}
  ## @import{[[code:struct!mansearch]]}



# Declaration created in: hc_wrapgen.nim(437, 22)
# Wrapper for `mansearch`
# Declared in mansearch.h:100
proc destroyMansearch*(obj: ptr Mansearch): void {.importc: r"#.~mansearch()",
    header: allHeaders.}
  ## @import{[[code:struct!mansearch]]}



# Declaration created in: hc_wrapgen.nim(447, 22)
# Wrapper for `mansearch`
# Declared in mansearch.h:100
proc newMansearch*(): ref Mansearch =
  ## @import{[[code:struct!mansearch]]}
  newImportAux()
  new(result, proc (destr: ref Mansearch) =
    destroyMansearch(addr destr[]))
  {.emit: "new ((void*)result) mansearch(); /* Placement new */".}




# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mansearch`
# Declared in mansearch.h:111
proc mansearch*(cfg: ptr Mansearch; paths: ptr Manpaths; argc: cint;
                argv: ptr cstring; res: ptr ptr Manpage; ressz: ptr SizeT): cint {.
    importc: r"mansearch", header: allHeaders.}
  ## @import{[[code:proc!mansearch(ptr[mansearch], ptr[manpaths], int, tkIncompleteArray, ptr[ptr[manpage]], ptr[tkTypedef]): int]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mansearch_free`
# Declared in mansearch.h:117
proc mansearchFree*(a0: ptr Manpage; a1: SizeT): void {.
    importc: r"mansearch_free", header: allHeaders.}
  ## @import{[[code:proc!mansearch_free(ptr[manpage], tkTypedef): void]]}

