import
  std/[tables, sequtils, with, strformat, options, strutils]

import
  hmisc/algo/[hseq_distance, htemplates, halgorithm],
  hmisc/types/[colorstring],
  hmisc/[base_errors, hdebug_misc]

import
  ../docentry_types,
  ../docentry


type
  DocDiffKind* = enum
    ldkNoChanges ## Line does not have syntactical or semantical changes
    ldkNewText ## Code was added
    ldkDeletedText ## Code was removed
    ldkTextChanged ## Line had text (syntactical) changes
    ldkSemChanged ## Line didn not change syntactically, but one of the
                  ## used symbols changed it's meaning (can raise new
                  ## exception, changed it's implementation)

    ldkDocChanged ## Used entry didn not change it's semantical meaning,
                  ## but documentation was modified.


  DocLineDiffPart = object
    oldPart*: DocCodePart
    newPart*: DocCodePart
    diff*: Option[DocEntryDiff]

  DocLineDiff* = object
    kind*: DocDiffKind
    # REVIEW maybe storing all the lines in duplicate form does not worth
    # it, or at least should be made via `case` variant to reduce space?
    oldLine*: DocCodeLine
    newLine*: DocCodeLine
    diffParts*: seq[DocLineDiffPart]

  DocFileDiff* = object
    diffLines*: seq[DocLineDiff]

  DocEntryDiffKind* = enum
    ## Type of documentably entry diffs that directly affect it's signature
    ## or internal implementation

    dedProcedureKindChanged ## Signature different due to procedure kind
    ## change - `template` was converted to a `macro`, `func` became a
    ## procedure etc.
    dedProcedureRenamed ## Signature different due to rename
    dedNewArgument ## Different signature due to new argument
    dedRemovedArgument ## Different signature due to removed argument
    dedChangedArgument ## Different signature due to argument changed type
    dedChangedReturnType

    dedImplementationChanged ## Implementation changed between versions
    # IDEA in theory I should be able to provide more granual information
    # about implementation changes - I can track how passed parameters are
    # handler for example. And then track argumetn usage in different
    # expressions. For example when I process a procedure call, like
    # `procname("positional",named=1231)` - I can keep record of which
    # procedure symbol I'm currently processing, and what named parameters
    # I use specifically. I don't think this qualifies as `user` kind of
    # use, but something close to that might work out. In this case example
    # above would be annotated like
    #
    # ```
    # procname("positioal", named = 1234)
    # ^^^^^^^^ ^^^^^^^^^^^  ^^^^^^^^^^^^
    # |        |            |
    # |        |            refers to use of proc argument 'named'
    # |        |
    # |        Usage of 0th procedure argument
    # |
    # Regular procedure call
    # ```



    dedSideEffectsChanged ## Entry has different side effects
    dedRaisesChanged ## Entry has different list of raised exceptions


    dedTypeNameChanged ## Entry has different type name
    dedNewField ## Record entry has new field
    dedRemovedField ## Record entry lacks field
    dedChangedField ## Record entry field changed it's type

    dedEntryDeleted ## New database does not contain entry that can be
    ## considered 'similar enough' to provide more concrete change
    ## detection. In other words - signature changed too much, and it is
    ## not possible to infer original ID of the entry

    dedEntryAdded ## New database contains entry that cannot be tracked
    ## back to the old database version (similarly to `deleted` it might be
    ## caused by isufficiently sophistiated change detection algorithm
    ## rather than actually new entry)

  DedChangeKind = enum
    dckNewAdded
    dckOldRemoved
    dckUsedEntryChanged
    dckPresentViaChanged

  DocEntryDiffPart = object
    changeKind*: DedChangeKind
    entry*: Option[DocId]
    case kind*: DocEntryDiffKind
      of dedSideEffectsChanged, dedRaisesChanged:
        presentVia: Option[DocIdSet]

      else:
        discard

  DocEntryDiff* = object
    diffParts*: seq[DocEntryDiffPart]

  DocDbDiff* = object
    oldDb*: DocDb
    newDb*: DocDb

    sameSignature: DocIdSet ## Set of documentable entries with the same
    ## signature

    oldNewMap: Table[DocId, DocId] ## Mapping between old and new
    ## versions of documentable entries. If old documentable entry is
    ## deleted it is mapped to an invalid id.

    newOldMap: Table[DocId, DocId] ## Reversed map

    entryChange: Table[DocId, DocEntryDiff] ## Mapping between documentable
    ## entry ID and diff associated with that entry.
    ##
    ## Due to possibility of deleting old entries and inserting new ones,
    ## IDs in the table are mixed - most of them are from old database (and
    ## thus also contained in `changedSignature` or `sameSignature`). The
    ## only time when ID belongs to new documentable entry is when it is
    ## completely new.

proc isAdded*(db: DocDbDiff, id: DocId): bool =
  id notin db.oldNewMap and
  id notin db.sameSignature and
  id in db.entryChange

proc isDeleted*(db: DocDbDiff, id: DocId): bool =
  id in db.oldNewMap and
  not db.oldNewMap[id].isValid()

proc isChanged*(db: DocDbDiff, id: DocId): bool =
  id in db.entryChange

iterator items*(diff: DocEntryDiff): DocEntryDiffPart =
  for part in items(diff.diffParts):
    yield part

iterator pairs*(diff: DocEntryDiff): (int, DocEntryDiffPart) =
  for part in pairs(diff.diffParts):
    yield part

func len*(diff: DocEntryDiff): int = diff.diffParts.len()

proc add*(
    diff: var DocEntryDiff, part: DocEntryDiffPart | seq[DocEntryDiffPart]) =
  diff.diffParts.add part



proc getNew*(db: DocDbDiff, id: DocId): DocId =
  ## Return 'new' documentable entry version. It it is alreayd in new
  ## documentable database return it without changing.
  if id in db.sameSignature or db.isAdded(id):
    assert id in db.newDb
    return id

  elif db.isDeleted(id):
    raise newGetterError(
      "Cannot get 'new' for documentable entry id",
      id, db.oldDb[id], " - it has been deleted")

  else:
    raise newLogicError(
      "Entry must be ether unchanged, new or deleted")


proc getOld*(db: DocDbDiff, id: DocId): DocId =
  ## Return 'old' documentable entry version. It it is already in old
  ## documentable database return it without changing.
  if id in db.sameSignature or db.isDeleted(id):
    assert id in db.oldDb
    return id

  elif db.isAdded(id):
    raise newGetterError(
      "Cannot get 'old' for documentable entry id",
      id, db.newDb[id], " - it is completely new")

  else:
    raise newLogicError(
      "Entry must be ether unchanged, new or deleted")

proc getDiff*(db: DocDbDiff, id: DocId): DocEntryDiff =
  if id in db.entryChange:
    result = db.entryChange[id]


proc initDiffPart(kind: DocEntryDiffKind): DocEntryDiffPart =
  DocEntryDiffPart(kind: kind)

proc diffType(db: DocDbDiff, old, new: DocType): seq[DocEntryDiffPart] =
  assert old.kind == new.kind,
     &"Cannot diff types of different kind - old is {old.kind}, new is {new.kind}"

  case old.kind:
    of dtkProc:
      if old.returnType != new.returnType:
        result.add initDiffPart(dedChangedReturnType)

    else:
      discard

proc diffProc(db: DocDbDiff, old, new: DocEntry): DocEntryDiff =
  result.add db.diffType(old.procType, new.procType)

  for effect in new.effects - old.effects:
    result.add initDiffPart(dedSideEffectsChanged).withIt do:
      it.changeKind = dckNewAdded
      it.entry = some effect
      if effect in new.effectsVia:
        it.presentVia = some new.effectsVia[effect]

  for effect in old.effects - new.effects:
    result.add initDiffPart(dedSideEffectsChanged).withIt do:
      it.changeKind = dckOldRemoved
      it.entry = some effect
      if effect in old.effectsVia:
        it.presentVia = some old.effectsVia[effect]

  for raised in new.raises - old.raises:
    result.add initDiffPart(dedRaisesChanged).withIt do:
      it.changeKind = dckNewAdded
      it.entry = some raised
      if raised in old.raisesVia:
        it.presentVia = some old.raisesVia[raised]

  for raised in old.raises - new.raises:
    result.add initDiffPart(dedRaisesChanged).withIt do:
      it.changeKind = dckOldRemoved
      it.entry = some raised
      if raised in old.raisesVia:
        it.presentVia = some old.raisesVia[raised]

proc updateDiff(db: var DocDbDiff, id: DocId) =
  if db.isDeleted(id):
    raise newImplementError("Deleted entry")

  elif db.isAdded(id):
    raise newImplementError("Added entry")

  else:
    let
      old = db.oldDb[db.getOld(id)]
      new = db.newDb[db.getNew(id)]

    if old.kind == new.kind:
      case old.kind:
        of dekProcKinds:
          let diff = db.diffProc(old, new)
          if diff.len > 0:
            db.entryChange[id] = diff

        else:
          discard


proc diffDb*(oldDb, newDb: DocDb): DocDbDiff =
  result = DocDbDiff(oldDb: oldDb, newDb: newDb)
  var oldIds, newIds: DocIdSet

  for entry in allItems(oldDb):
    oldIds.incl entry.id

  for entry in allItems(newDb):
    newIds.incl entry.id

  result.sameSignature = oldIds * newIds

  for id in result.sameSignature:
    result.updateDiff(id)

  let
    deleted = oldIds - newIds
    added = newIds - oldIds

  for entry in deleted:
    result.oldNewMap[entry] = DocId()





proc diffEntry*(db: DocDbDiff, oldEntry, newEntry: DocEntry): DocEntryDiff =
  discard

proc diffFile*(db: DocDbDiff, oldFile, newFile: DocFile): DocFileDiff =
  proc lineCmp(oldLine, newLine: DocCodeLine): bool =
    oldLine.text == newLine.text

  let diff = myersDiff(
    oldFile.body.codeLines,
    newFile.body.codeLines,
    lineCmp
  )

  let shifted = shiftDiffed(
    oldFile.body.codeLines,
    newFile.body.codeLines,
    diff,
    DocCodeLine()
  )

  for (oldLine, newLine) in zip(shifted.oldShifted, shifted.newShifted):
    let
      (oldKind, oldCode) = oldLine
      (newKind, newCode) = newLine


    var kind: DocDiffKind
    var changed: seq[DocLineDiffPart]
    if oldKind == dskKeep and newKind == dskKeep:
      kind = ldkNoChanges
      for (old, new) in zip(oldCode.parts, newCode.parts):
        var part = DocLineDiffPart(oldPart: old, newPart: new)
        if old.hasRefid() and
           new.hasRefid() and
           db.isChanged(old.getRefid()):
          part.diff = some db.getDiff(old.getRefid())
          kind = ldkSemChanged
          changed.add part

    elif newKind == dskInsert:
      kind = ldkNewText

    elif oldKind == dskDelete:
      kind = ldkDeletedText

    result.diffLines.add DocLineDiff(
      kind: kind,
      oldLine: oldCode,
      newLine: newCode,
      diffParts: changed
    )


proc formatDiff*(db: DocDbDiff, diff: DocEntryDiff): string =
  var text: seq[string]
  for part in diff:
    case part.kind:
      of dedSideEffectsChanged:
        text.add &"Changed side effect - added {db.newDb[part.entry.get()].name}"

      of dedRaisesChanged:
        text.add &"New possible exception - added {db.newDb[part.entry.get()].name}"

      else:
        raise newImplementKindError(part)

  return text.join("\n")


proc formatDiff*(db: DocDbDiff, diff: DocFileDiff): string =
  let maxLine = maxIt(diff.diffLines, it.oldLine.lineHigh) + 2

  for line in diff.diffLines:
    var buf: ColoredRuneGrid
    let (oldStyle, newStyle) =
      case line.kind:
        of ldkSemChanged:  (bgDefault + fgDefault, bgDefault + fgCyan)
        of ldkDeletedText: (bgDefault + fgRed,     bgDefault + fgDefault)
        of ldkNewText:     (bgDefault + fgDefault, bgDefault + fgGreen)
        else:              (bgDefault + fgDefault, bgDefault + fgDefault)

    buf[0, 0]       = toStyled(line.oldLine.text, oldStyle)
    buf[0, maxLine] = toStyled(line.newLine.text, newStyle)

    if line.diffParts.len > 0:
      for part in line.diffParts:
        if part.diff.isSome():
          let col = maxLine + part.newPart.slice.column.a
          buf[1, col] = '^'
          buf[2, col] = toStyled(
            db.formatDiff(part.diff.get()), fgMagenta + bgDefault)






    with result:
      add $buf
      add "\n"
