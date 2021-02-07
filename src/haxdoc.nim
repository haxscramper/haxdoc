import haxdoc/[docentry, compiler_aux, sourcetrail_nim]
import std/[
  json, strformat, strutils, sequtils, sugar, parseutils,
  hashes, md5, sets
]

import haxorg/[semorg, exporter_json, parser, ast, exporter_plaintext]

import hmisc/other/[colorlogger, oswrap, hjson, hcligen, hshell]
import hmisc/helpers
import hnimast
import hasts/graphviz_ast

import compiler/[trees, wordrecg, sighashes]


type
  DocContext = ref object of PPassContext
    db*: DocDB
    module*: PSym
    graph*: ModuleGraph

proc toJson*(doctype: DocType): JsonNode =
  toJson(doctype[])

# proc toJson*(doctext: DocText): JsonNode =
#   toJson(SemOrg(doctext))

proc toJson*(entry: DocEntry): JsonNode =
  result = toJson(entry[], @["doctextBriefPlain"])
  result["doctextBriefPlain"] = newJString(entry.doctextBriefPlain)

proc writeJson*(db: DocDB, target: AnyFile) =
  var buf: JsonNode = newJArray()
  for entry in db.entries:
    buf.add toJson(entry)

  let res = toPretty(buf, 100)
  echo res

  target.writeFile(res)


proc toDocType*(nt: NType[PNode]): DocType

proc toDocIdents*(idents: seq[NIdentDefs[PNode]]): seq[DocIdent] =
  for group in idents:
    for ident in group.idents:
      result.add DocIdent(
        ident: $ident,
        kind: group.kind,
        vtype: toDocType(group.vtype)
      )

proc toDocType*(nt: NType[PNode]): DocType =
  result = DocType(kind: nt.kind)
  case nt.kind:
    of ntkIdent, ntkGenericSpec, ntkAnonTuple:
      result.head = DocEntry(
        kind: dekObject,
        plainName: $nt.head,
        useKind: deuReference
      )

      result.genParams = nt.genParams.mapIt(toDocType(it))

    of ntkProc, ntkNamedTuple:
      result.returnType = nt.returnType.mapSomeIt(toDocType(it))
      result.arguments = nt.arguments.toDocIdents()
      # result.pragma = $nt.pragma.toNNode()

    of ntkRange:
      result.rngStart = $nt.rngStart
      result.rngEnd = $nt.rngEnd

    of ntkValue:
      result.value = $nt.value

    of ntkVarargs:
      result.vaType = toDocType(nt.vaType)
      result.vaConverter = nt.vaConverter.mapSomeIt($it)

    of ntkNone:
      discard

    of ntkCurly:
      discard

template joinIt*(arg: typed, expr: untyped, sep: string): untyped =
  mapIt(arg, expr).join(sep)


proc toSigText*(nt: DocType, procPrefix: string = "proc"): string

proc toSigText*(nt: DocIdent): string =
  &"{nt.ident}: {toSigText(nt.vtype)}"

proc toSigText*(nt: DocType, procPrefix: string = "proc"): string =
  case nt.kind:
    of ntkNone:
      result = ""

    of ntkValue:
      result = $nt.value

    of ntkVarargs:
      result = "varargs[" & toSigText(nt.vaType)
      if nt.vaConverter.isSome():
        result &= ", " & nt.vaConverter.get()

      result &= "]"


    of ntkIdent:
      if nt.genParams.len > 0:
        result = nt.head.docSym.get().declLink.plain &
          "[" & nt.genParams.mapIt(toSigText(it)).join(", ") & "]"

      else:
        result = $nt.head.docSym

    of ntkGenericSpec:
      result = nt.head.docSym.get().declLink.plain
      if nt.genParams.len > 0:
        result &= ": " & nt.genParams.mapIt(toSigText(it)).join(" | ")

    of ntkProc:
        var pragma: string
        if nt.pragmas.len > 0:
          pragma.add nt.pragmas.joinIt(
            it.entry.plainName & ": " & it.arg, ", ")

          if nt.effects.len > 0:
            if pragma.len > 0: pragma.add ", "

            pragma.add ".tags["
            pragma.add nt.effects.joinIt(it.plainName, ", ")
            pragma.add "]"

          if pragma.len > 0 and nt.raises.len > 0:
            if pragma.len > 0: pragma.add ", "

            pragma.add ".raises["
            pragma.add nt.raises.joinIt(it.plainName, ", ")
            pragma.add "]"


          # tern(nt.pragma.len > 0, nt.pragma & " ", "")

        let args: string = nt.arguments.mapIt(toSigText(it)).join(", ")
        let rtype: string = nt.returnType.getSomeIt(toSigText(it) & ": ", "")
        result = &"{procPrefix}({args}){pragma}{rtype}"

    of ntkAnonTuple:
      result = nt.genParams.mapIt(toSigText(it)).join(", ").wrap("()")

    of ntkNamedTuple:
      let args = collect(newSeq):
        for arg in nt.arguments:
          arg.ident & ": " & toSigText(arg.vtype)

      result = args.join(", ").wrap(("tuple[", "]"))

    of ntkRange:
      result = &"range[{nt.rngStart}..{nt.rngEnd}]"

    of ntkCurly:
      discard

proc toDocSym*(ctx: DocContext, sym: PSym): Option[DocSym] =
  if isNil(sym.ast):
    return

  proc aux(node: PNode): Option[DocSym] =
    case node.kind:
      of nkTypeDef:
        result = some(DocSym(declLink: CodeLink(
          plain: $node[0]
        )))

      of nkRefTy:
        result = aux(node[0])

      else:
        raiseImplementError($node.kind)

  return aux(sym.ast)

proc isEffectSym*(sym: PSym): bool =
  notNil(sym) and $sym == "RootEffect"

proc isRaiseSym*(sym: PSym): bool =
  notNil(sym) and $sym == "CatchableError"

proc detectSymKind*(sym: PSym): DocEntryKind =

  proc aux(node: PNode): DocEntryKind =
    case node.kind:
      of nkTypeDef:
        result = aux(node[2])

      of nkRefTy:
        result = aux(node[0])

      of nkObjectTy:
        result = aux(node[1])

      of nkOfInherit:
        let sym = node[0].sym
        if isEffectSym(sym):
          result = dekEffect

        elif isRaiseSym(sym):
          result = dekException

        else:
          result = dekObject

      else:
        raiseImplementError("")

  if isNil(sym):
    return dekObject

  else:
    return aux(sym.ast)


proc toDocEntry*(ctx: DocContext, node: PNode): DocEntry =
  let sym = toDocSym(ctx, node.sym)
  let kind = detectSymKind(node.sym)
  result = DocEntry(
    docSym: sym, kind: kind, plainName: $node, useKind: deuReference)



proc registerTopLevel(ctx: DocContext, n: PNode) =
  case n.kind:
    of nkProcDef:
      echo treeRepr(n)
      let parsed = parseProc(n)
      let node = parseOrg(parsed.docComment)

      echo treeRepr(node)
      var semNode = toSemOrgDocument(node)

      var admonitions: seq[(OrgBigIdentKind, SemOrg)]
      var metatags: seq[(SemMetaTag, SemOrg)]
      var doctext: seq[SemOrg]

      for elem in items(semNode[0]):
        case elem.kind:
          of onkList:
            var otherItems: seq[SemOrg]
            for item in items(elem):
              if item.itemTag.isSome():
                let itemTag = item.itemTag.get()
                case itemTag.kind:
                  of sitMeta:
                    metatags.add (itemTag.meta, onkStmtList.newSemOrg(
                      item["header"], item["body"]))

                  of sitBigIdent:
                    admonitions.add (itemTag.idKind, onkStmtList.newSemOrg(
                      item["header"], item["body"]))

                  of sitText:
                    otherItems.add item

              else:
                otherItems.add item

            if otherItems.len > 0:
              doctext.add onkList.newSemOrg(otherItems)

          else:
            doctext.add elem



      let sign = toDocType(parsed.signature)

      var decl = DocEntry(
        plainName: parsed.name,
        kind: dekProc,
        doctextBrief: tern(
          doctext.len > 0,
          onkStmtList.newSemOrg(doctext[0]),
          onkemptyNode.newSemorg()
        ),
        doctextBody: tern(
          doctext.len > 1,
          onkStmtList.newSemOrg(doctext[1..^1]),
          onkEmptyNode.newSemorg()
        ),
        admonitions: admonitions,
        prSigText: toSigText(
          sign,
          (
            case parsed.declType:
              of ptkProc: "proc"
              of ptkFunc: "func"
              of ptkIterator: "iterator"
              of ptkConverter: "converter"
              of ptkMethod: "method"
              of ptkTemplate: "template"
              of ptkMacro: "macro"

          ) & " " & parsed.name
        ),
        prSigTree: sign
      )

      # IMPLEMENT store effect annotations in proc declarations and link
      # with declaration for an effect type.
      block:
        let effectSpec = effectSpec(n[4], wTags)
        if notNil(effectSpec):
          for effect in effectSpec:
            decl.prSigTree.effects.add toDocEntry(ctx, effect)

      block:
        let raiseSpec = effectSpec(n[4], wRaises)
        if notNil(raiseSpec):
          for rais in raiseSpec:
            decl.prSigTree.raises.add toDocEntry(ctx, rais)


      exportTo(OrgPlaintextExporter(),
               decl.doctextBrief,
               decl.doctextBriefPlain)

      decl.doctextBriefPlain = strip(decl.doctextBriefPlain)



      ctx[].db.entries.add decl



    else:
      discard

proc docCompile(file: AbsFile = AbsFile("/tmp/intest.nim")) =
  file.writeFile("""

type
  Eff = ref object of RootEffect
  En {.pure.} = enum
    A

  EnObj = object
    case kind*: En
      of En.A: discard

proc hhh(arg: int) {.tags: Eff.} =
  ## Documentation for hhh
  ## - NOTE :: prints out "123"
  ## - @effect{IOEffect} :: Use stdout
  echo En.A

hhh(123)

""")


  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(file, ~".choosenim/toolchains/nim-1.4.0/lib")

  graph.registerPass(semPass)

  var db {.global.} = DocDB()

  graph.registerPass(makePass(
    (
      proc(graph: ModuleGraph, module: PSym): PPassContext {.nimcall.} =
        var context = DocContext(db: db)

        context.module = module
        context.graph = graph

        return context
    ),
    (
      proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
        result = n
        var ctx = DocContext(c)

        if sfMainModule in ctx.module.flags:
          registerToplevel(ctx, n)
    ),
    (
      proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
        discard
    )
  ))

  compileProject(graph)

  db.writeJson(RelFile("doc.json"))


proc getStdPath(): AbsDir =
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


proc handleTrailCmdline() =
  var infile: AbsFile
  var targetFile: AbsFile
  var otherpaths: seq[AbsDir]
  var stdpath: AbsDir

  for kind, key, val, idx in getopt():
    case kind
      of cmdArgument:
        if idx == 1:
          infile = toAbsFile(val)

      of cmdLongOption, cmdShortOption:
        case key
        of "help", "h":
          echo """
Usage

  haxdoc trail <file.nim> [--path:<dirname>...] [--stdpath:<dirname>] [--out:<file.srctrldb>]

Options

  - `--path:<dirname>` additional paths for module search

  - `--stdpath:<dirname>` location of stdlib. Defaults to search based on current
    compiler location

  - `--outdb:<file>` - Resulting sourcetrail database location. Defaults to original
    file name with extension changed.


- NOTE :: parseopt is used temporarily until `cligen` is fixed for C++ backen
"""

        of "path":
          otherpaths.add toAbsDir(val)

        of "out":
          targetFile = toAbsFile(val)
          if targetFile.ext != "srctrldb":
            err "Target file must have extension 'srctrldb', but found " &
              targetFile.ext

        of "stdpath":
          stdpath = toAbsDir(val)

        else:
          echo "Unexpected CLI argument '", key, "' use --help"
          quit 1

      of cmdEnd:
        discard

  if targetFile.string.len == 0:
    targetFile = infile.withExt("srctrldb")

  if stdpath.string.len == 0:
    stdpath = getStdPath()

  warn "Using stdlib path ", stdpath

  trailCompile(infile, stdpath, otherpaths, targetFile)

proc createCallgraph(infile: AbsFile, stdpath: AbsDir, outfile: AbsFile) =
  debug "Creating callgrahp"
  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(infile, stdpath,
    proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
      err msg
      err info, config.getFilePath(info)
  )
  graph.registerPass(semPass)

  var dotGraph {.global.}: DotGraph
  var knownSyms {.global.}: HashSet[Hash]
  var knownPairs {.global.}: HashSet[(Hash, Hash)]

  dotGraph.styleNode = makeRectConsolasNode()
  dotGraph.rankdir = grdLeftRight

  proc registerSym(sym: PSym): Hash {.nimcall.} =
    result = hash(sigHash(sym).MD5Digest)
    if result notin knownSyms:
      knownSyms.incl result

      let procDecl = parseProc(sym.ast)
      let sigText = toDocType(procDecl.signature).toSigText(procDecl.name)
      dotGraph.addNode makeDotNode(result, sigText)

  proc registerCalls(topId: Hash, node: PNode) {.nimcall.} =
    case node.kind:
      of nkProcDeclKinds:
        registerCalls(topId, node[6])

      of nkSym:
        if notNil(node.sym.ast) and
           node.sym.ast.kind in nkProcDeclKinds:
          let toHash = registerSym(node.sym)

          if (topId, toHash) notin knownPairs:
            dotGraph.addEdge makeDotEdge(topId, toHash)
            knownPairs.incl (topId, toHash)

      of nkTokenKinds - {nkSym}:
        discard

      else:
        for subnode in items(node):
          registerCalls(topId, subnode)

  graph.registerPass(makePass(
    (
      proc(graph: ModuleGraph, module: PSym): PPassContext {.nimcall.} =
        return PPassContext()
    ),
    (
      proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
        result = n
        if n.kind in nkProcDeclKinds:
          registerCalls(registerSym(n[0].sym), n)
    ),
    (
      proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
        discard
    )
  ))

  compileProject(graph)
  info "Callgraph compilation ok"

  let target = outfile.withExt("xdot")
  dotGraph.toXDot(target)
  info "Graphviz compilation ok"
  debug "Image saved to", target

proc getNimblePaths*(file: AbsFile): seq[AbsDir] =
  var nimbleDir: Option[AbsDir]

  block mainSearch:
    for dir in parentDirs(file):
      for file in walkDir(dir, AbsFile):
        if ext(file) == "nimble":
          nimbleDir = some(dir)
          break mainSearch

  if nimbleDir.isSome():
    info "Found nimble file in directory"
    debug nimbleDir.get()

  else:
    info "No nimble file found in parent directories"

when isMainModule:
  startColorLogger()

  if paramCount() == 0:
#     let file = AbsFile("/tmp/trail_test.nim")
#     file.writeFile("""

# import hmisc/algo/clformat123

# echo toRomanNumeral(1230)

# """)

    let file = AbsFile(~"tmp/Nim/compiler/nim.nim")

    case 0:
      of 0:
        trailCompile(
          file,
          ~"tmp/Nim/lib",
          # getStdPath(),
          @[],
          # getNimblePaths(file),
          file.withExt("srctrldb")
        )

      of 1:
        docCompile()

      else:
        discard

  else:
    case paramStr(0):
      of "trail":
        handleTrailCmdline()

      of "docgen":
        raiseImplementError("")

      of "callgraph":
        let file = toAbsFile(paramStr(1))
        createCallgraph(file, getStdPath(), file.withExt("png"))

      else:
        echo &"""
Unexpected haxdoc command - expected one of 'trail' or 'docgen', found

haxdoc {paramStr(0)}
"""
