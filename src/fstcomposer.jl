
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


function installalphabet(src::Kanones.Dataset, target::AbstractString)
    srcfile = src.root * "/orthography/alphabet.fst"
    targetdir = target * "/symbols/"
    if ! ispath(targetdir)
        mkdir(targetdir)
    end
    targetfile = targetdir * "/alphabet.fst"
    println("COPY $(srcfile) TO $(targetfile)")
    cp(srcfile, targetfile)
end