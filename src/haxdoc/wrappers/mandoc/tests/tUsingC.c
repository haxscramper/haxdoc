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

#include "mandoc_aux.h"
#include "mandoc.h"
#include "roff.h"
#include "mdoc.h"
#include "man.h"
#include "mandoc_parse.h"
#include "main.h"
#include "manconf.h"
#include "mansearch.h"
// clang-format on


void tree_mdoc(void* arg, const struct roff_meta* mdoc);
void tree_man(void* arg, const struct roff_meta* mdoc);
void print_mdoc(const struct roff_node* n, int indent);


int main() {
    mchars_alloc();
    struct mparse* mp = mparse_alloc(
        MPARSE_SO | MPARSE_UTF8 | MPARSE_LATIN1 | MPARSE_VALIDATE,
        MANDOC_OS_OTHER,
        "linux");

    mparse_readfd(mp, STDIN_FILENO, "STDIN");
    struct roff_meta* meta = mparse_result(mp);

    if (meta == NULL) {
        puts("Meta is nil");
    } else {
        puts("tree_man >>>>>>>");
        tree_man(NULL, meta);
        if (meta->first->child == NULL) {
            puts("Meta first is nil");
        }


        /* puts("tree_mdoc >>>>>>>"); */
        /* tree_mdoc(NULL, meta); */
    }
}
