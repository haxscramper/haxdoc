import
  hcparse/dox_compound as DoxCompound,
  hcparse/dox_index as DoxIndex,
  hcparse/dox_xml,
  ../docentry,
  std/[strtabs, tables],
  haxorg/[semorg, ast],
  hmisc/hasts/[xml_ast],
  hmisc/other/[oswrap, hshell, colorlogger, hjson],
  hmisc/algo/halgorithm,
  hmisc/hdebug_misc,
  hpprint


export dox_xml

type
  RefidMap = object
    map: Table[string, DocLink]

  ConvertContext = object
    db: DocDb
    refidMap: RefidMap
    doctext: Table[string, SemOrg]

using ctx: var ConvertContext

proc toSemOrg(ctx; dtb: DescriptionTypeBody): SemOrg =
  pprint dtb

proc toSemOrg(ctx; dt: DescriptionType): SemOrg =
  result = onkStmtList.newSemOrg()
  for sub in dt.xsdChoice:
    result.add ctx.toSemOrg(sub)



proc register(ctx; dox: SectionDefType) =
  for member in dox.memberdef:
    let ident = ctx.refidMap.map[member.id]
    var entry = ctx.db.newDocEntry(ident)
    if member.detailedDescription.getSome(desc):
      entry.docText.docBody = ctx.toSemOrg(desc)


proc register(ctx; dox: DoxCompound.CompoundDefType) =
  case dox.kind:
    of dckFile:
      for section in dox.sectiondef:
        ctx.register(section)

    of dckClass, dckStruct:
      for section in dox.sectionDef:
        ctx.register(section)

    of dckDir:
      discard

    else:
      err dox.kind

proc generateDocDb*(doxygenDir: AbsDir, refidMap: RefidMap): DocDb =
  var ctx = ConvertContext(refidMap: refidMap, db: newDocDb())
  assertExists(
    doxygenDir / "xml",
    "Could not find generated doxygen XML directory")

  let index = indexForDir(doxygenDir)
  for item in index.compound:
    let file = item.fileForItem(doxygenDir)

    let parsed = parseDoxygenFile(file)
    for comp in parsed.compounddef:
      ctx.register(comp)

  return ctx.db

proc toDocType*(j: JsonNode): DocType =
  case j["kind"].asStr():
    of "Ident":
      result = newDocType(dtkIdent, j["name"].asStr())

    of "Proc":
      result = newDocType(dtkProc)
      result.returnType = some toDocType(j["returnType"])
      for arg in j["arguments"]:
        result.add newDocIdent(
          arg["ident"].asStr(),
          arg["identType"].toDocType())


    else:
      raise newImplementError(j["kind"].asStr())



proc loadRefidMap*(file: AbsFile): RefidMap =
  let json = parseJson(file)

  for entry in json:
    var ident: DocLink
    for part in entry[0]:
      case part["kind"].asStr():
        of "Class":
          ident.add initIdentPart(dekClass, part["name"].asStr())

        of "Field":
          ident.add initIdentPart(dekField, part["name"].asStr())

        of "Proc":
          ident.add initIdentPart(
            dekProc, part["name"].asStr(), part["procType"].toDocType())

        else:
          raise newUnexpectedKindError(part["kind"].asStr())


    mutHash(ident)
    result.map[entry[1].asStr()] = ident
