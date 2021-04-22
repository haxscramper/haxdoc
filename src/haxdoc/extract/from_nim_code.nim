import ../docentry
import nim_compiler_aux
import std/[strutils, strformat]
import hnimast
import hmisc/other/[oswrap]
import hmisc/algo/[hstring_algo, halgorithm]

type
  DocContext = ref object of PPassContext
    db: DocDb

using
  ctx: DocContext
  node: PNode



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

proc registerProcDef(ctx: DocContext, procDef: PNode): cint =
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

proc registerTypeDef(
  ctx: SourcetrailContext, node: PNode, fileId: cint): cint =

  if isObjectDecl(node):
    let objectDecl: PObjectDecl =
      try:
        parseObject(node, parsePPragma)

      except:
        err "Failed to register type def"
        debug node
        raise

    let objNameHierarchy = ("", objectDecl.name.head, "")
    let objectSymbol = ctx.writer[].recordSymbol(sskStruct, objNameHierarchy)
    discard ctx.recordNodeLocation(objectSymbol, objectDecl.declNode.get())

    for fld in getBranchFields(objectDecl):
      let switchType = fld.fldType
      debug switchType
      let typeName = $switchType.declNode.get()
      for branch in fld.branches:
        if not branch.isElse:
          for value in branch.ofValue.setValues():
            let referencedSymbol = ctx.writer[].recordSymbol(
              sskEnumConstant, [("", typeName, ""), ("", $value, "")])

            let referenceId = ctx.writer[].recordReference(
              objectSymbol, referencedSymbol, srkUsage)

            discard ctx.writer[].recordReferenceLocation(
              referenceId, (fileId, value))

      # debug "Field branch value", value.treeRepr()
      # registerCalls(ctx, value, fileId, objectSymbol, nil)

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
    # debug node.treeRepr()
    registerTypeUse(ctx, aliasSymbol, fileId, parseNType(node[2]))

  elif node[0].kind in {nkPragmaExpr}:
    # err "Unhandled pragma expression"
    # debug treeRepr(node)

    let path = ("", $node[0][0], "")
    let sym = ctx.writer[].recordSymbol(sskBuiltinType, path)
    discard ctx.recordNodeLocation(sym, node[0][0])

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


proc generateDocDb*(
    file: AbsFile,
    stdpath: AbsDir,
    otherPaths: seq[AbsDir],
    targetFile: AbsFile
  ): DocDb =

  info "input file:", file
  if exists(stdpath):
    info "stdpath:", stdpath
  else:
    err "Could not find stdlib at ", stdpath
    debug "Either explicitly specify library path via `--stdpath`"
    debug "Or run trail analysis with choosenim toolchain for correct version"

  info "target file:", targetFile

  var db = DocDb()
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

  info "Finished source analysis for file", file
  info "Closed file"
  debug "Result database:", targetFile
  debug &"open using `sourcetrail '{targetFile.withExt(\"srctrlprj\")}'`"
