using Kanones.FstBuilder
using Kanones
using CitableParserBuilder
using CitableText, CitableCorpus
using PolytonicGreek, Orthography


# Get a corpus of Lysias 1 and make tokenized version
f = joinpath(pwd(), "scratch", "lysias1.cex")
c = read(f) |> corpus_fromcex
ortho = literaryGreek()
tknized = tokenizedcorpus(c,ortho)


# Build lysias parser
function lysiasparser(rootdir)
    fstsrc  =  joinpath(rootdir, "fst")
    coreinfl = joinpath(rootdir, "datasets", "core-infl")
    corevocab = joinpath(rootdir, "datasets", "core-vocab")
    lysias = joinpath(pwd(), "datasets", "lysias")
    lysiasnouns = joinpath(rootdir,  "datasets","lysias-nouns")

    datasets = [corevocab, coreinfl, lysias, lysiasnouns]
    kd = Kanones.Dataset(datasets)
    tgt = joinpath(rootdir,  "parsers", "lysiasparser")
    buildparser(kd,fstsrc, tgt; force = true)
end


function reparse(tkncorpus, parser)
    parsed = parsecorpus(tkncorpus, parser)
    open(joinpath(pwd(), "scratch", "lysias_parsed.cex"),"w") do io
        write(io, delimited(parsed))
    end
end

function rebuild()
    p = lysiasparser(pwd())
    reparse(tknized, p)
end

#psg = c.passages[7]
# Work with a single passage, like Lysias 1.7
#lys1_7 = CitableTextCorpus([psg])


map(psg -> passage_component(psg.urn), c.passages)

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
    
p = lysiasparser(pwd())
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