using Kanones.FstBuilder
using Kanones
using CitableParserBuilder
using DelimitedFiles


function lysiasparser()
    fstsrc  =  pwd() * "/fst/"
    coreinfl = pwd() * "/datasets/core-infl/"
    corevocab = pwd() * "/datasets/core-vocab/"
    lysias = pwd()  * "/datasets/lysias/"
    lysiasnouns = pwd()  * "/datasets/lysias-nouns/"

    datasets = [corevocab, coreinfl, lysias, lysiasnouns]
    kd = Kanones.Dataset(datasets)
    tgt = pwd() * "/parsers/lysiasparser/"
    buildparser(kd,fstsrc, tgt)
end


p = lysiasparser()


function missingnouns()
    nouns = "/Users/nsmith/Desktop/lysias-nouns.txt"
    nounlist = readdlm(nouns, '\t')
    # Drop header
    parses = parsewordlist(p, nounlist[2:end])
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
    

open("missinglysiasnouns.txt", "w") do io
    write(io, join(missingnouns(), "\n"))
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