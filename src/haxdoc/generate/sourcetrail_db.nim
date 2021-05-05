import ../docentry
import ../docentry_io
import cxxstd/cxx_common
import nimtrail/nimtrail_common
import hmisc/other/oswrap
import hmisc/base_errors
import hmisc/hasts/xml_ast
import hmisc/hdebug_misc
import std/[with, options, tables]

proc toRange(fileId: cint, extent: DocExtent): SourcetrailSourceRange =
  with result:
    fileId = fileId
    startLine = extent.start.line.cint + 1
    startColumn = extent.start.column.cint
    endLine = extent.finish.line.cint + 1
    endColumn = extent.finish.column.cint

proc toRange(fileId: cint, codeRange: DocCodeSlice): SourcetrailSourceRange =
  with result:
    fileId = fileId
    startLine = codeRange.line.cint + 1
    endLine = codeRange.line.cint + 1
    startColumn = codeRange.column.a.cint
    endColumn = codeRange.column.b.cint

type
  IdMap* = object
    docToTrail: Table[DocId, cint]
    db: DocDb

using
  writer: var SourcetrailDbWriter

proc registerUses(writer; file: DocFile, idMap: IdMap) =
  var userId: cint
  let fileID = writer.recordFile(file.path.string)
  for line in file.body.codeLines:
    for part in line.parts:
      if part.occur.isSome():
        let occur = part.occur.get()

        if occur.kind in {dokOjectDeclare}:
          userId = idMap.docToTrail[occur.refid]

        else:
          let targetId = idMap.docToTrail[occur.refid]
          var refSym: cint
          case occur.kind:
            of dokLocalUse:
              raiseImplementError("")

            of dokTypeAsFieldUse, dokTypeAsReturnUse,
               dokTypeAsParameterUse, dokTypeAsArgUse:
              refSym = writer.recordReference(userId, targetId, srkTypeUsage)

            of dokTypeSpecializationUse:
              refSym = writer.recordReference(
                userId, targetId, srkTemplateSpecialization)

            of dokInheritFrom:
              refSym = writer.recordReference(
                userId, targetId, srkInheritance)

            of dokCall:
              refSym = writer.recordReference(
                userId, targetId, srkCall)

            else:
              raiseUnexpectedKindError(occur)

          discard writer.recordReferenceLocation(
            refSym, toRange(fileId, part.slice))



proc toTrailName(ident: DocFullIdent): SourcetrailNameHierarchy =
  var parts: seq[tuple[prefix, name, postfix: string]]
  for part in ident.parts:
    parts.add ("", part.name, "")

  return initSourcetrailNameHierarchy(("::", parts))


proc registerDb*(writer; db: DocDb): IdMap =
  for full, id in db.fullIdents:
    let
      name = full.toTrailName()
      entry = db[id]

    if entry.kind in {dekCompileDefine, dekPragma}:
      let symId = writer.recordSymbol(name, sskMacro)
      continue

    elif entry.kind in {dekModule}:
      continue

    echov entry.fullIdent
    let fileId = writer.recordFile(entry.location.get().file)

    var symId: cint
    case entry.kind:
      of dekProc, dekFunc, dekConverter, dekIterator:
        symId = writer.recordSymbol(name, sskFunction)

      of dekMacro, dekTemplate:
        symId = writer.recordSymbol(name, sskMacro)

      of dekNewtypeKinds - { dekAlias, dekDistinctAlias, dekEnum },
         dekBuiltin:
        symId = writer.recordSymbol(name, sskStruct)

      of dekEnum:
        symId = writer.recordSymbol(name, sskEnum)

      of dekAlias, dekDistinctAlias:
        symId = writer.recordSymbol(name, sskTypedef)

      of dekField:
        symId = writer.recordSymbol(name, sskField)

      of dekEnumField:
        symId = writer.recordSymbol(name, sskEnumConstant)

      of dekArg:
        # Local symbol
        discard

      else:
        raiseImplementKindError(entry)

    if entry.declHeadExtent.isSome():
      let extent = toRange(fileId, entry.declHeadExtent.get())
      discard writer.recordSymbolLocation(symId, extent)





when isMainModule:
  startHax()
  let dir = getTempDir() / "from_nim_code2"
  var writer: SourcetrailDbWriter

  discard writer.open(string(dir /. "trail.srctrldb"))

  var db: DocDb
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
