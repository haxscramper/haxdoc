**note**: *very* work-in-progress

Documentation generator and source code analysis system for nim.

<!-- # * Sourcetrail integration -->

<!-- # To generate sourcetrail compilation database for a file use ~./haxdoc trail -->
<!-- # file.nim~ - it will index *all* symbols that compiler saw during -->
<!-- # compilation: type definitinos, procedure declarations and uses (callgraph), -->
<!-- # uses of global variables, type fields and enums. -->

<!-- # Generated database can be opened using [[https://www.sourcetrail.com/][sourcetrail]] - free and open-source -->
<!-- # cross-platform source explorer. -->

<!-- # ** Troubleshooting and additional setup -->

<!-- # *** Syntax highlighting -->

<!-- # Sourcetrail does not come with built-in syntax highlighting for nim, so it -->
<!-- # is necessary to install it manually by putting ~assets/nim.rules~ in -->
<!-- # ~$HOME/.config/sourcetrail/syntax_highlighting_rules~ or -->
<!-- # ~/opt/sourcetrail/share/data/syntax_highlighting_rules~ -->

<!-- # *** compilation errors -->

<!-- # ~haxdoc~ uses nim compiler API to analyze your code, so it *must* be valid -->
<!-- # (i.e. you should be able to compile it yourself before trying to index it). -->

<!-- # Future plans include support for 'quick' analysis - only using parsing, but -->
<!-- # without semantic checking, but right now only /full/ analysis is performed. -->

<!-- # *** stdlib path -->

<!-- # For source code analysis it is necessary to have working stdlib -->
<!-- # installation (either via choosenim or any other method). By default -->
<!-- # chosenim version is used, so make sure you have it installed. Otherwise you -->
<!-- # can pass location of the stdlib installation via ~--stdpath~ flag. For -->
<!-- # example, to generate sourcetrail for nim compiler that comes with it's own -->
<!-- # version of the stdlib you would need to do (assuming compiler is cloned -->
<!-- # into ~Nim~ directory): -->

<!-- # #+begin_src bash -->
<!-- # haxdoc trail Nim/compiler/nim.nim --stdpath:Nim/lib -->
<!-- # #+end_src -->

<!-- # *** dependencies -->

<!-- # For packages that have external dependencies - ~haxdoc~ will try to infer -->
<!-- # correct list of dependencies and add all required paths. -->

<!-- # Right now I use -->
<!-- # reimplementation of nimble dependency resolution algorithm - it works, but -->
<!-- # ideally I would like to first get to -->
<!-- # https://github.com/nim-lang/nimble/issues/890, and make nimble have API for -->
<!-- # that one. -->


# Command-line tool

- [ ] Command-line tool to generate documentation in different formats
      (html/xml)

# Documentation extractor as-a-library

- [ ] Documentation extractor-as-a-libary. Provide API for writing
      documentation extraction, analysis and generation tools.
- [ ] Use unit tests as use examples for library.
- [ ] Extracting additional semantic information from haxorg documentation
      comments (metadata information like `@ingroup{}` annotations,
      documentation for comments, fields and so on).
- [ ] User-defined higlighting logic (special side effects, exceptions that
      developer might want to make accent on)
- [ ] Show resolved links in documentation in sourcetrail tool. Index
      `.org` (`.md`, `.rst` etc.) documents as well to allow full
      interoperability between source code in documentation. It is somewhat
      annoying that =sourcetrail= does not allow to open two split panes,
      or edit source code directly in the same window, but this could be
      mitigated with support for suchronization between editors and
      sourcetrail viewers.

# Static site generation for documentation

- [ ] Basic implementation of simple documentation - no pretty
      configuration, can be just bare HTML
- [ ] Search implementation - can use fulltext search like
      [flexsearch](https://github.com/nextapps-de/flexsearch) in addition
      to something closer to [hogle](https://hoogle.haskell.org/) for
      API/error search.

# Automatic change detection

- [ ] Automatic change detection for API/implementation
- [ ] Automatic changelog documentation
