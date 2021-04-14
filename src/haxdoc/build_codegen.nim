import nimtraits/xml_to_types
import hmisc/other/[oswrap]
import hnimast

const dir = currentSourceDir()

proc doxygenXmlGenerate() =
  generateForXsd(cwd() /. "extract/doxygen_compound.xsd").writeXsdGenerator(
    cwd() /. "extract/doxygen_compound.nim")

  generateForXsd(cwd() /. "extract/doxygen_index.xsd").writeXsdGenerator(
    cwd() /. "extract/doxygen_index.nim")

  echo "Doxygen generate done"



when isMainModule:
  if paramCount() == 0:
    doxygenXmlGenerate()

  else:
    case paramStr(0):
      of "doxygen": doxygenXmlGenerate()
