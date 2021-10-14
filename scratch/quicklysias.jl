using Kanones.FstBuilder
using Kanones
using CitableParserBuilder
import CitableParserBuilder: CitableTrait
using DelimitedFiles


function lysiasparser()
    fstsrc  =  joinpath(pwd(), "fst")
    coreinfl = joinpath(pwd(), "datasets", "core-infl")
    corevocab = joinpath(pwd(), "datasets", "core-vocab")
    lysias = joinpath(pwd(), "datasets", "lysias")
    lysiasnouns = joinpath(pwd(),  "datasets","lysias-nouns")

    datasets = [corevocab, coreinfl, lysias, lysiasnouns]
    kd = Kanones.Dataset(datasets)
    tgt = joinpath(pwd(),  "parsers", "lysiasparser")
    buildparser(kd,fstsrc, tgt)
end


p = lysiasparser()


function missingnouns()
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


p = lysiasparser()

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