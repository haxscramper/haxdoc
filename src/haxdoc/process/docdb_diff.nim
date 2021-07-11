import
  std/[tables, sequtils, with]

import
  hmisc/algo/[hseq_distance, htemplates, halgorithm],
  hmisc/types/colorstring

import
  ../docentry_types,
  ../docentry


type
  DocDiffKind* = enum
    ldkNoChanges ## Line does not have syntactical or semantical changes
    ldkNewText ## Code was added
    ldkDeletedText ## Code was removed
    ldkTextChanges ## Line had text (syntactical) changes
    ldkSemChanges ## Line didn not change syntactically, but one of the
                  ## used symbols changed it's meaning (can raise new
                  ## exception, changed it's implementation)

    ldkDocChanges ## Used entry didn not change it's semantical meaning,
                  ## but documentation was modified.


  DocLineDiff* = object
    kind*: DocDiffKind
    oldLine*: DocCodeLine
    newLine*: DocCodeLine

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

  DocEntryDiffPart = object
    kind*: DocEntryDiffKind

  DocEntryDiff* = object
    diffParts*: seq[DocEntryDiffPart]

  DocDbDiff* = object
    oldDb*: DocDb
    newDb*: DocDb

    sameSignature: DocIdSet ## Set of documentable entries with the same
    ## signature

    changedSignature: Table[DocId, DocId] ## Mapping between old and new
    ## versions of documentable entries. If old documentable entry is
    ## deleted it is mapped to an invalid id.

    entryChange: Table[DocId, DocEntryDiff] ## Mapping between documentable
    ## entry ID and diff associated with that entry.
    ##
    ## Due to possibility of deleting old entries and inserting new ones,
    ## IDs in the table are mixed - most of them are from old database (and
    ## thus also contained in `changedSignature` or `sameSignature`). The
    ## only time when ID belongs to new documentable entry is when it is
    ## completely new.

proc isNew*(db: DocDbDiff, id: DocId): bool =
  id notin db.changedSignature and
  id notin db.sameSignature and
  id in db.entryChange

proc isDeleted*(db: DocDbDiff, id: DocId): bool =
  id in db.changedSignature and
  not db.changedSignature[id].isValid()

proc isChanged*(db: DocDbDiff, id: DocId): bool =
  id notin db.entryChange

iterator items*(diff: DocEntryDiff): DocEntryDiffPart =
  for part in items(diff.diffParts):
    yield part

iterator pairs*(diff: DocEntryDiff): (int, DocEntryDiffPart) =
  for part in pairs(diff.diffParts):
    yield part

func len*(diff: DocEntryDiff): int = diff.diffParts.len()

proc getDiff*(db: DocDbDiff, id: DocId): DocEntryDiff =
  if id in db.entryChange:
    result =db.entryChange[id]

proc diffDb*(oldDb, newDb: DocDb): DocDbDiff =
  result = DocDbDiff(oldDb: oldDb, newDb: newDb)

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
    if oldKind == dskKeep and
       newKind == dskKeep:
      kind = ldkNoChanges
      echo "---"
      for (old, new) in zip(oldCode.parts, newCode.parts):
        echo oldCode[old] |<< 30, " ", db.oldDb.formatCodePart(old)
        echo newCode[new] |<< 30, " ", db.newDb.formatCodePart(new)

    elif newKind == dskInsert:
      kind = ldkNewText

    elif oldKind == dskDelete:
      kind = ldkDeletedText

    result.diffLines.add DocLineDiff(
      kind: kind,
      oldLine: oldCode,
      newLine: newCode
    )

proc formatDiff*(db: DocDbDiff, diff: DocFileDiff): string =
  let maxLine = maxIt(diff.diffLines, it.oldLine.lineHigh) + 1

  for line in diff.diffLines:
    with result:
      add line.oldLine.text |<< maxLine
      add " "
      add line.newLine.text
      add "\n"
