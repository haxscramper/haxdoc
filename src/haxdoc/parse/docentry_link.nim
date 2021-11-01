import
  ../docentry_types,
  ../docentry,
  hmisc/algo/[hparse_base, hlex_base],
  hmisc/core/all,
  std/[options],
  haxorg/defs/defs_all

type
  LinkTokens = enum
    ltIdent
    ltComma
    ltLBrace
    ltRBRace
    ltRPar
    ltLPar
    ltLCurly
    ltRCurly
    ltSemicolon
    ltColon
    ltEqual
    ltDot
    ltKindSelector
    ltNamespace

    ltEof

  LinkTok = HsTok[LinkTokens]
  LinkLex = HsLexer[LinkTok]

proc lexLink(str: var PosStr): seq[LinkTok] =
  if str.finished():
    result.add str.initEof(ltEOF)

  else:
    case str[]:
      of IdentStartChars:
        result.add initTok(str.popIdent(), ltIdent)

      of ',', '[', ']', '(', ')', '{', '}', '.', '!':
        result.add initCharTok(str, {
          ',': ltComma,
          '[': ltLBrace,
          ']': ltRBrace,
          '(': ltLPar,
          ')': ltRPar,
          ':': ltColon,
          '}': ltRCurly,
          '{': ltLCurly,
          '=': ltEqual,
          '.': ltDot,
          '!': ltKindSelector
        })

      of ':':
        if str[':', ':', not {':'}]:
          result.add str.initTok(ltNamespace, false)
          str.next(2)

        else:
          result.add str.initTok(ltColon, false)
          str.next(1)

      of HorizontalSpace:
        str.space()
        result = lexLink(str)

      else:
        raise newUnexpectedCharError(str)

proc initSelectorPart*(kinds: set[DocEntryKind], name: string): DocSelectorPart =
  DocSelectorPart(expected: kinds, name: name)

proc initSelectorPart*(
  kinds: set[DocEntryKind], name: string, procType: DocType): DocSelectorPart =
  DocSelectorPart(expected: kinds, name: name, procType: procType)

func selectorToKinds*(str: string): set[DocEntryKind] =
  var r = result

  case str.normalize():
    of "class": r.incl dekClass
    of "enum": r.incl dekEnum
    of "enumfield": r.incl dekEnumField
    of "field": r.incl dekField
    of "proc": r.incl dekProc
    of "struct": r.incl dekStruct
    else:
      raise newUnexpectedKindError(str.normalize())

  return r

proc parseDocType(lex: var LinkLex): DocType =
  case lex[].kind:
    of ltIdent:
      result = newDocType(dtkIdent, lex[].strVal()); lex.next()
    else:
      raise newImplementKindError(lex[])

proc parseProcArglist(lex: var LinkLex): tuple[
  arguments: seq[DocType], returnType: Option[DocType]] =

  var balance = 1
  lex.skip(ltLPar)
  while balance > 0 and not lex[ltEof]:
    case lex[].kind:
      of ltLPar: inc balance; lex.next()
      of ltRPar: dec balance; lex.next()
      of ltIdent: result.arguments.add lex.parseDocType()
      of ltComma: lex.next()
      else:
        raise newUnexpectedKindError(lex[])

  if lex[ltColon]:
    lex.next()
    result.returnType = some lex.parseDocType()

proc parseIdentPart(lex: var LinkLex): DocSelectorPart =
  case lex[].kind:
    of ltIdent:
      var
        kinds: set[DocEntryKind]
        name: string
      if lex[ltIdent, ltKindSelector]:
        kinds = lex[].strVal().selectorToKinds()
        lex.next(2)
        name = lex[].strVal()
        lex.next(1)


      if lex[ltLPar]:
        let (args, ret) = parseProcArgList(lex)
        result = initSelectorPart(
          kinds, name, newDocType(args, ret))

      else:
        result = initSelectorPart(kinds, name)

    else:
      raise newUnexpectedKindError(lex[])

import hpprint


proc parseFullIdent*(pos: PosStr): DocSelector =
  var str = pos
  var lex = initLexer(str, lexLink, some initTok(ltEof))
  while not lex[ltEof]:
    result.parts.add parseIdentPart(lex)
    if lex[{ltDot, ltNamespace}]:
      lex.next()

proc unif*(t1, t2: DocType): bool =
  t1 == t2

proc matches(entry: DocEntry, part: DocSelectorPart): bool =
  if entry.kind in part.expected and
     entry.name == part.name:
    if len(part.expected * dekProcKinds) > 0:
      result = unif(entry.procType(), part.procType)

    else:
      result = true


proc resolveFullIdent*(db: DocDb, selector: DocSelector): DocId =
  var seed: DocIdSet

  for item in topItems(db, selector.parts[0].expected):
    if item.matches(selector.parts[0]):
      seed.incl item

  for part in selector.parts[1..^1]:
    var next: DocIdSet
    for item in seed:
      for nested in db[item]:
        if nested.matches(part):
          next.incl nested

    seed = next

  if len(seed) == 1:
    result = seed.pop

  else:
    raise newImplementError()



type
  DocCodeLink* = ref object of OrgUserLink
    id*: DocId

proc newOrgLink*(id: DocId): OrgLink =
  OrgLink(kind: olkCode, codeLink: DocCodeLink(id: id))


when isMainModule:
  for s in [
    "enum!test.enumField!FIRST",
    "class!Main",
    "proc!method(int, int): Main"
  ]:
    pprint parseFullIdent(initPosStr(s))

  echo "done"
