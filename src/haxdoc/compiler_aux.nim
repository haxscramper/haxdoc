import hmisc/other/[colorlogger, oswrap, hshell]
import hmisc/helpers
import hmisc/types/[colortext]
import std/[parseutils]

export colorizeToStr

export colorlogger

import std/[with]

import compiler /
  [ idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    modules, condsyms, passaux, llstream, parser, nimblecmd
  ]

export idents, options, modulegraphs, passes, lineinfos, pathutils, sem,
    ast, modules, condsyms, passaux, llstream, parser

import compiler/astalgo except debug

export astalgo except debug

template debug*(node: PNode) {.dirty.} =
  log(lvlDebug, @[
    $instantiationInfo(),
    "\n",
    colorizeToStr($node, "nim")
  ])




proc getStdPath*(): AbsDir =
  var version = evalShellStdout shCmd(nim, --version)
  let start = "Nim Compiler Version ".len
  let finish = start + version.skipWhile({'0'..'9', '.'}, start)
  # debug version
  # debug start
  # debug finish
  version = version[start ..< finish]
  result = AbsDir(
    ~".choosenim/toolchains" / ("nim-" & version) / "lib"
    # nimlibs[0]
  )


proc newModuleGraph*(
    file: AbsFile,
    path: AbsDir,
    structuredErrorHook: proc(
      config: ConfigRef; info: TLineInfo; msg: string; level: Severity
    ) {.closure, gcsafe.} = nil
  ): ModuleGraph =

  var
    cache: IdentCache = newIdentCache()
    config: ConfigRef = newConfigRef()


  with config:
    libpath = AbsoluteDir(path)
    cmd = cmdIdeTools

  config.verbosity = 0
  config.options -= optHints
  config.searchPaths.add @[
    config.libpath,
    path / "pure",
    path / "pure" / "collections",
    path / "pure" / "concurrency",
    path / "impure",
    path / "std",
    path / "core",
    path / "posix",
    path / "wrappers",
    path / "wrappers" / "linenoise"
  ]

  config.projectFull = file
  # config.excludeAllNotes(hintLineTooLong)


  config.structuredErrorHook = structuredErrorHook
    # proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
    #   discard
    #   err msg

  wantMainModule(config)

  initDefines(config.symbols)
  defineSymbol(config.symbols, "nimcore")
  defineSymbol(config.symbols, "c")
  defineSymbol(config.symbols, "ssl")
  nimblePath(config, ~".nimble/pkgs", TLineInfo())

  info "Module import paths"
  logIndented:
    for path in items(config.searchPaths):
      debug path

  info "Nimble paths"
  logIndented:
    for path in items(config.nimblePaths):
      debug path

  return newModuleGraph(cache, config)

import nimblepkg/[common, packageinfo, version]
import std/[parsecfg, streams, tables, sets]
from std/options as std_opt import Option, none, some
import std/os as std_os

proc multiSplit(s: string): seq[string] =
  for chunk in split(s, {char(0x0A), char(0x0D), ','}):
    result.add chunk.strip()

  for i in countdown(result.len()-1, 0):
    if len(result[i]) < 1:
      result.del(i)

  if len(result) < 1:
    if s.strip().len != 0:
      return @[s]

    else:
      return @[]

# proc parseBinValue(str: string): string =
import fusion/matching

{.experimental: "caseStmtMacros".}

proc parsePackageInfoCfg*(
  text: string, path: string = "<file>"): Option[PackageInfo] =

  var fs = newStringStream(text)
  var p: CfgParser
  open(p, fs, path)
  defer: close(p)
  var currentSection = ""
  var res = initPackageInfo(path)
  while true:
    var ev = next(p)
    case ev.kind
      of cfgEof: return some(res)
      of cfgSectionStart: currentSection = ev.section
      of cfgKeyValuePair:
        case currentSection.normalize
          of "package":
            case ev.key.normalize
              of "name":         res.name        = ev.value
              of "version":      res.version     = ev.value
              of "author":       res.author      = ev.value
              of "description":  res.description = ev.value
              of "license":      res.license     = ev.value
              of "srcdir":       res.srcDir      = ev.value
              of "bindir":       res.binDir      = ev.value
              of "skipdirs":     res.skipDirs.add(ev.value.multiSplit)
              of "skipfiles":    res.skipFiles.add(ev.value.multiSplit)
              of "skipext":      res.skipExt.add(ev.value.multiSplit)
              of "installdirs":  res.installDirs.add(ev.value.multiSplit)
              of "installfiles": res.installFiles.add(ev.value.multiSplit)
              of "installext":   res.installExt.add(ev.value.multiSplit)
              of "bin":
                for i in ev.value.multiSplit:
                  var (src, bin) = if '=' notin i: (i, i) else:
                    let spl = i.split('=', 1)
                    (spl[0], spl[1])

                  if std_os.splitFile(src).ext == ".nim":
                    return

                  if res.backend == "js":
                    bin = bin.addFileExt(".js")

                  else:
                    bin = bin.addFileExt(ExeExt)

                  res.bin[bin] = src

              of "backend":
                res.backend = ev.value.toLowerAscii()
                case res.backend.normalize
                  of "javascript":
                    res.backend = "js"

                  else:
                    discard

              of "nimbletasks":
                for i in ev.value.multiSplit:
                  res.nimbleTasks.incl(i.normalize)

              of "beforehooks":
                for i in ev.value.multiSplit:
                  res.preHooks.incl(i.normalize)

              of "afterhooks":
                for i in ev.value.multiSplit:
                  res.postHooks.incl(i.normalize)

              else:
                return

          of "deps", "dependencies":
            case ev.key.normalize
              of "requires":
                for v in ev.value.multiSplit:
                  res.requires.add(parseRequires(v.strip))

              else:
                return
          else:
            return

      of cfgOption:
        return

      of cfgError:
        return


import hnimast/[pnode_parse], hnimast

type
  NimsParseFail* = ref object of ArgumentError

proc getStrValues(node: PNode): seq[string] =
  var values: seq[string]
  if (node.kind == nkPrefix and node[1].kind == nkBracket) or
     node.kind == nkBracket:

    let node = (if node.kind == nkPrefix: node[1] else: node)

    for arg in node:
      if arg.kind in ast.nkStrKinds:
        values.add arg.getStrVal()

      else:
        raise NimsParseFail(
          msg: "Cannot get item value from " & $node.kind)

  elif node.kind in ast.nkStrKinds:
    values.add node.getStrVal()

  elif node.kind in {nkIdent, nkCall, nkWhenStmt}:
    raise NimsParseFail(
      msg: "Cannot get property value from " & $node.kind)

  else:
    raiseImplementKindError(node, node.treeRepr())

  return values



proc parsePackageInfoNims*(
    text: string, path: string = "<file>"): Option[PackageInfo] =

  ##[
* TODO edge cases


#+begin_src nim
  namedBin["name"] = "expr" # nwnt
  version       = pkgVersion # fae

  # paravim
  installExt    = @[
    "nim", "txt", "ttf", "glsl", "c", "h",
    when defined(windows):
      "dll"
    elif defined(macosx):
      "dylib"
    elif defined(linux):
      "so"
  ]

  # metar
  include metar/version

  version = metarVersion

  # plz
  version     = CompileDate.replace("-", ".")
#+end_src

]##

  proc parseStmts(node: PNode, res: var PackageInfo) =
    case node.kind:
      of nkCommand, nkCall:
        if node[0].kind == nkDotExpr:
          if node[0][1].getStrVal() == "add":
            let values = node[1].getStrValues()
            case node[0][0].getStrVal().normalize:
              of "installext":   res.installExt.add   values
              of "skipdirs":     res.skipDirs.add     values
              of "installdirs":  res.installDirs.add  values
              of "skipext":      res.skipExt.add      values
              of "skipfiles":    res.skipFiles.add    values
              of "installfiles": res.installFiles.add values

          else:
            discard

        else:
          case node[0].getStrVal().normalize:
            of "requires":
              for arg in node[1 ..^ 1]:
                case arg.kind:
                  of hnimast.nkStrKinds:
                    for req in arg.getStrVal().multiSplit():
                      res.requires.add parseRequires(req)

                  of nkStmtList:
                    for dep in arg:
                      for req in dep.getStrVal().multiSplit():
                        res.requires.add parseRequires(req)

                  of nkIdent, nkExprEqExpr, nkInfix:
                    # Expr eq expr first encountered in `fision`
                    raise NimsParseFail(
                      msg: "Cannot get property requires from " & $arg.kind)

                  of nkPrefix:
                    for req1 in arg.getStrValues():
                      for req2 in req1.multiSplit():
                        res.requires.add parseRequires(req2)


                  else:
                    raiseImplementError(
                      "Unhandled node kind for requires argument: \n" &
                        treeRepr(arg))

            of "task": res.nimbleTasks.incl node[1].getStrVal()
            of "after": res.postHooks.incl node[1].getStrVal()
            of "before": res.postHooks.incl node[1].getStrVal()
            of "foreigndep": res.foreignDeps.add node[1].getStrVal()
            of "switch", "mkdir", "hint", "writefile", "exec":
              discard

            else:
              discard

      of nkAsgn:
        if node[0].kind == nkBracketExpr:
          let property = node[0][0].getStrVal().normalize
          case property:
            of "namedbin":
              res.bin[node[0][1].getStrVal()] = node[1].getStrValues()[0]

            else:
              discard

        elif node[0].kind == nkIdent:
          let property = node[0].getStrVal().normalize
          case property:
            of "version":
              case node[1].kind:
                of hnimast.nkStrKinds:
                  res.version = node[1].getStrVal()

                of nkDotExpr:
                  if node[1][1].getStrVal() == "NimVersion":
                    res.version = NimVersion

                  else:
                    raiseImplementError(
                      "Unhandled node structure: " & treeRepr(node[1]))

                of nkIdent, nkBracketExpr, nkCall, nkCommand:
                  raise NimsParseFail(
                    msg: "Cannot get version value from " &
                      $node[1].kind
                  )

                else:
                  raiseImplementError(
                    "Unhandled node structure: " & treeRepr(node[1]))


            of "license": res.license         = node[1].getStrValues()[0]
            of "description": res.description = node[1].getStrValues()[0]
            of "srcdir": res.srcDir           = node[1].getStrValues()[0]
            of "packagename": res.name        = node[1].getStrValues()[0]
            of "bindir": res.name             = node[1].getStrValues()[0]
            of "author": res.author           = node[1].getStrValues()[0]
            of "backend": res.backend         = node[1].getStrValues()[0]
            of "name": res.name               = node[1].getStrValues()[0]
            of "bin", "installext", "skipdirs", "installdirs", "skipext",
               "skipfiles", "installfiles"
                 :

              let values = node[1].getStrValues()

              case property:
                of "bin":
                  if values.len > 0:
                    res.bin[values[0]] = values[0]

                of "installext":   res.installExt   = values
                of "skipdirs":     res.skipDirs     = values
                of "installdirs":  res.installDirs  = values
                of "skipext":      res.skipExt      = values
                of "skipfiles":    res.skipFiles    = values
                of "installfiles": res.installFiles = values

            of "namedbin":
              var maps: seq[tuple[key, value: string]]

              case node[1]:
                of Call[DotExpr[TableConstr[all @args], _]]:
                  for pair in args:
                    res.bin[pair[0].getStrVal()] = pair[1].getStrVal()

                else:
                  echo node[1]
                  raiseImplementError(
                    "Unhandled node structure: \n" &
                      treeRepr(node[1], indexed = true))

            of "mode":
              discard
            else:
              err "Assignment to unknown property: " &
                  property & "\n" & treeRepr(node)

              raise NimsParseFail(
                msg: "Assignment to unknown property: " & property)

      of nkWhenStmt:
        for branch in node:
          case branch.kind:
            of nkElifBranch, nkElifExpr: parseStmts(branch[1], res)
            of nkElseExpr, nkElse: parseStmts(branch[0], res)
            else: raiseImplementError("Unhandled node structure: " & treeRepr(branch))

      of nkCommentStmt, nkImportStmt, nkFromStmt, nkIncludeStmt,
         nkConstSection, nkVarSection, nkLetSection, nkTypeSection,
         nkProcDeclKinds, nkLiteralKinds, nkDiscardStmt
           :
        discard

      of nkStmtList:
        for stmt in node:
          parseStmts(stmt, res)

      of nkIfStmt:
        # Information about foreign dependencies
        discard

      of nkPrefix, nkIdent, nkPragma:
        discard

      of nkBracket:
        # First found in https://github.com/h3rald/litestore/blob/b47f906761bf98c768d814ff124379ada24af6f6/litestore.nimble#L1
        discard

      else:
        raiseImplementError(
          "Unhandled configuration file element: \n" & treeRepr(node))




  var res = initPackageInfo(path)

  let node = parsePNodeStr(text)

  if isNil(node):
    return none(PackageInfo)

  for stmt in node:
    parseStmts(stmt, res)

  return some(res)

proc parsePackageInfo*(
    configText: string, path: AbsFile = AbsFile("<file>")): PackageInfo =

  var parseRes = parsePackageInfoCfg(configText)
  if parseRes.isSome():
    return parseRes.get()


  parseRes = parsePackageInfoNims(configText)
  if parseRes.isSome():
    return parseRes.get()

  else:
    raise newException(
      NimbleError,
      "Cannot parse package at path: " & $path
    )


proc getPackageInfo*(path: AbsFile): PackageInfo =
  let configText = readFile(path)
  return parsePackageInfo(configText, path)
