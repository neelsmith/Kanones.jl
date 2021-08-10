using Kanones.FstBuilder
using Kanones
using CitableParserBuilder

function scholiaparser()
    fstsrc  =  pwd() * "/fst/"
    coreinfl = pwd() * "/datasets/core-infl/"
    corevocab = pwd() * "/datasets/core-vocab/"
    scholia = pwd()  * "/datasets/scholia/"

    datasets = [corevocab, coreinfl, scholia]
    kd = Kanones.Dataset(datasets)
    tgt = pwd() * "/parsers/scholiaparser/"
    buildparser(kd,fstsrc, tgt)
end


p = scholiaparser()

# All words in scholia
#f = "test/testdata/wordlist.txt"
url = "https://raw.githubusercontent.com/hmteditors/composite-summer21/main/data/wordlist.txt"
parses = parselistfromurl(p, url)

#u = "https://raw.githubusercontent.com/neelsmith/Kanones.jl/main/test/testdata/wordlist.txt"
using HTTP
words = split(String(HTTP.get(url).body) , "\n")


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

open("scratch/scholia-analyses.cex","w") do io
    write(io, join(cexlines,"\n"))
end