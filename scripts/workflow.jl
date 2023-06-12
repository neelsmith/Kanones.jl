using Kanones
using CitableBase, CitableCorpus, CitableText
using Orthography, PolytonicGreek
using CitableParserBuilder


# Build a parser with validated vocab from LSJ and hypothesized dataset
# from an LSJMining dataset in adjacent directory.
function alllitgreek(; atticonly = false)
    # 1. demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    ionic = joinpath(pwd(), "datasets", "ionic")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    # 4. hypothesized data from LSJMining
    lsjx = joinpath("..", "LSJMining.jl", "kanonesdata","lsjx")
    atticonly ?  dataset([lgr, lsj, extra, lsjx]) :  dataset([lgr, ionic, lsj, extra, lsjx]) 
end

# Build a parser with demo vocab and manually validated vocab from LSJ.
function coredata(; atticonly = false)
    # 1. rules with demo vocab:
    lgr = joinpath(pwd(), "datasets", "literarygreek-rules")
    ionic = joinpath(pwd(), "datasets", "ionic")
    # 2. manually validated LSJ vocab:
    lsj = joinpath(pwd(), "datasets", "lsj-vocab")
    # 3. manually validated NOT in LSJ:
    extra = joinpath(pwd(), "datasets", "extra")
    atticonly ? dataset([lgr, lsj, extra]) :  dataset([lgr, ionic, lsj, extra]) 
end

ds = coredata(atticonly = true)
sp = stringParser(ds)

eaglbase = joinpath(pwd() |> dirname, "eagl-texts")
lysiasf = joinpath(eaglbase, "texts", "lysias1.cex") 
isfile(lysiasf)
corpus = fromcex(lysiasf, CitableTextCorpus, FileReader)

lg = literaryGreek()
histo =  corpus_histo(corpus, lg, filterby = LexicalToken())
lexcorpus = tokenizedcorpus(corpus,lg, filterby = LexicalToken())
analyzedlexical = parsecorpus(lexcorpus, sp)

failed = filter(at -> isempty(at.analyses), analyzedlexical.analyses)
failedstrs = map(psg -> psg.ctoken.passage.text, failed)
failedfreqs = filter(pr -> pr[1] in failedstrs, collect(histo))

cutoff  = 1
topfails = filter(failedfreqs) do pr
    pr[2] >= cutoff
end

topfailcount =  map(pr -> pr[2], topfails) |> sum
println(topfails)

singletons = filter(pr -> pr[2] == 1, failedfreqs)
println(join(singletons, "\n"))
    

failedfreqs[1:10] |> println