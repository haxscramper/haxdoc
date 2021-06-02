import
  haxdoc/extract/[from_doxygen_xml],
  haxdoc/[docentry_io],
  hmisc/other/[hshell, oswrap, colorlogger],
  hmisc/[hdebug_misc]

import std/[unittest]

startHax()
startColorlogger()

let
  dir = getNewTempDir("tFromDoxygenXml")
  toDir = dir / "doxygen_xml"

suite "From doxygen XML":
  test "Generate":
    writeFile(dir /. "file.cpp", """

class Main { int field; };


/// \arg arg1 Documentation for second argument
/// \arg arg2 Documentation for the first argument
Main method(int arg1, int arg2) {}

""")

    doxygenXmlForDir(dir, toDir, doxyfilePattern = "Doxyfile")

  test "Create DB":
    let db = generateDocDb(toDir)

    db.writeDbXml(dir, "doxygen")
