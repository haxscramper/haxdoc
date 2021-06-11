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
  dir = getAppTempDir()
  toDir = dir / "doxygen_xml"
  codegenDir = dir / "codegen"
  inputFile = dir /. "file.cpp"

mkDir codegenDir

suite "From doxygen for simple code sample":
  test "Generate":
    mkWithDirStructure dir:
      file inputFile:
        """
struct LocForward1;
struct LocForward2;

struct LocForwardUser { LocForward2* forward2; LocForward1* forward1; };

struct LocForward1 {};
struct LocForward2 {};

struct LocUser { LocForward2* forward2; LocForward1* forward1; };

struct Forward2;
struct Forward1;

struct ForwardUser { Forward2* forward2; Forward1* forward1; };

#include "forward1.hpp"
#include "forward2.hpp"

struct User { Forward2 forward2; Forward1 forward1; };


/// Documentation for main class
class Main {
  public:
    int field; ///< Field documentation
};


/*!
  \param arg1 Documentation for second argument
  \param arg2 Documentation for the first argument
*/
Main method(int arg1, int arg2) {}

enum test { FIRST, SECOND };

"""
      file "forward2.hpp":
        """
struct Forward1;
struct Forward2 { Forward1* forward1; };

Forward2 forward2Proc() {}
Forward1* forward1PtrProc() {}
"""
      file "forward1.hpp":
        """
struct Forward2;
struct Forward1 { Forward2* forward2; };

Forward1 forward1Proc() {}
Forward2* forward2PtrProc() {}
"""

    doxygenXmlForDir(dir, toDir, doxyfilePattern = "Doxyfile")

  test "Generate C++ wrappers":
    let wrapConf = baseCppWrapConf.withDeepIt do:
      it.baseDir = dir
      it.nimOutDir = dir / "nimout"
      # it.refidMap = getRefidLocations(toDir)
      it.codegenDir = some codegenDir

    mkDir wrapConf.nimOutDir

    let files = listFiles(dir, @["hpp", "cpp"])
    echov files
    wrapWithConf(files, wrapConf, baseCppParseConf)

  test "Create DB":
    let db = generateDocDb(toDir, loadLocationMap(
      codegenDir / baseCppWrapConf.refidFile))

    discard generateDocDb(
      dir / "nimout" /. "file.nim",
      startDb = db,
      fileLib = some("finalize"),
      extraLibs = @{
        findPackage(
          "hcparse", newVRAny()).get().projectImportPath(): "hcparse",
        findPackage("hmisc", newVRAny()).get().projectImportPath(): "hmisc"
      },
      orgComments = @["finalize"]
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
