import
  hcparse / wraphelp, std / bitops, cstd / stddef




import
  mandoc_common





# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_asprintf`
# Declared in mandoc_aux.h:19
proc mandocAsprintf*(a1: cstringArray; a2: cstring): cint {.varargs,
    importc: r"mandoc_asprintf", header: allHeaders.}
  ## @import{[[code:proc!mandoc_asprintf(ptr[ptr[char]], ptr[const[char]]): int]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_calloc`
# Declared in mandoc_aux.h:21
proc mandocCalloc*(a0: SizeT; a1: SizeT): pointer {.importc: r"mandoc_calloc",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_calloc(tkTypedef, tkTypedef): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_malloc`
# Declared in mandoc_aux.h:22
proc mandocMalloc*(a0: SizeT): pointer {.importc: r"mandoc_malloc",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_malloc(tkTypedef): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_realloc`
# Declared in mandoc_aux.h:23
proc mandocRealloc*(a0: pointer; a1: SizeT): pointer {.
    importc: r"mandoc_realloc", header: allHeaders.}
  ## @import{[[code:proc!mandoc_realloc(ptr[void], tkTypedef): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_reallocarray`
# Declared in mandoc_aux.h:24
proc mandocReallocarray*(a0: pointer; a1: SizeT; a2: SizeT): pointer {.
    importc: r"mandoc_reallocarray", header: allHeaders.}
  ## @import{[[code:proc!mandoc_reallocarray(ptr[void], tkTypedef, tkTypedef): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_recallocarray`
# Declared in mandoc_aux.h:25
proc mandocRecallocarray*(a0: pointer; a1: SizeT; a2: SizeT; a3: SizeT): pointer {.
    importc: r"mandoc_recallocarray", header: allHeaders.}
  ## @import{[[code:proc!mandoc_recallocarray(ptr[void], tkTypedef, tkTypedef, tkTypedef): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_strdup`
# Declared in mandoc_aux.h:26
proc mandocStrdup*(a0: cstring): cstring {.importc: r"mandoc_strdup",
    header: allHeaders.}
  ## @import{[[code:proc!mandoc_strdup(ptr[const[char]]): ptr[char]]]}



# Declaration created in: hc_wrapgen.nim(198, 28)
# Wrapper for `mandoc_strndup`
# Declared in mandoc_aux.h:27
proc mandocStrndup*(a0: cstring; a1: SizeT): cstring {.
    importc: r"mandoc_strndup", header: allHeaders.}
  ## @import{[[code:proc!mandoc_strndup(ptr[const[char]], tkTypedef): ptr[char]]]}

