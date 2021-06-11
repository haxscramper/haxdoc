type
  MdocData* = object
    data: pointer

# It is not possible to use libmandoc as a normal library - it is necessary
# to include *almost all* headers at once, as well as some things from
# sys/types.h like `FILE` etc.
const allHeaders* = """
#include <stdio.h>
#include <sys/types.h>

// clang-format off
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <mandoc_aux.h>
#include <mandoc.h>
#include <roff.h>
#include <mdoc.h>
#include <man.h>
#include <mandoc_parse.h>
#include <main.h>
#include <manconf.h>
#include <mansearch.h>
#include <tbl.h>
// clang-format on

// Mandatory things for libmandoc
"""
