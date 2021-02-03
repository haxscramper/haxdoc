
import std/strutils

type
  Obj = object
    fld1: int
    case isRaw: bool
      of true:
        fld2: float

      of false:
        fld3: string

  Enum = enum
    enFirst
    enSecond


  DistinctAlias = distinct int
  Alias = int

proc hello(): int =
  ## Documentation comment 1
  return 12

proc nice(): int =
  ## Documentation comment 2
  return 200

proc hello2(arg: int): int =
  return hello() + arg + nice()

proc hello3(obj: Obj): int =
  return obj.fld1

proc hello4(arg1, arg2: int, arg3: string): int =
  result = arg1 + hello3(Obj(fld1: arg2)) + hello2(arg3.len)
  if result > 10:
    echo "result > 10"

  else:
    result += hello4(arg1, arg2, arg3)

