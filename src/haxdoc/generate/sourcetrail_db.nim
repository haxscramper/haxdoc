import ../docentry
import ../docentry_io
import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hmisc/other/oswrap
import hmisc/base_errors
import hmisc/hasts/xml_ast
import hmisc/hdebug_misc
import hnimast/compiler_aux
import std/[with, options, tables, strutils]


proc getFile(writer: var SourcetrailDbWriter, path, lang: string): cint =
  result = writer.recordFile(path)
  discard writer.recordFileLanguage(result, lang)


proc toTrailName(ident: DocFullIdent): SourcetrailNameHierarchy =
  var parts: seq[tuple[prefix, name, postfix: string]]
  for part in ident.parts:
    if part.kind in dekProcKinds:
      var buf = "("
      for idx, arg in part.procType.arguments:
        if idx > 0: buf &= ", "
        buf &= $arg.identType

      buf &= ")"

      if part.procType.returnType.isSome():
        parts.add ($part.procType.returnType.get(), part.name, buf)

      else:
        parts.add ("", part.name, buf)

    else:
      parts.add ("", part.name, "")



  return initSourcetrailNameHierarchy(("::", parts))

proc toRange(fileId: cint, extent: DocExtent): SourcetrailSourceRange =
  with result:
    fileId = fileId
    startLine = extent.start.line.cint
    startColumn = extent.start.column.cint + 1
    endLine = extent.finish.line.cint
    endColumn = extent.finish.column.cint + 1

proc toRange(fileId: cint, codeRange: DocCodeSlice): SourcetrailSourceRange =
  with result:
    fileId = fileId
    startLine = codeRange.line.cint
    endLine = codeRange.line.cint
    startColumn = codeRange.column.a.cint + 1
    endColumn = codeRange.column.b.cint + 1

type
  IdMap* = object
    docToTrail: Table[DocId, cint]
    db: DocDb

using
  writer: var SourcetrailDbWriter

proc registerUses*(writer; file: DocFile, idMap: IdMap) =
  let fileID = writer.getFile(file.path.string, "nim")
  var lastDeclare: DocOccurKind
  for line in file.body.codeLines:
    for part in line.parts:
      if not part.occur.isSome():
        continue

      let occur = part.occur.get()
      var userID: cint
      if occur.user.isSome():
        if occur.user.get().isValid:
          userId = idMap.docToTrail[occur.user.get()]

        else:
          echov file.path
          echov part, "has invalid user"

      if occur.kind == dokLocalUse:
        discard writer.recordLocalSymbolLocation(
          writer.recordLocalSymbol(occur.localId),
          toRange(fileId, part.slice))

      elif not occur.refid.isValid():
        discard

      elif occur.kind in {
        dokObjectDeclare, dokCallDeclare,
        dokAliasDeclare, dokEnumDeclare,
        dokGlobalDeclare,
      }:
        userId = idMap.docToTrail[occur.refid]
        lastDeclare = occur.kind
        discard writer.recordSymbolLocation(
          userId, toRange(fileId, part.slice))

      elif occur.kind in {dokImport}:
        if file.moduleId.isSome():
          discard writer.recordReference(
            idMap.docToTrail[file.moduleId.get()],
            idMap.docToTrail[occur.refid],
            srkImport
          )

      else:
        let targetId = idMap.docToTrail[occur.refid]
        let useKind =
          case occur.kind:
            of dokLocalUse:
              raiseImplementError("")

            of dokTypeAsFieldUse, dokTypeAsReturnUse, dokTypeDirectUse,
              dokTypeAsParameterUse, dokTypeAsArgUse:
              srkTypeUsage

            of dokTypeSpecializationUse:
              if lastDeclare == dokAliasDeclare:
                srkTemplateSpecialization

              else:
                # sourcetrail 'template specialization' relations is used
                # in order to show that one type is a generic
                # specialization of another type. In haxdoc 'generic
                # specialization' is used that in this particular case
                # generic type was specialized with some parameter -
                # without describing /context/ in which declaration
                # ocurred. Maybe later I will add support for 'context
                # ranges' in annotation sources and differentiate between
                # 'specialized generic used as a field' and 'inherited
                # from specialized generic'
                srkTypeUsage

            of dokInheritFrom:
              srkInheritance

            of dokCall:
              srkCall

            of dokEnumFieldUse, dokGlobalRead, dokGlobalWrite:
              srkUsage

            of dokAnnotationUsage, dokDefineCheck:
              srkMacroUsage

            else:
              raiseUnexpectedKindError(occur)

        let refSym = writer.recordReference(
          userId, targetId, useKind)

        discard writer.recordReferenceLocation(
          refSym, toRange(fileId, part.slice))


proc registerDb*(writer; db: DocDb): IdMap =
  for full, id in db.fullIdents:
    let
      name = full.toTrailName()
      entry = db[id]

    if entry.kind in {dekArg}: continue

    let defKind =
      case entry.kind:
        of dekNewtypeKinds - { dekAlias, dekDistinctAlias, dekEnum }:
          sskStruct

        of dekProc, dekFunc, dekConverter, dekIterator:
          sskFunction

        of dekMacro, dekTemplate:
          sskMacro

        of dekAlias, dekDistinctAlias:
          sskTypedef

        of dekGlobalConst, dekGlobalVar, dekGlobalLet:
          sskGlobalVariable

        of dekCompileDefine:
          # compile-time defines might be treated as macros or as global
          # varibles. I'm not exactly sure how to classify them, but for
          # now I think global variable describes sematics a little better.
          sskGlobalVariable

        of dekEnum:      sskEnum
        of dekField:     sskField
        of dekEnumField: sskEnumConstant
        of dekBuiltin:   sskBuiltinType
        of dekPragma:    sskAnnotation
        of dekModule:    sskModule

        else:
          raiseImplementKindError(entry)

    result.docToTrail[entry.id()] = writer.recordSymbol(name, defKind)

    if entry.location.isSome():
      let fileId = writer.getFile(
        db.getPathInLib(entry.location.get()).string, "nim")

      let symId = writer.recordSymbol(name, defKind)

      result.docToTrail[entry.id()] = symId

      if entry.declHeadExtent.isSome():
        let extent = toRange(fileId, entry.declHeadExtent.get())
        discard writer.recordSymbolLocation(symId, extent)
        discard writer.recordSymbolScopeLocation(symId, extent)



proc open*(writer; file: AbsFile) = discard writer.open(file.string)

proc registerFullDb*(writer; db: DocDb) =
  discard writer.beginTransaction()
  let idMap = writer.registerDb(db)
  discard writer.commitTransaction()

  for file in db.files:
    discard writer.beginTransaction()
    writer.registerUses(file, idMap)
    discard writer.commitTransaction()

const
  sourcetrailDbExt* = "srctrldb"

when isMainModule:
  startHax()
  let dir = getTempDir() / "from_nim_code2"

  let trailFile = dir /. "trail.srctrldb"
  rmFile trailFile

  var db = newDocDb()
  db.addKnownLib(getStdPath().dropSuffix("lib"), "std")

  var writer = newSourcetrailWriter(trailFile)

  for file in walkDir(dir, AbsFile, exts = @["hxde"]):
    var reader = newHXmlParser(file)
    reader.loadXml(db, "main")


  discard writer.beginTransaction()
  let idMap = writer.registerDb(db)
  discard writer.commitTransaction()


  for file in walkDir(dir, AbsFile, exts = @["hxda"]):
    var inFile: DocFile
    var reader = newHXmlParser(file)
    reader.loadXml(inFile, "file")

    discard writer.beginTransaction()
    writer.registerUses(inFile, idMap)
    discard writer.commitTransaction()

  echov trailFile
  discard writer.close()
  echo "done"
