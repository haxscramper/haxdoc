import ../docentry, ../docwriter
import nim_compiler_aux
import std/[strutils, strformat]
import hnimast
import hmisc/other/[oswrap]
import hmisc/algo/[hstring_algo, halgorithm]

type
  DocContext = ref object of PPassContext
    db: DocDb
    allModules: seq[DocEntry]
    module: DocEntry

using
  ctx: DocContext
  node: PNode



proc toDocType(ntype: NType): DocType =
  if ntype.kind in {ntkIdent, ntkGenericSpec} and
     ntype.declNode.isSome() and
     (
       (ntype.head notin ["ref", "ptr", "sink", "owned", "out", "distinct"]) or
       (ntype.genParams.len == 0)
     ):

    discard
    # let doctype = newDocType

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

proc registerCalls(ctx: DocContext, impl: PNode) =
  discard

proc registerProcDef(ctx: DocContext, procDef: PNode) =
  let procDecl = parseProc(procDef)

  var entry = ctx.module.newDocEntry(procDecl.classifiyKind(), procDecl.name)
  info procDecl.name

  # for argument in argumentIdents(procDecl):
  #   discard
    # let localId = ctx.writer[].recordLocalSymbol($argument.sym)
    # discard ctx.writer[].recordLocalSymbolLocation(localId, (fileId, argument))

  let procType = procDecl.signature.toDocType()
  # registerTypeUse(ctx, procDecl.signature)

  if not(isNil(procDecl.impl) or procDecl.impl.kind == nkEmpty):
    logIndented:
      ctx.registerCalls(procDecl.impl)

proc registerTypeDef(ctx: DocContext, node: PNode) =
  if isObjectDecl(node):
    let objectDecl: PObjectDecl = parseObject(node, parsePPragma)
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

    # for fld in iterateFields(objectDecl):
    #   if fld.fldType.declNode.isSome():
    #     # let fldType = fld.fldType.declNode.get()

    #     let fieldSymbol = ctx.writer[].recordSymbol(
    #       sskField, objNameHierarchy, ("", fld.name, ""))

    #     discard ctx.recordNodeLocation(fieldSymbol, fld.declNode.get())

    #     registerTypeUse(ctx, fieldSymbol, fileId, fld.fldType)

  elif node[2].kind == nkEnumTy:
    let enumDecl: PEnumDecl = parseEnum(node)

    # let enumName = ("", enumDecl.name, "")
    # let enumSymbol = ctx.writer[].recordSymbol(sskEnum, enumName)
    # discard ctx.recordNodeLocation(enumSymbol, enumDecl.declNode.get())
    # for fld in enumDecl.values:
    #   let valueSymbol = ctx.writer[].recordSymbol(
    #     sskEnumConstant,
    #     enumName, ("", fld.name, ""))

    #   discard ctx.recordNodeLocation(valueSymbol, fld.declNode.get())

  elif node[2].kind in {
      nkDistinctTy, nkSym, nkPtrTy, nkRefTy, nkProcTy, nkTupleTy,
      nkBracketExpr, nkInfix, nkVarTy
    }:

    # let path = ("", $node[0], "")
    # let aliasSymbol = ctx.writer[].recordSymbol(sskTypedef, path)
    # discard ctx.recordNodeLocation(aliasSymbol, node)
    # # debug ""
    # # info path
    # # logIndented:
    # # debug node.treeRepr()
    let baseType = parseNType(node[2]).toDocType()
    # registerTypeUse(ctx, )

  elif node[0].kind in {nkPragmaExpr}:
    # # err "Unhandled pragma expression"
    # # debug treeRepr(node)

    # let path = ("", $node[0][0], "")
    # let sym = ctx.writer[].recordSymbol(sskBuiltinType, path)
    # discard ctx.recordNodeLocation(node[0][0])
    discard

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
          var context = DocContext(db: db)
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

  var ctx = newWriteContext(AbsFile "/tmp/b.xml")
  ctx.writeIdentMapXml(db)
  echo "done"
