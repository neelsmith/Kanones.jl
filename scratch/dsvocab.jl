# Look at vocab list (lexemes) in a dataset.
using Kanones
using HTTP
using CSV 
using CitableParserBuilder


corevocab = pwd() * "/datasets/core-vocab/"
coreinfl = pwd() * "/datasets/core-infl/"
coreds = [coreinfl, corevocab]

ds = Kanones.Dataset(coreds)
lexurns = map(s -> s.lexid, stemsarray(ds)) 
lexlist = string.(lexurns) |> unique

lsjurl = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/lsj/lsj-lemmata.cex"

lsjdict = CSV.File(HTTP.get(lsjurl).body) |> Dict


labelled = map(au -> Kanones.attach_lemma(string(au), lsjdict), lexlist )



stems[1] |> typeof

stems = stemsarray(ds)
labelled |> length

filter(s -> isa(s,Kanones.NounStem ), stems)

typelist = map(s -> typeof(s), stems) |> unique
println(typelist)
