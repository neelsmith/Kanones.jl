using Kanones
using CitableBase, CitableCorpus, CitableText
using Orthography, PolytonicGreek
using CitableParserBuilder
using StatsBase, OrderedCollections

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

ds = coredata(atticonly = true)
sp = stringParser(ds)
inflindex = inflclassindex(ds)


eaglbase = joinpath(pwd() |> dirname, "eagl-texts")
lysiasf = joinpath(eaglbase, "texts", "lysias1.cex") 
isfile(lysiasf)

lg = literaryGreek()
corpus = fromcex(lysiasf, CitableTextCorpus, FileReader)
lexcorpus = tokenizedcorpus(corpus,lg, filterby = LexicalToken())
analyzedlexical = parsecorpus(lexcorpus, sp)

lulist = map(analyzedlexical) do lex
    lex.analyses .|> lexemeurn
end |> Iterators.flatten |> collect .|> string


infclasspairs = map(lulist) do lex
   filter(inflindex) do pr
        pr[1] == lex
    end |> Iterators.flatten |> collect
end

inflclasslist = map(pr -> pr[2], infclasspairs)




counts = countmap(inflclasslist)
histodata = sort!(OrderedDict(counts); byvalue=true, rev=true)