import
  ../docentry_types,
  ../docentry,
  hmisc/algo/[hparse_base, hlex_base],
  hmisc/[hdebug_misc, base_errors, hexceptions],
  std/[options],
  haxorg/semorg

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

proc lexLink(str: var PosStr): Option[LinkTok] =
  if str.finished():
    result = some str.initEof(ltEOF)

  else:
    case str[]:
      of IdentStartChars:
        result = some initTok(str.popIdent(), ltIdent)

      of ',', '[', ']', '(', ')', '{', '}', '.', '!':
        result = some initCharTok(str, {
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
          result = some str.initTok(ltNamespace, false)
          str.advance(2)

        else:
          result = some str.initTok(ltColon, false)
          str.advance(1)

      of HorizontalSpace:
        str.skipWhile(HorizontalSpace)
        result = lexLink(str)

      else:
        str.raiseUnexpectedChar()

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
    else:
      raise newUnexpectedKindError(str.normalize())

  return r

proc parseDocType(lex: var LinkLex): DocType =
  case lex[].kind:
    of ltIdent:
      result = newDocType(dtkIdent, lex[].strVal()); lex.advance()
    else:
      raise newImplementKindError(lex[])

proc parseProcArglist(lex: var LinkLex): tuple[
  arguments: seq[DocType], returnType: Option[DocType]] =

  var balance = 1
  lex.skip(ltLPar)
  while balance > 0 and not lex[ltEof]:
    case lex[].kind:
      of ltLPar: inc balance; lex.advance()
      of ltRPar: dec balance; lex.advance()
      of ltIdent: result.arguments.add lex.parseDocType()
      of ltComma: lex.advance()
      else:
        raise newUnexpectedKindError(lex[])

  if lex[ltColon]:
    lex.advance()
    result.returnType = some lex.parseDocType()

proc parseIdentPart(lex: var LinkLex): DocSelectorPart =
  case lex[].kind:
    of ltIdent:
      var
        kinds: set[DocEntryKind]
        name: string
      if lex[ltIdent, ltKindSelector]:
        kinds = lex[].strVal().selectorToKinds()
        lex.advance(2)
        name = lex[].strVal()
        lex.advance(1)


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
  var lex = initLexer(str, lexLink, true)
  while not lex[ltEof]:
    result.parts.add parseIdentPart(lex)
    if lex[{ltDot, ltNamespace}]:
      lex.advance()

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
