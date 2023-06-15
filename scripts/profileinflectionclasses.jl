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


inflclasspairs = map(lulist) do lex
   filter(inflindex) do pr
        pr[1] == lex
    end 
end |> Iterators.flatten |> collect

inflclasslist = map(pr -> pr[2], inflclasspairs)
counts = countmap(inflclasslist)
histodata = sort!(OrderedDict(counts); byvalue=true, rev=true)

f = joinpath(pwd(), "cexcollections", "inflectionclasses-literarygreek.cex")
inflclasses = Kanones.icfromfile(f)

supercounts = Kanones.superclasshistogram(inflclasses, histodata)
#

verbclasses = filter(ic -> ic.pos == "verb", inflclasses)
verbclasslist = map(ic -> ic.inflectionclass, verbclasses) .|> string
verbclasscounts = filter(histodata) do (k,v)
    k in verbclasslist
end

for (k,v) in verbclasscounts
    nounclass = filter(ic -> ic.inflectionclass == k, inflclasses)[1]
    println(string(v, ". ", label(nounclass)))
end

adjectiveclasses = filter(ic -> ic.pos == "adjective", inflclasses)
adjclasslist = map(ic -> ic.inflectionclass, adjectiveclasses) .|> string
adjclasscounts = filter(histodata) do (k,v)
    k in adjclasslist
end

for (k,v) in adjclasscounts
    nounclass = filter(ic -> ic.inflectionclass == k, inflclasses)[1]
    println(string(v, ". ", label(nounclass)))
end

