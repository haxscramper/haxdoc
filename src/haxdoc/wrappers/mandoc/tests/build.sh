#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# bash
set -o nounset
set -o errexit

dir=../src/nimmandoc/mandoc-1.14.5

files=$(find $dir -name "*.c" |
            grep -v "test-" |
            grep -Ev "(cgi)|(main)|(mandocd)|(demandoc)" |
            grep -Ev "(catman)|(soelim)"
            xargs)

echo $files

clang \
    -Wno-macro-redefined \
    -Wno-implicit-function-declaration \
    -Wno-pointer-bool-conversion \
    -lz -I$dir $files tUsingC.c # $dir/demandoc.c # tUsingC.c $files

gunzip -c /usr/share/man/man3/write.3p.gz | ./a.out

# cat << EOF | ./a.out
# '\" et
# .TH WRITE "3P" 2017 "IEEE/The Open Group" "POSIX Programmer's Manual"
# .\"
# .SH PROLOG
# This manual page is part of the POSIX Programmer's Manual.
# The Linux implementation of this interface may differ (consult
# the corresponding Linux manual page for details of Linux behavior),
# or the interface may not be implemented on Linux.
# .\"
# .SH NAME
# pwrite,
# write
# \(em write on a file
# .SH SYNOPSIS
# .LP
# .nf
# #include <unistd.h>
# .P
# ssize_t pwrite(int \fIfildes\fP, const void *\fIbuf\fP, size_t \fInbyte\fP,
#     off_t \fIoffset\fP);
# ssize_t write(int \fIfildes\fP, const void *\fIbuf\fP, size_t \fInbyte\fP);
# .fi
# EOF
