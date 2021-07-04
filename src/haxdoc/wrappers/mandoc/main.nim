
{.push, warning[UnusedImport]: off.}


import
  std / bitops, ./main_manconf, ./mandoc_parse_roff_eqn_main_tbl_mdoc,
  hmisc / wrappers / wraphelp



export
  mandoc_parse_roff_eqn_main_tbl_mdoc, wraphelp, main_manconf




import
  mandoc_common





# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `html_alloc`
# Declared in main.h:29
proc htmlAlloc*(a0: ptr Manoutput): pointer {.importc: r"html_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!html_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `html_mdoc`
# Declared in main.h:30
proc htmlMdoc*(a0: pointer; a1: ptr RoffMeta): void {.importc: r"html_mdoc",
    header: allHeaders.}
  ## @import{[[code:proc!html_mdoc(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `html_man`
# Declared in main.h:31
proc htmlMan*(a0: pointer; a1: ptr RoffMeta): void {.importc: r"html_man",
    header: allHeaders.}
  ## @import{[[code:proc!html_man(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `html_reset`
# Declared in main.h:32
proc htmlReset*(a0: pointer): void {.importc: r"html_reset", header: allHeaders.}
  ## @import{[[code:proc!html_reset(ptr[void]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `html_free`
# Declared in main.h:33
proc htmlFree*(a0: pointer): void {.importc: r"html_free", header: allHeaders.}
  ## @import{[[code:proc!html_free(ptr[void]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `tree_mdoc`
# Declared in main.h:35
proc treeMdoc*(a0: pointer; a1: ptr RoffMeta): void {.importc: r"tree_mdoc",
    header: allHeaders.}
  ## @import{[[code:proc!tree_mdoc(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `tree_man`
# Declared in main.h:36
proc treeMan*(a0: pointer; a1: ptr RoffMeta): void {.importc: r"tree_man",
    header: allHeaders.}
  ## @import{[[code:proc!tree_man(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `man_mdoc`
# Declared in main.h:38
proc manMdoc*(a0: pointer; a1: ptr RoffMeta): void {.importc: r"man_mdoc",
    header: allHeaders.}
  ## @import{[[code:proc!man_mdoc(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `locale_alloc`
# Declared in main.h:40
proc localeAlloc*(a0: ptr Manoutput): pointer {.importc: r"locale_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!locale_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `utf8_alloc`
# Declared in main.h:41
proc utf8Alloc*(a0: ptr Manoutput): pointer {.importc: r"utf8_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!utf8_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `ascii_alloc`
# Declared in main.h:42
proc asciiAlloc*(a0: ptr Manoutput): pointer {.importc: r"ascii_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!ascii_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `ascii_free`
# Declared in main.h:43
proc asciiFree*(a0: pointer): void {.importc: r"ascii_free", header: allHeaders.}
  ## @import{[[code:proc!ascii_free(ptr[void]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `pdf_alloc`
# Declared in main.h:45
proc pdfAlloc*(a0: ptr Manoutput): pointer {.importc: r"pdf_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!pdf_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `ps_alloc`
# Declared in main.h:46
proc psAlloc*(a0: ptr Manoutput): pointer {.importc: r"ps_alloc",
    header: allHeaders.}
  ## @import{[[code:proc!ps_alloc(ptr[manoutput]): ptr[void]]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `pspdf_free`
# Declared in main.h:47
proc pspdfFree*(a0: pointer): void {.importc: r"pspdf_free", header: allHeaders.}
  ## @import{[[code:proc!pspdf_free(ptr[void]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `terminal_mdoc`
# Declared in main.h:49
proc terminalMdoc*(a0: pointer; a1: ptr RoffMeta): void {.
    importc: r"terminal_mdoc", header: allHeaders.}
  ## @import{[[code:proc!terminal_mdoc(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `terminal_man`
# Declared in main.h:50
proc terminalMan*(a0: pointer; a1: ptr RoffMeta): void {.
    importc: r"terminal_man", header: allHeaders.}
  ## @import{[[code:proc!terminal_man(ptr[void], ptr[roff_meta]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `terminal_sepline`
# Declared in main.h:51
proc terminalSepline*(a0: pointer): void {.importc: r"terminal_sepline",
    header: allHeaders.}
  ## @import{[[code:proc!terminal_sepline(ptr[void]): void]]}



# Declaration created in: hc_wrapgen.nim(202, 28)
# Wrapper for `markdown_mdoc`
# Declared in main.h:53
proc markdownMdoc*(a0: pointer; a1: ptr RoffMeta): void {.
    importc: r"markdown_mdoc", header: allHeaders.}
  ## @import{[[code:proc!markdown_mdoc(ptr[void], ptr[roff_meta]): void]]}

