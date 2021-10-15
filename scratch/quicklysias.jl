using Kanones.FstBuilder
using Kanones
using CitableParserBuilder


function lysiasparser(rootdir)
    fstsrc  =  joinpath(rootdir, "fst")
    coreinfl = joinpath(rootdir, "datasets", "core-infl")
    corevocab = joinpath(rootdir, "datasets", "core-vocab")
    lysias = joinpath(pwd(), "datasets", "lysias")
    lysiasnouns = joinpath(rootdir,  "datasets","lysias-nouns")

    datasets = [corevocab, coreinfl, lysias, lysiasnouns]
    kd = Kanones.Dataset(datasets)
    tgt = joinpath(rootdir,  "parsers", "lysiasparser")
    buildparser(kd,fstsrc, tgt)
end
p = lysiasparser(pwd())


# Get a corpus of Lysias 1.
using CitableText, CitableCorpus
f = joinpath("scratch", "lysias1.cex")
c = read(f) |> corpus_fromcex
psg = c.passages[7]
# Work with a single passage, like Lysias 1.7
lys1_7 = CitableTextCorpus([psg])

using PolytonicGreek, Orthography
ortho = literaryGreek()


function missingnouns()
    using DelimitedFiles
    nouns = "/Users/nsmith/Desktop/lysias-nouns.txt"
    nounlist = readdlm(nouns, '\t')
    # Drop header
    parses = parsewordlist(nounlist[2:end], p)
    labelledparses = hcat(nounlist[2:end], parses)
    #labelledparses |> typeof
    #labelledparses |> size
    missinglist = []
    for i in 1:size(labelledparses,1)
        if isempty(labelledparses[i,2])
            push!(missinglist, labelledparses[i,1])
        end
    end
    missinglist
end
    



p = lysiasparser()
open("missinglysiasnouns.txt", "w") do io
    write(io, join(missingnouns(), "\n"))
end



function missingverbs()
    verbfile = "lysverbs1.txt"
    verblist = readdlm(verbfile, '\t')
    # Drop header
    parses = parsewordlist(p, verblist[2:end])
    labelledparses = hcat(verblist[2:end], parses)
    #labelledparses |> typeof
    #labelledparses |> size
    missinglist = []
    for i in 1:size(labelledparses,1)
        if isempty(labelledparses[i,2])
            push!(missinglist, labelledparses[i,1])
        end
    end
    missinglist
end
p = lysiasparser(pwd())

open("missinglysiasverbs.txt", "w") do io
    write(io, join(missingverbs(), "\n"))
end

######


# All words in Lysias
f = "test/testdata/wordlist.txt"
parses = parselistfromfile(p, f)




u = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/test/testdata/wordlist.txt"
using HTTP
words = split(String(HTTP.get(u).body) , "\n")


# Do CEX formatting to create a dictionary of tokens to serialzed analyses:
prs = zip(words,parses) |> collect
cexlines = []
for pr in prs
    if isempty(pr[2])
        push!(cexlines, string(pr[1],"|"))
    else
        for id in pr[2]
            push!(cexlines, string(pr[1],"|", CitableParserBuilder.cex(id)))
        end
    end
end

open("scratch/analyses.cex","w") do io
    write(io, join(cexlines,"\n"))
end