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


infclasspairs = map(lulist) do lex
   filter(inflindex) do pr
        pr[1] == lex
    end |> Iterators.flatten |> collect
end

inflclasslist = map(pr -> pr[2], infclasspairs)




counts = countmap(inflclasslist)
histodata = sort!(OrderedDict(counts); byvalue=true, rev=true)

f = joinpath(pwd(), "cexcollections", "inflectionclasses-literarygreek.cex")
isfile(f)
data = readlines(f)[3:end]
# get all verb classes:

verblines = filter(ln -> startswith(ln, "verb|"), data)
verbclasses = map(verblines) do ln
    split(ln, "|")[2]
end


histotuples = []
for (s,c) in histodata
    push!(histotuples, (class = s, count = c))
end

verbcounts = filter(t -> t.class in verbclasses, histotuples)
map(tup -> tup.count, verbcounts) |> sum



inflclasses = Kanones.icfromfile(f)


nounclasses = filter(ic -> ic.pos == "noun", inflclasses)
nounclasslist = map(ic -> ic.inflectionclass, nounclasses) .|> string
nounclasscounts = filter(histodata) do (k,v)
    k in nounclasslist
end

for (k,v) in nounclasscounts
    nounclass = filter(ic -> ic.inflectionclass == k, inflclasses)[1]
    println(string(v, ". ", label(nounclass)))
end



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
