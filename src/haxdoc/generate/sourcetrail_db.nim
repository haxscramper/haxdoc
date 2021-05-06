import ../docentry
import ../docentry_io
import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hmisc/other/oswrap
import hmisc/base_errors
import hmisc/hasts/xml_ast
import hmisc/hdebug_misc
import hnimast/compiler_aux
import std/[with, options, tables]


proc getFile(writer: var SourcetrailDbWriter, path, lang: string): cint =
  result = writer.recordFile(path)
  discard writer.recordFileLanguage(result, lang)


proc toTrailName(ident: DocFullIdent): SourcetrailNameHierarchy =
  var parts: seq[tuple[prefix, name, postfix: string]]
  for part in ident.parts:
    var buf = part.name
    if part.kind in dekProcKinds:
      buf &= "("
      for idx, arg in part.argTypes:
        if idx > 0: buf &= ", "
        buf &= $arg

      buf &= ")"

    parts.add ("", buf, "")

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

proc registerUses(writer; file: DocFile, idMap: IdMap) =
  var userId: cint
  let fileID = writer.getFile(file.path.string, "nim")
  for line in file.body.codeLines:
    for part in line.parts:
      if part.occur.isSome():
        let occur = part.occur.get()
        if not occur.refid.isValid():
          discard

        elif occur.kind in {dokObjectDeclare, dokCallDeclare}:
          userId = idMap.docToTrail[occur.refid]
          discard writer.recordSymbolLocation(
            userId, toRange(fileId, part.slice))

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
                srkTemplateSpecialization

              of dokInheritFrom:
                srkInheritance

              of dokCall:
                srkCall

              of dokEnumFieldUse:
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

    if entry.kind in {dekCompileDefine, dekPragma}:
      result.docToTrail[entry.id()] = writer.recordSymbol(name, sskMacro)
      continue

    elif entry.kind in {dekModule, dekArg}:
      continue

    let fileId = writer.getFile(
      db.getPathInLib(entry.location.get()).string, "nim")

    let defKind =
      case entry.kind:
        of dekProc, dekFunc, dekConverter, dekIterator:
          sskFunction

        of dekMacro, dekTemplate:
          sskMacro

        of dekEnum:
          sskEnum

        of dekAlias, dekDistinctAlias:
          sskTypedef

        of dekField:
          sskField

        of dekEnumField:
          sskEnumConstant

        of dekNewtypeKinds - { dekAlias, dekDistinctAlias, dekEnum },
           dekBuiltin:
          sskStruct

        else:
          raiseImplementKindError(entry)

    let symId = writer.recordSymbol(name, defKind)

    result.docToTrail[entry.id()] = symId

    if entry.declHeadExtent.isSome():
      let extent = toRange(fileId, entry.declHeadExtent.get())
      discard writer.recordSymbolLocation(symId, extent)





when isMainModule:
  startHax()
  let dir = getTempDir() / "from_nim_code2"
  var writer: SourcetrailDbWriter

  let trailFile = dir /. "trail.srctrldb"
  rmFile trailFile
  discard writer.open(string(trailFile))

  var db = newDocDb()
  db.addKnownLib(getStdPath().dropSuffix("lib"), "std")

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
