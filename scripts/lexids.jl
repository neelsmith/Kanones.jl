# Check for duplicate entries in lexids lists
using Kanones
using Unicode 
using StatsBase
using CitableParserBuilder

lsjdict = Kanones.lsjid_dict()
fulldict = Kanones.lexid_dict()

lsjkeys = keys(lsjdict) |> collect
allkeys = keys(fulldict) |> collect

repodir  = pwd()
lsjraw = joinpath(repodir, "datasets", "lsj-vocab", "lexemes", "lsj.cex") |> readlines
lsjxraw = joinpath(repodir, "datasets", "lsj-vocab", "lexemes", "lsjx.cex")|> readlines


datalines = filter(vcat(lsjraw[2:end], lsjxraw[2:end])) do ln
    !isempty(ln)
end



simple_lemms = map(datalines) do ln
    pieces = split(ln, "|")
    Unicode.normalize(pieces[2], stripmark = true)
end

@info(length(simple_lemms))
@info(length(unique(simple_lemms)))

counts = countmap(simple_lemms)


dupes = filter( kv -> kv.second > 1, counts) |> keys |> collect

datatriples = map(datalines) do ln
    pieces = split(ln, "|")
    (lemma = pieces[2], lexeme = LexemeUrn(pieces[1]), stripped = Unicode.normalize(pieces[2], stripmark = true))
end


dupetriples = filter(trip -> trip.stripped in dupes, datatriples)

cex = map(dupetriples) do tr
    join([tr.stripped, tr.lemma, string(tr.lexeme)], "|")
end |> sort


open("dupelemmas.txt", "w") do io
    write(io, join(cex, "\n"))
end

