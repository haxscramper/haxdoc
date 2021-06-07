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
  ConvertContext = object
    db: DocDb
    refidMap: DocLocationMap
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



proc newEntryForLocation(
    ctx; loc: LocationType, name: string): DocEntry =
  let link = ctx.refidMap.findLinkForLocation(
    initDocLocation(AbsFile(loc.file), loc.line, loc.column.get(0)),
    name
  )

  return ctx.db.newDocEntry(link.get())

proc register(ctx; dox: SectionDefType) =
  for member in dox.memberdef:
    var entry = ctx.newEntryForLocation(
      member.location, $member.name[0])
    if member.detailedDescription.getSome(desc):
      entry.docText.docBody = ctx.toOrg(desc).toSemOrg()


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

proc generateDocDb*(
    doxygenDir: AbsDir, refidMap: DocLocationMap): DocDb =
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
