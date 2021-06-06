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


proc toOrg(ctx; dt: DescriptionType): OrgNode

proc toOrg(ctx; body: DocParamListType): OrgNode =
  result = onkList.newTree()
  for item in body.parameterItem:
    var listItem = onkListItem.newTree()
    listItem["tag"] = onkInlineStmtList.newTree()
    for param in item.parameterNameList:
      listItem["tag"].add onkMetaTag.newTree(
        newOrgIdent("arg"),
        onkRawText.newTree(param.parameterName[0][0].mixedStr)
      )

    listItem["body"] = ctx.toOrg(item.parameterDescription)

    result.add listItem

proc toOrg(ctx; body: DocParaTypeBody): OrgNode =
  case body.kind:
    of dptParameterList: result = ctx.toOrg(body.docParamListType)
    of dptMixedStr: result = onkWord.newTree(body.mixedStr)

    else:
      raise newUnexpectedKindError(body, pstring(body))

proc toOrg(ctx; dtb: DescriptionTypeBody): OrgNode =
  case dtb.kind:
    of dtPara:
      result = onkStmtList.newTree()
      for item in dtb.docParaType:
        result.add ctx.toOrg(item)

    else:
      raise newUnexpectedKindError(dtb, pstring(dtb))

proc toOrg(ctx; dt: DescriptionType): OrgNode =
  result = onkStmtList.newTree()
  for sub in dt.xsdChoice:
    result.add ctx.toOrg(sub)



proc register(ctx; dox: SectionDefType) =
  for member in dox.memberdef:
    let ident = ctx.refidMap.map[member.id]
    var entry = ctx.db.newDocEntry(ident)
    if member.detailedDescription.getSome(desc):
      entry.docText.docBody = ctx.toOrg(desc).toSemOrg()
      info entry.docText.docBody.treeRepr()


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
      let name = part["name"].asStr()
      case part["kind"].asStr():
        of "Class":     ident.add initIdentPart(dekClass, name)
        of "Field":     ident.add initIdentPart(dekField, name)
        of "Enum":      ident.add initIdentPart(dekEnum, name)
        of "EnumField": ident.add initIdentPart(dekEnumField, name)

        of "Proc":
          ident.add initIdentPart(
            dekProc, part["name"].asStr(), part["procType"].toDocType())

        else:
          raise newUnexpectedKindError(part["kind"].asStr())


    mutHash(ident)
    result.map[entry[1].asStr()] = ident
