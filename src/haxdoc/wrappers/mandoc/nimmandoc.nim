import make_wrap
import hmisc/other/oswrap

const dir = sourceDir / "mandoc-1.14.5"
const included = "-I" & $dir

{.passc: included.}
{.passc: "-lz".}
{.passl: "-lz".}

const compileFlags = ""

{.compile(dir /. "compat_err.c", compileFlags).}
{.compile(dir /. "mdoc_markdown.c", compileFlags).}
{.compile(dir /. "tbl_term.c", compileFlags).}
{.compile(dir /. "tbl_html.c", compileFlags).}
{.compile(dir /. "compat_strlcat.c", compileFlags).}
{.compile(dir /. "mandoc_aux.c", compileFlags).}
{.compile(dir /. "term_ps.c", compileFlags).}
{.compile(dir /. "man_html.c", compileFlags).}
{.compile(dir /. "roff_term.c", compileFlags).}
{.compile(dir /. "compat_getsubopt.c", compileFlags).}
{.compile(dir /. "mdoc_validate.c", compileFlags).}
{.compile(dir /. "msec.c", compileFlags).}
{.compile(dir /. "compat_isblank.c", compileFlags).}
{.compile(dir /. "man_macro.c", compileFlags).}
{.compile(dir /. "compat_reallocarray.c", compileFlags).}
{.compile(dir /. "att.c", compileFlags).}
{.compile(dir /. "mandoc.c", compileFlags).}
{.compile(dir /. "compat_strtonum.c", compileFlags).}
{.compile(dir /. "dbm.c", compileFlags).}
{.compile(dir /. "tbl_data.c", compileFlags).}
{.compile(dir /. "mdoc_macro.c", compileFlags).}
{.compile(dir /. "compat_strsep.c", compileFlags).}
{.compile(dir /. "dbm_map.c", compileFlags).}
{.compile(dir /. "tbl_layout.c", compileFlags).}
{.compile(dir /. "man_validate.c", compileFlags).}
{.compile(dir /. "mdoc.c", compileFlags).}
{.compile(dir /. "mdoc_argv.c", compileFlags).}
{.compile(dir /. "compat_strlcpy.c", compileFlags).}
{.compile(dir /. "read.c", compileFlags).}
{.compile(dir /. "mdoc_man.c", compileFlags).}
{.compile(dir /. "mdoc_state.c", compileFlags).}
{.compile(dir /. "eqn_term.c", compileFlags).}
{.compile(dir /. "dba_write.c", compileFlags).}
{.compile(dir /. "eqn.c", compileFlags).}
{.compile(dir /. "arch.c", compileFlags).}
{.compile(dir /. "mandoc_xr.c", compileFlags).}
{.compile(dir /. "dba_read.c", compileFlags).}
{.compile(dir /. "dba_array.c", compileFlags).}
{.compile(dir /. "out.c", compileFlags).}
{.compile(dir /. "tag.c", compileFlags).}
{.compile(dir /. "st.c", compileFlags).}
{.compile(dir /. "compat_recallocarray.c", compileFlags).}
{.compile(dir /. "dba.c", compileFlags).}
{.compile(dir /. "preconv.c", compileFlags).}
{.compile(dir /. "mandoc_ohash.c", compileFlags).}
{.compile(dir /. "compat_mkdtemp.c", compileFlags).}
{.compile(dir /. "compat_vasprintf.c", compileFlags).}
{.compile(dir /. "eqn_html.c", compileFlags).}
{.compile(dir /. "tbl_opts.c", compileFlags).}
{.compile(dir /. "compat_strcasestr.c", compileFlags).}
{.compile(dir /. "compat_fts.c", compileFlags).}
{.compile(dir /. "mdoc_html.c", compileFlags).}
{.compile(dir /. "mandoc_msg.c", compileFlags).}
{.compile(dir /. "term_ascii.c", compileFlags).}
{.compile(dir /. "man.c", compileFlags).}
{.compile(dir /. "term_tab.c", compileFlags).}
{.compile(dir /. "term.c", compileFlags).}
{.compile(dir /. "tree.c", compileFlags).}
{.compile(dir /. "tbl.c", compileFlags).}
{.compile(dir /. "chars.c", compileFlags).}
{.compile(dir /. "compat_stringlist.c", compileFlags).}
{.compile(dir /. "man_term.c", compileFlags).}
{.compile(dir /. "roff.c", compileFlags).}
{.compile(dir /. "roff_validate.c", compileFlags).}
{.compile(dir /. "compat_ohash.c", compileFlags).}
{.compile(dir /. "compat_progname.c", compileFlags).}
{.compile(dir /. "mansearch.c", compileFlags).}
{.compile(dir /. "lib.c", compileFlags).}
{.compile(dir /. "roff_html.c", compileFlags).}
{.compile(dir /. "mdoc_term.c", compileFlags).}
{.compile(dir /. "compat_getline.c", compileFlags).}
{.compile(dir /. "manpath.c", compileFlags).}
{.compile(dir /. "html.c", compileFlags).}
{.compile(dir /. "compat_strndup.c", compileFlags).}


import 
  ./mansearch, 
  ./mandoc_parse, 
  ./mandoc_aux, 
  ./mandoc,
  ./roff, 
  ./mdoc, 
  ./manconf, 
  ./main, 
  ./tbl

export
  mansearch, mandoc_parse, mandoc_aux, mandoc,
  roff, mdoc, manconf, main, tbl
