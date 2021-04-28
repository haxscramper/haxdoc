import ../docentry, ../docentry_io
import hnimast/compiler_aux
import std/[strutils, strformat, tables, streams]
import hnimast
import hmisc/other/[oswrap, colorlogger]
import hmisc/algo/[hstring_algo, halgorithm]
import compiler/sighashes


type
  DocContext = ref object of PPassContext
    db: DocDb
    graph: ModuleGraph
    allModules: seq[DocEntry]
    module: DocEntry
    sigmap: Table[SigHash, DocId]

using
  ctx: DocContext
  node: PNode

proc setLocation(ctx; entry: DocEntry, node) =
  entry.location = some DocLocation(
    line: node.getInfo().line.int,
    column: node.getInfo().col.int,
    file: $ctx.graph.getFilePath(node)
  )

proc headSym(node): PSym =
  case node.kind:
    of nkProcDeclKinds, nkDistinctTy, nkVarTy, nkRefTy, nkPtrTy,
       nkBracketExpr, nkTypeDef, nkPragmaExpr:
      headSym(node[0])

    of nkCommand, nkCall:
      headSym(node[1])

    of nkSym:
      node.sym

    of nkIdent:
      nil

    else:
      raiseImplementKindError(node, node.treeRepr())

proc trySigHash*(sym: PSym): SigHash =
  if not isNil(sym):
    return sym.sigHash()

proc addSigmap(ctx; node; entry: DocEntry) =
  try:
    let hash = node.headSym().sigHash()
    ctx.sigmap[hash] = entry.id()
    # if "string" in $node and node.kind notin nkProcDeclKinds:
    #   info hash, " ", node.treeRepr(maxDepth = 1)


  except IndexDefect as e:
    err e.msg
    discard

proc sigHash(t: NType): SigHash =
  result = t.declNode.get().headSym().trySigHash()

proc `[]`(ctx; ntype: NType): DocId =
  let hash = ntype.sigHash()
  if hash in ctx.sigmap:
    return ctx.sigmap[hash]

  # else:
  #   err hash, " ", ntype, ntype.declNode.get().treeRepr()

proc toDocType(ctx; ntype: NType): DocType =
  case ntype.kind:
    of ntkIdent:
      if ntype.declNode.get().kind == nkIdent:
        result = DocType(
          kind: dtkGenericParam,
          paramName: $ntype.declNode.get())

      else:
        result = DocType(kind: dtkIdent, head: ctx[ntype])

    else:
      result = DocType(kind: dtkIdent)
  # if ntype.kind in {ntkIdent, ntkGenericSpec} and
  #    ntype.declNode.isSome() and
  #    (
  #      (ntype.head notin ["ref", "ptr", "sink", "owned", "out", "distinct"]) or
  #      (ntype.genParams.len == 0)
  #    ):


    # let reference = ctx.recordReference(
    #   userId,
    #   ctx.writer[].recordSymbol(sskType, path),
    #   srkTypeUsage
    # )

    # let node = declHead(ntype.declNode.get())
    # let rng = toSourcetrailSourceRange((fileId, node))

    # discard ctx.writer[].recordReferenceLocation(reference, rng)

  # let direct = directUsedTypes(ntype)
  # for used in direct:
  #   registerTypeUse(ctx, used)

proc classifiyKind(decl: PProcDecl): DocEntryKind =
  dekProc

proc classifyKind(nt: NType, asAlias: bool): DocEntryKind =
  if asAlias:
    if nt.kind != ntkGenericSpec:
      return dekAlias

    else:
      return dekTypeclass

  case nt.kind:
    # of ntkIdent:
    #   if nt.genParams.len == 0:
    #     result =

    else:
      raiseImplementKindError(nt)



proc registerCalls(ctx: DocContext, impl: PNode) =
  discard

proc registerProcDef(ctx: DocContext, procDef: PNode) =
  let procDecl = parseProc(procDef)

  var entry = ctx.module.newDocEntry(
    procDecl.classifiyKind(), procDecl.name)
  ctx.addSigmap(procDef, entry)
  ctx.setLocation(entry, procDef)
  entry.rawDoc.add procDecl.docComment

  for argument in arguments(procDecl):
    for ident in argument.idents:
      var arg = entry.newDocEntry(dekArg, ident.getStrVal())
      arg.argType = some ctx.toDocType(argument.vtype)
      arg.argTypeStr = some $argument.vtype

    # let localId = ctx.writer[].recordLocalSymbol($argument.sym)
    # discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, argument))

  let procType = ctx.toDocType(procDecl.signature)
  # registerTypeUse(ctx, procDecl.signature)

  if not(isNil(procDecl.impl) or procDecl.impl.kind == nkEmpty):
    logIndented:
      ctx.registerCalls(procDecl.impl)


proc registerTypeDef(ctx; node) =
  if isObjectDecl(node):
    let objectDecl: PObjectDecl = parseObject(node)
    var entry = ctx.module.newDocEntry(dekObject, objectDecl.name.head)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.rawDoc.add objectDecl.docComment

    # let objNameHierarchy = ("", objectDecl.name.head, "")
    # let objectSymbol = ctx.writer[].recordSymbol(sskStruct, objNameHierarchy)
    # discard ctx.recordNodeLocation(objectSymbol, objectDecl.declNode.get())

    # for fld in getBranchFields(objectDecl):
    #   let switchType = fld.fldType
    #   debug switchType
    #   let typeName = $switchType.declNode.get()
    #   for branch in fld.branches:
    #     if not branch.isElse:
    #       for value in branch.ofValue.setValues():
    #         let referencedSymbol = ctx.writer[].recordSymbol(
    #           sskEnumConstant, [("", typeName, ""), ("", $value, "")])

    #         let referenceId = ctx.writer[].recordReference(
    #           objectSymbol, referencedSymbol, srkUsage)

    #         discard ctx.writer[].recordReferenceLocation(
    #           referenceId, (fileId, value))

    for param in objectDecl.name.genParams:
      var p = entry.newDocEntry(dekParam, param.head)

    for nimField in iterateFields(objectDecl):
      var field = entry.newDocEntry(dekField, nimField.name)
      field.rawDoc.add nimField.docComment
      # if fld.fldType.declNode.isSome():
        # let fldType = fld.fldType.declNode.get()

        # let fieldSymbol = ctx.writer[].recordSymbol(
        #   sskField, objNameHierarchy, ("", fld.name, ""))

        # discard ctx.recordNodeLocation(fieldSymbol, fld.declNode.get())

        # registerTypeUse(ctx, fieldSymbol, fileId, fld.fldType)

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)
    var entry = ctx.module.newDocEntry(dekEnum, enumDecl.name)
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

    for enField in enumDecl.values:
      var field = entry.newDocEntry(dekEnumField, enField.name)
      # let valueSymbol = ctx.writer[].recordSymbol(
      #   sskEnumConstant,
      #   enumName, ("", fld.name, ""))


    # let enumName = ("", enumDecl.name, "")
    # let enumSymbol = ctx.writer[].recordSymbol(sskEnum, enumName)
    # discard ctx.recordNodeLocation(enumSymbol, enumDecl.declNode.get())

    #   discard ctx.recordNodeLocation(valueSymbol, fld.declNode.get())

  elif node[2].kind in {
      nkDistinctTy, nkSym, nkPtrTy, nkRefTy, nkProcTy, nkTupleTy,
      nkBracketExpr, nkInfix, nkVarTy
    }:


    let baseNType = parseNType(node[2])
    let baseType = ctx.toDocType(baseNType)

    let kind =
      if node[2].kind == nkDistinctTy:
        dekDistinctAlias
      else:
        classifyKind(baseNType, true)

    var entry = ctx.module.newDocEntry(kind, $node[0])
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)
    entry.baseType = baseType

    # let path = ("", $node[0], "")
    # let aliasSymbol = ctx.writer[].recordSymbol(sskTypedef, path)
    # discard ctx.recordNodeLocation(aliasSymbol, node)
    # # debug ""
    # # info path
    # # logIndented:
    # # debug node.treeRepr()
    # registerTypeUse(ctx, )

  elif node[0].kind in {nkPragmaExpr}:
    # # err "Unhandled pragma expression"
    # # debug treeRepr(node)

    # let path = ("", $node[0][0], "")
    # let sym = ctx.writer[].recordSymbol(sskBuiltinType, path)
    # discard ctx.recordNodeLocation(node[0][0])
    var entry = ctx.module.newDocEntry(dekBuiltin, $node[0][0])
    ctx.setLocation(entry, node)
    ctx.addSigmap(node, entry)

  elif node[2].kind in {nkCall}:
    # `Type = typeof(expr())`
    discard

  elif node[2].kind in {nkTypeClassTy}:
    # IMPLEMENT concept indexing
    discard

  else:
    warn node[2].kind
    debug node
    debug treeRepr(node)


proc registerToplevel(ctx: DocContext, node: PNode) =
  case node.kind:
    of nkProcDeclKinds:
      ctx.registerProcDef(node)

    of nkTypeSection:
      for typeDecl in node:
        registerToplevel(ctx, typeDecl)

    of nkTypeDef:
      ctx.registerTypeDef(node)

    of nkStmtList:
      for subnode in node:
        registerTopLevel(ctx, subnode)

    of nkEmpty, nkCommentStmt, nkIncludeStmt, nkImportStmt,
       nkPragma, nkExportStmt:
      discard

    else:
      ctx.registerCalls(node)


proc generateDocDb*(
    file: AbsFile,
    stdpath: AbsDir,
    otherPaths: seq[AbsDir],
  ): DocDb =

  info "input file:", file
  if exists(stdpath):
    info "stdpath:", stdpath
  else:
    err "Could not find stdlib at ", stdpath
    debug "Either explicitly specify library path via `--stdpath`"
    debug "Or run trail analysis with choosenim toolchain for correct version"

  var db {.global.} = DocDb()
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
          var context = DocContext(db: db, graph: graph)
          context.module = db.newDocEntry(dekModule, module.getStrVal())
          context.allModules.add context.module
          return context
      ),
      (
        proc(c: PPassContext, n: PNode): PNode {.nimcall.} =
          result = n
          var ctx = DocContext(c)
          registerToplevel(ctx, n)
      ),
      (
        proc(graph: ModuleGraph; p: PPassContext, n: PNode): PNode {.nimcall.} =
          discard
      )
    )
  )

  logIndented:
    compileProject(graph)

  return db

when isMainModule:
  let file = AbsFile("/tmp/a.nim")
  file.writeFile("echo 12")
  let stdpath = getStdPath()

  startColorLogger()

  let db = generateDocDb(file, getStdPath(), @[])

  var writer = newXmlWriter(newFileStream(AbsFile("/tmp/a.xml"), fmWrite))
  for entry in db.top:
    writer.writeXml(entry, "test")

  echo "done"
