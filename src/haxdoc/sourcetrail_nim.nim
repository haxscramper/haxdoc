{.experimental: "caseStmtMacros".}

import compiler_aux
import std/[os, strformat, with, lenientops, strutils, sequtils, macros]
import hmisc/other/[colorlogger, oswrap]
import hmisc/helpers
import hmisc/algo/htree_mapping
import hmisc/types/colorstring

import hnimast, hnimast/obj_field_macros
import fusion/matching
import nimtrail/nimtrail_common
import cxxstd/cxx_common


converter toAbsoluteDir*(dir: AbsDir): AbsoluteDir =
  AbsoluteDir(dir.string)

converter toAbsoluteFile*(file: AbsFile): AbsoluteFile =
  AbsoluteFile(file.string)

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

proc getFilePath*(config: ConfigRef, info: TLineInfo): AbsoluteFile =
  ## Get absolute file path for declaration location of `node`
  if info.fileIndex.int32 >= 0:
    result = config.m.fileInfos[info.fileIndex.int32].fullPath

proc getFilePath(graph: ModuleGraph, node: PNode): AbsoluteFile =
  ## Get absolute file path for declaration location of `node`
  graph.config.getFilePath(node.getInfo())


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

  # debug result


proc declHead(node: PNode): PNode =
  case node.kind:
    of nkTypeDef, nkRecCase, nkIdentDefs, nkProcDeclKinds, nkPragmaExpr,
       nkVarTy, nkBracketExpr, nkPrefix,
       nkDistinctTy
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
       nkObjectTy,
       nkTupleClassTy,
       nkLiteralKinds
      :
      result = node

    of nkPostfix, nkCommand
      :
      result = node[1]

    of nkInfix, nkPar:
      result = node[0]

    else:
      debug node.kind
      debug node
      debug node.treeRepr()
      raiseImplementError("\n\n\n" & $node.kind & "\n\n\n")

converter toSourcetrailSourceRange*(
  arg: tuple[file: cint, name: PNode]): SourcetrailSourceRange =
  let head = arg.name.declHead()
  var loc = [
    arg.name.info.line.int16,
    arg.name.info.col + 1,
    arg.name.info.line.int16,
    arg.name.info.col + len($head).int16
  ]


  # info arg.name.kind
  if head.kind in {nkSym, nkIdent}:
    if arg.name.kind == nkTypeDef:
      loc[1] -= len($head).int16 + 1
      loc[3] -= len($head).int16 + 1

    elif arg.name.kind == nkRecCase:
      warn "Adjust case field"
      loc[1] += 5
      loc[3] += 5



  result = toSourcetrailSourcerange((arg.file, loc))

# proc returnType*[N](ntype: NType[N]): Option[NType[N]] =
#   if ntype.rtype.isSome():
#     return some ntype.rType.get().getIt()




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
            # warn "Proc symbol with nil ast"
            # debug node.getInfo()
            # debug ctx.graph.getFilePath(node)
            # debug node
            # debug parent


      elif node.sym.kind in {skParam, skForVar, skVar, skResult, skLet, skConst}:
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

          discard ctx.writer[].recordReferenceLocation(reference, (fileId, node))


      elif node.sym.kind in {skField, skEnumField}:
        if node.sym.owner.notNil:
          let path = [("", split($node.sym.owner, '@')[0], ""), ("", $node, "")]
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

      elif node.sym.kind in {skLabel}:
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

        discard ctx.writer[].recordReferenceLocation(referenceId, (fileId, node))
    else:
      for subnode in mitems(node.sons):
        ctx.registerCalls(subnode, fileId, callerId, node)




proc directUsedTypes*[N](ntype: NType[N]): seq[NType[N]] =
  case ntype.kind:
    of ntkGenericSpec, ntkAnonTuple, ntkIdent:
      result = ntype.genParams

    of ntkProc, ntkNamedTuple:
      for arg in ntype.arguments:
        result.add arg.vtype


      if ntype.returnType().isSome():
        result.add ntype.returnType().get()

    of ntkVarargs:
      result.add ntype.vaType()

    else:
      discard

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
  result = ctx.writer[].getProcId(procDecl)

  let fileId = ctx.recordNodeLocation(result, procDef)

  for argument in argumentIdents(procDecl):
    let localId = ctx.writer[].recordLocalSymbol($argument.sym)
    discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, argument))

  registerTypeUse(ctx, result, fileId, procDecl.signature)

  logIndented:
    ctx.registerCalls(procDecl.impl, fileId, result, nil)

iterator iterateFields*(objDecl: PObjectDecl): PObjectField =
  proc getSubfields(field: PObjectField): seq[PObjectField] =
    for branch in field.branches:
      for field in branch.flds:
        result.add field

  for field in objDecl.flds:
    iterateItDFS(field, it.getSubfields(), it.isKind, dfsPostorder):
      yield it

proc registerTypeDef(
  ctx: SourcetrailContext, node: PNode, fileId: cint): cint =

  if node[2].kind == nkObjectTy:
    let objectDecl: PObjectDecl =
      try:
        parseObject(node, parsePPragma)

      except:
        echo node
        raise

    let objNameHierarchy = ("", objectDecl.name.head, "")
    let objectSymbol = ctx.writer[].recordSymbol(sskStruct, objNameHierarchy)
    discard ctx.recordNodeLocation(objectSymbol, objectDecl.declNode.get())

    for fld in iterateFields(objectDecl):
      if fld.fldType.declNode.isSome():
        # let fldType = fld.fldType.declNode.get()

        let fieldSymbol = ctx.writer[].recordSymbol(
          sskField, objNameHierarchy, ("", fld.name, ""))

        discard ctx.recordNodeLocation(fieldSymbol, fld.declNode.get())

        registerTypeUse(ctx, fieldSymbol, fileId, fld.fldType)

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)

    let enumName = ("", enumDecl.name, "")
    let enumSymbol = ctx.writer[].recordSymbol(sskEnum, enumName)
    discard ctx.recordNodeLocation(enumSymbol, enumDecl.declNode.get())
    for fld in enumDecl.values:
      let valueSymbol = ctx.writer[].recordSymbol(
        sskEnumConstant,
        enumName, ("", fld.name, ""))

      discard ctx.recordNodeLocation(valueSymbol, fld.declNode.get())

  elif node[2].kind in {
      nkDistinctTy, nkSym, nkPtrTy, nkRefTy, nkProcTy, nkTupleTy,
      nkBracketExpr, nkInfix, nkVarTy
    }:

    let path = ("", $node[0], "")
    let aliasSymbol = ctx.writer[].recordSymbol(sskTypedef, path)
    discard ctx.recordNodeLocation(aliasSymbol, node)
    # debug ""
    # info path
    # logIndented:
    registerTypeUse(ctx, aliasSymbol, fileId, parseNType(node[2]))

  elif node[0].kind in {nkPragmaExpr}:
    # err "Unhandled pragma expression"
    # debug treeRepr(node)

    let path = ("", $node[0][0], "")
    let sym = ctx.writer[].recordSymbol(sskBuiltinType, path)
    discard ctx.recordNodeLocation(sym, node[0][0])

  else:
    warn node[2].kind
    debug node
    debug treeRepr(node)



proc getFileId(ctx: SourcetrailContext, node: PNode): cint =
  let filePath = ctx.graph.getFilePath(node).string
  return ctx.writer[].recordFile(filePath)


proc registerToplevel(ctx: SourcetrailContext, node: PNode) =
  case node.kind:
    of nkProcDeclKinds:
      let filePath = ctx.graph.getFilePath(node).string
      let fileId = ctx.writer[].recordFile(filePath)

      try:
        discard ctx.registerProcDef(fileId, node)

      except:
        echo node
        echo treeRepr(node, maxdepth = 6, indexed = true)
        raise

    of nkTypeSection:
      for typeDecl in node:
        try:
          registerToplevel(ctx, typeDecl)

        except:
          echo typeDecl
          echo treeRepr(typeDecl, indexed = true)
          raise


    of nkTypeDef:
      discard ctx.registerTypeDef(node, ctx.getFileId(node))

    of nkStmtList:
      for subnode in node:
        registerTopLevel(ctx, subnode)

    of nkEmpty:
      discard

    of nkCommentStmt, nkIncludeStmt, nkImportStmt, nkPragma, nkExportStmt:
      discard

    else:
      let fileId = ctx.getFileId(node)
      ctx.registerCalls(node, fileId, fileId, nil)




proc trailCompile*(
    file: AbsFile,
    stdpath: AbsDir,
    otherpaths: seq[AbsDir],
    targetFile: AbsFile
  ) =

  info "input file:", file
  info "stdpath:", stdpath
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
      info level
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
