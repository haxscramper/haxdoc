import nimtraits/xml_to_types
import hmisc/other/[oswrap, hshell]
import hnimast
import hmisc/hdebug_misc

const dir = currentSourceDir()

proc doxygenXmlGenerate() =
  let compound = cwd() /. "extract/doxygen_compound.nim"
  generateForXsd(cwd() /. "extract/doxygen_compound.xsd").
    writeXsdGenerator(compound)

  let index = cwd() /. "extract/doxygen_index.nim"
  generateForXsd(cwd() /. "extract/doxygen_index.xsd").
    writeXsdGenerator(index)

  execShell shellCmd(nim, check, errormax = 2, $compound)
  execShell shellCmd(nim, check, errormax = 2, $index)

  echo "Doxygen generate done"

  execShell shellCmd(nim, r, "extract/from_doxygen_xml.nim")
  echo "Compilation ok"



when isMainModule:
  if paramCount() == 0:
    startHax()
    doxygenXmlGenerate()

  else:
    case paramStr(0):
      of "doxygen": doxygenXmlGenerate()
