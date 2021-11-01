
{.push, warning[UnusedImport]: off.}


import
  std / bitops, cstd / types / FILE, cstd / stddef,
  ./main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl,
  hmisc / wrappers / wraphelp



export
  wraphelp, main_manconf_mandoc_mandoc_parse_mansearch_mdoc_roff_tbl




import
  mandoc_common




proc toCInt*(en: MaAscii): cint {.inline.} =
  ## Convert proxy enum to integer value
  cint(en.int)

proc toCInt*(en: set[MaAscii]): cint {.inline.} =
  ## Convert set of enums to bitmasked integer
  for val in en:
    result = bitor(result, val.cint)





# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_font`
# Declared in mandoc.h:273
proc mandocFont*(a1: cstring; sz: cint): MandocEsc {.importc: r"mandoc_font",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], int): mandoc_esc]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_escape`
# Declared in mandoc.h:274
proc mandocEscape*(a1: cstringArray; a2: cstringArray; a3: ptr cint): MandocEsc {.
    importc: r"mandoc_escape", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[ptr[const[char]]], ptr[ptr[const[char]]], ptr[int]): mandoc_esc]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_setoutfile`
# Declared in mandoc.h:275
proc mandocMsgSetoutfile*(a0: ptr FILE): void {.
    importc: r"mandoc_msg_setoutfile", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[tkTypedef]): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_getinfilename`
# Declared in mandoc.h:276
proc mandocMsgGetinfilename*(): cstring {.importc: r"mandoc_msg_getinfilename",
    header: allHeaders.}
  ## @import{[[code:proc!proc(): ptr[const[char]]]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_setinfilename`
# Declared in mandoc.h:277
proc mandocMsgSetinfilename*(a0: cstring): void {.
    importc: r"mandoc_msg_setinfilename", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]]): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_getmin`
# Declared in mandoc.h:278
proc mandocMsgGetmin*(): Mandocerr {.importc: r"mandoc_msg_getmin",
                                     header: allHeaders.}
  ## @import{[[code:proc!proc(): mandocerr]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_setmin`
# Declared in mandoc.h:279
proc mandocMsgSetmin*(a0: MandocerrC): void {.importc: r"mandoc_msg_setmin",
    header: allHeaders.}
  ## @import{[[code:proc!proc(mandocerr): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_getrc`
# Declared in mandoc.h:280
proc mandocMsgGetrc*(): Mandoclevel {.importc: r"mandoc_msg_getrc",
                                      header: allHeaders.}
  ## @import{[[code:proc!proc(): mandoclevel]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg_setrc`
# Declared in mandoc.h:281
proc mandocMsgSetrc*(a0: MandoclevelC): void {.importc: r"mandoc_msg_setrc",
    header: allHeaders.}
  ## @import{[[code:proc!proc(mandoclevel): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mandoc_msg`
# Declared in mandoc.h:282
proc mandocMsg*(a1: MandocerrC; a2: cint; a3: cint; a4: cstring): void {.
    varargs, importc: r"mandoc_msg", header: allHeaders.}
  ## @import{[[code:proc!proc(mandocerr, int, int, ptr[const[char]]): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_alloc`
# Declared in mandoc.h:284
proc mcharsAlloc*(): void {.importc: r"mchars_alloc", header: allHeaders.}
  ## @import{[[code:proc!proc(): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_free`
# Declared in mandoc.h:285
proc mcharsFree*(): void {.importc: r"mchars_free", header: allHeaders.}
  ## @import{[[code:proc!proc(): void]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_num2char`
# Declared in mandoc.h:286
proc mcharsNum2char*(a0: cstring; a1: SizeT): cint {.
    importc: r"mchars_num2char", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_uc2str`
# Declared in mandoc.h:287
proc mcharsUc2str*(a0: cint): cstring {.importc: r"mchars_uc2str",
                                        header: allHeaders.}
  ## @import{[[code:proc!proc(int): ptr[const[char]]]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_num2uc`
# Declared in mandoc.h:288
proc mcharsNum2uc*(a0: cstring; a1: SizeT): cint {.importc: r"mchars_num2uc",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_spec2cp`
# Declared in mandoc.h:289
proc mcharsSpec2cp*(a0: cstring; a1: SizeT): cint {.importc: r"mchars_spec2cp",
    header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], tkTypedef): int]]}



# Declaration created in: hc_wrapgen.nim(254, 28)
# Wrapper for `mchars_spec2str`
# Declared in mandoc.h:290
proc mcharsSpec2str*(a0: cstring; a1: SizeT; a2: ptr SizeT): cstring {.
    importc: r"mchars_spec2str", header: allHeaders.}
  ## @import{[[code:proc!proc(ptr[const[char]], tkTypedef, ptr[tkTypedef]): ptr[const[char]]]]}

