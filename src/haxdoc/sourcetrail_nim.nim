{.experimental: "caseStmtMacros".}

import compiler_aux
import std/[os, strformat, strutils, sequtils, macros]
import hmisc/other/[colorlogger, oswrap]
import hmisc/helpers
import hmisc/algo/htree_mapping
import hmisc/types/colorstring

import hnimast, hnimast/obj_field_macros
import fusion/matching
import nimtrail/nimtrail_common
import cxxstd/cxx_common


proc parsePNode(file: AbsFile): PNode =
  let cache: IdentCache = newIdentCache()
  let config: ConfigRef = newConfigRef()
  var pars: Parser

  pars.lex.errorHandler =
    proc(conf: ConfigRef; info: TLineInfo; msg: TMsgKind; arg: string) =
      warn msg

  openParser(
    p = pars,
    filename = file,
    inputStream = llStreamOpen(file, fmRead),
    cache = cache,
    config = config
  )

  result = parseAll(pars)
  closeParser(pars)



template excludeAllNotes(config: ConfigRef; n: typed) =
  config.notes.excl n
  when compiles(config.mainPackageNotes):
    config.mainPackageNotes.excl n
  when compiles(config.foreignPackageNotes):
    config.foreignPackageNotes.excl n

type
  SourcetrailContext = ref object of PPassContext
    writer: ptr SourcetrailDBWriter
    module: PSym
    graph: ModuleGraph

proc getFilePath(ctx: SourcetrailContext, node: PNode): AbsoluteFile =
  ctx.graph.getFilePath(node)

converter toSourcetrailSourceRange*(
  arg: tuple[fileId: cint, ranges: array[4, int16]]): SourcetrailSourceRange =

  assert arg.fileId > 0

  result.fileId = arg.fileId
  result.startLine = arg.ranges[0].cint
  result.startColumn = arg.ranges[1].cint
  result.endLine = arg.ranges[2].cint
  result.endColumn = arg.ranges[3].cint

proc typeHead(node: PNode): PNode =
  case node.kind:
    of nkSym: node
    of nkTypeDef: typeHead(node[0])
    of nkPragmaExpr: typeHead(node[0])
    else:
      raiseImplementKindError(node)

proc declHead(node: PNode): PNode =
  case node.kind:
    of nkRecCase, nkIdentDefs, nkProcDeclKinds, nkPragmaExpr,
       nkVarTy, nkBracketExpr, nkPrefix,
       nkDistinctTy, nkBracket
      :
      result = declHead(node[0])

    of nkRefTy, nkPtrTy:
      if node.len > 0:
        result = declHead(node[0])

      else:
        result = node

    of nkSym, nkIdent, nkEnumFieldDef, nkDotExpr,
       nkExprColonExpr, nkCall,
       nkRange, # WARNING
       nkEnumTy,
       nkProcTy,
       nkIteratorTy,
       nkTupleClassTy,
       nkLiteralKinds
      :
      result = node

    of nkPostfix, nkCommand
      :
      result = node[1]

    of nkInfix, nkPar:
      result = node[0]

    of nkTypeDef:
      let head = typeHead(node)
      doAssert head.kind == nkSym, head.treeRepr()
      result = head

    of nkObjectTy:
      result = node

    else:
      debug node.kind
      debug node
      err node.treeRepr()
      raiseImplementKindError(node)

converter toSourcetrailSourceRange*(
  arg: tuple[file: cint, name: PNode]): SourcetrailSourceRange =
  let head = arg.name.declHead()
  var loc = [
    arg.name.info.line.int16,
    arg.name.info.col + 1,
    arg.name.info.line.int16,
    arg.name.info.col + len($head).int16
  ]

  if head.kind in {nkSym, nkIdent}:
    if arg.name.kind == nkTypeDef:
      loc[1] -= len($head).int16 + 1
      loc[3] -= len($head).int16 + 1

    elif arg.name.kind == nkRecCase:
      warn "Adjust case field"
      loc[1] += 5
      loc[3] += 5



  result = toSourcetrailSourcerange((arg.file, loc))

proc recordNodeLocation(
  ctx: SourcetrailContext, nodeSymbolId: cint, node: PNode): cint =
  ## Record location of `nodeSymbolId` using positional information from
  ## `node`

  let filePath = ctx.graph.getFilePath(node).string
  let fileId = ctx.writer[].recordFile(filePath)
  discard ctx.writer[].recordFileLanguage(fileId, "nim")
  discard ctx.writer[].recordSymbolLocation(nodeSymbolId, (fileId, node))
  discard ctx.writer[].recordSymbolScopeLocation(nodeSymbolId, (fileId, node))

  return fileId



proc getProcId(writer: var SourcetrailDBWriter, procDecl: PProcDecl): cint =
  let returnType = procDecl.returnType().toNNode()
  let arguments = procDecl.arguments.mapIt($it.toNNode()).join(", ").wrap("()")
  return writer.recordSymbol(sskFunction, ($returnType, procDecl.name, arguments))

proc registerCalls(
    ctx: SourcetrailContext,
    node: PNode,
    fileId, callerId: cint,
    parent: PNode
  ) =
  assert fileId > 0


  case node.kind:
    of nkSym:
      if node.sym.kind in routineKinds:
        if
         (not node.sym.ast.isNil) and
         (node.sym.ast.kind notin {nkDo, nkLambda}):
          let parsed =
            try:
              parseProc(node.sym.ast)
            except ImplementError:
              echo node.sym.ast.treeRepr
              echo node.kind
              echo node.sym.kind
              echo node.sym.ast
              raise

          let referencedSymbol = ctx.writer[].getProcId(parsed)

          let referenceId = ctx.writer[].recordReference(
            callerId, referencedSymbol, srkCall)

          discard ctx.writer[].recordReferenceLocation(referenceId, (fileId, node))

        else:
          if isNil(node.sym.ast):
            discard

      elif node.sym.kind in {skParam, skForVar, skVar, skResult,
                              skLet, skConst}:
        let owner = node.sym.owner
        if owner.isNil or owner.kind notin {skModule}:
          let localId = ctx.writer[].recordLocalSymbol($node.sym)
          discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, node))

        else:
          let reference = ctx.writer[].recordReference(
            callerId,
            ctx.writer[].recordSymbol(sskGlobalVariable, [
              ("", split($owner, '@')[0], ""),
              ("", $node, "")]
            ),
            srkUsage
          )

          discard ctx.writer[].recordReferenceLocation(
            reference, (fileId, node))


      elif node.sym.kind in {skField, skEnumField}:
        if node.sym.owner.notNil:
          let path = [
            ("", split($node.sym.owner, '@')[0], ""), ("", $node, "")]

          let referencedSymbol = ctx.writer[].recordSymbol(
            tern(node.sym.kind == skField, sskField, sskEnumConstant),
            path
          )

          let referenceId = ctx.writer[].recordReference(
            callerId, referencedSymbol, srkUsage)

          var rng = toSourcetrailSourceRange(
            (fileId, tern(node.sym.kind == skField, parent, node)))

          if node.sym.kind == skField:
            inc rng.startColumn
            rng.endColumn = rng.startColumn + cint(len($node))

          discard ctx.writer[].recordReferenceLocation(referenceId, rng)

        else:
          warn "No owner for node ", node


      elif node.sym.kind in {skType}:
        let reference = ctx.writer[].recordReference(
          callerId,
          ctx.writer[].recordSymbol(sskType, [("", $node, "")]),
          srkTypeUsage
        )

        discard ctx.writer[].recordReferenceLocation(reference, (fileId, node))

      elif node.sym.kind in {skLabel, skUnknown, skModule, skTemp}:
        discard

      else:
        warn "Skipping symbol of kind", node.sym.kind, "at", node.getInfo()


    of nkLiteralKinds - {nkIntLit}, nkIdent:
      discard

    of nkIntLit:
      if notNil(node.typ) and
         notNil(node.typ.sym) and
         notNil(node.typ.sym.ast):

        let path = [("", $node.typ.sym.ast[0], ""), ("", $node, "")]
        let referencedSymbol = ctx.writer[].recordSymbol(sskEnumConstant, path)
        let referenceId = ctx.writer[].recordReference(
          callerId, referencedSymbol, srkUsage)

        discard ctx.writer[].recordReferenceLocation(
          referenceId, (fileId, node))
    else:
      for subnode in mitems(node.sons):
        ctx.registerCalls(subnode, fileId, callerId, node)




proc registerTypeUse(
    ctx: SourcetrailContext, userId, fileId: cint, ntype: NType) =
  if ntype.kind in {ntkIdent, ntkGenericSpec} and
     ntype.declNode.isSome() and
     (
       (ntype.head notin ["ref", "ptr", "sink", "owned", "out", "distinct"]) or
       (ntype.genParams.len == 0)
     )
    :
    # FIXME register generic arguments as local symbols intead of
    # declaring new types like `T`
    let path = [("", ntype.head, "")]
    let reference = ctx.writer[].recordReference(
      userId,
      ctx.writer[].recordSymbol(sskType, path),
      srkTypeUsage
    )

    let node = declHead(ntype.declNode.get())
    let rng = toSourcetrailSourceRange((fileId, node))

    discard ctx.writer[].recordReferenceLocation(reference, rng)

  let direct = directUsedTypes(ntype)
  for used in direct:
    registerTypeUse(ctx, userId, fileId, used)




proc registerProcDef(ctx: SourcetrailContext, fileId: cint, procDef: PNode): cint =
  let procDecl = parseProc(procDef)
  if isNil(procDecl.impl) or procDecl.impl.kind == nkEmpty:
    return

  result = ctx.writer[].getProcId(procDecl)

  let fileId = ctx.recordNodeLocation(result, procDef)

  for argument in argumentIdents(procDecl):
    let localId = ctx.writer[].recordLocalSymbol($argument.sym)
    discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, argument))

  registerTypeUse(ctx, result, fileId, procDecl.signature)

  logIndented:
    ctx.registerCalls(procDecl.impl, fileId, result, nil)

        # for branch in it.branches:
        #   if not branch.isElse:
        #     result.add branch.ofValue

proc setValues(node: PNode): seq[PNode] =
  case node.kind:
    of nkIdent: return @[node]
    of nkCurly:
      for sub in node:
        result.add sub

    of nkInfix:
      result.add setValues(node[1])
      result.add setValues(node[2])

    else:
      raiseImplementKindError(node)

proc getFileId(ctx: SourcetrailContext, node: PNode): cint =
  let filePath = ctx.graph.getFilePath(node).string
  return ctx.writer[].recordFile(filePath)




proc trailCompile*(
    file: AbsFile,
    stdpath: AbsDir,
    otherpaths: seq[AbsDir],
    targetFile: AbsFile
  ) =

  info "input file:", file
  if exists(stdpath):
    info "stdpath:", stdpath
  else:
    err "Could not find stdlib at ", stdpath
    debug "Either explicitly specify library path via `--stdpath`"
    debug "Or run trail analysis with choosenim toolchain for correct version"

  info "target file:", targetFile

  var writer: SourcetrailDBWriter
  var ptrWriter {.global.}: ptr SourcetrailDBWriter
  ptrWriter = addr writer

  block:
    rmFile targetFile
    discard writer.open(targetFile.string)

  var tmp = false



  var graph {.global.}: ModuleGraph
  graph = newModuleGraph(file, stdpath,
    proc(config: ConfigRef; info: TLineInfo; msg: string; level: Severity) =
      if config.errorCounter >= config.errorMax:
        err msg
        err info, config.getFilePath(info)
  )

  registerPass(graph, semPass)
  registerPass(
    graph, makePass(
      (
        proc(graph: ModuleGraph, module: PSym): PPassContext {.nimcall.} =
          var context = SourcetrailContext(writer: ptrWriter)
          context.module = module
          context.graph = graph

          return context
      ),
      (
        proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
          result = n
          var ctx = SourcetrailContext(c)

          # if sfMainModule in ctx.module.flags:
          registerToplevel(ctx, n)


      ),
      (
        proc(
          graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
          discard
      )
    )
  )

  discard writer.beginTransaction()

  logIndented:
    compileProject(graph)

  discard writer.commitTransaction()


  info "Finished source analysis for file", file
  discard writer.close()
  info "Closed file"
  debug "Result database:", targetFile
  debug &"open using `sourcetrail '{targetFile.withExt(\"srctrlprj\")}'`"
