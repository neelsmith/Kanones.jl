
#=
This is what the Scala build looks like:

val corpusDir = parsers / corpusList.mkString("-")

installAlphabet(dataSource, corpusList, parsers)
AcceptorComposer(parsers, corpusList)
SymbolsComposer(corpusDir, fstSource)
InflectionComposer(corpusDir)
ParserComposer(corpusDir)
MakefileComposer(corpusDir, fstcompiler)

=#