import
  haxdoc/extract/[from_doxygen_xml, from_nim_code],
  haxdoc/[docentry_io, docentry],
  hmisc/other/[oswrap, colorlogger],
  hmisc/algo/htemplates,
  hmisc/[hdebug_misc],
  hnimast/compiler_aux,
  hcparse, hcparse/hc_docwrap

import std/[unittest, options]

startHax()
startColorlogger()

let
  dir = getNewTempDir("tFromDoxygenXml")
  toDir = dir / "doxygen_xml"
  codegenDir = dir / "codegen"
  inputFile = dir /. "file.cpp"
  res = dir /. "finalize.nim"

mkDir codegenDir

suite "From doxygen for simple code sample":
  test "Generate":
    inputFile.writeFile("""

class Main { public: int field; };


/// \arg arg1 Documentation for second argument
/// \arg arg2 Documentation for the first argument
Main method(int arg1, int arg2) {}

""")

    doxygenXmlForDir(dir, toDir, doxyfilePattern = "Doxyfile")

  test "Generate C++ wrappers":
    let wrapConf = baseCppWrapConf.withDeepIt do:
      it.baseDir = dir
      it.refidMap = getRefidLocations(toDir)
      it.codegenDir = some codegenDir

    # let res = dir /. "finalize.nim"
    wrapWithConf(inputFile, res, wrapConf, baseCppParseConf)

  test "Create DB":
    let db = generateDocDb(toDir, loadRefidMap(
      codegenDir / baseCppWrapConf.refidFile))

    discard generateDocDb(
      res,
      startDb = db,
      fileLib = some("finalize"),
      extraLibs = @{
        findPackage("hcparse", newVRAny()).get().projectImportPath(): "hcparse",
        findPackage("hmisc", newVRAny()).get().projectImportPath(): "hmisc"
      },
      rstComments = @["finalize"]
    )

    db.writeDbXml(dir, "doxygen")

# suite "From doxygen for sourcetrail":
   # test "Generate":
   #   let
   #     package = findPackage("nimtrail", newVRAny()).get()
   #     strail = package.projectPath() / "SourcetrailDB" / "core"
   #     toDir = strail / "doxygen_xml"

   #   doxygenXmlForDir(strail, toDir)

   #   let db = generateDocDb(toDir)
   #   db.writeDbXml(dir, "doxygen")
