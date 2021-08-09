using Kanones.FstBuilder
using Kanones


fstsrc  =  pwd() * "/fst/"

coreinfl = pwd() * "/datasets/core-infl/"
corevocab = pwd() * "/datasets/core-vocab/"
lysias = pwd()  * "/datasets/lysias/"

datasets = [corevocab, coreinfl, lysias]

kd = Kanones.Dataset(datasets)


tgt = pwd() * "/parsers/comboparser/"
parser = buildparser(kd,fstsrc, tgt)


#=
coreex = "ἀπό"
synex = "γνώμη"
lysex = "τέχνης"

parsetoken(parser, coreex)
parsetoken(parser, synex)
parsetoken(parser, lysex)
=#

# All words in Lysias
f = "test/testdata/wordlist.txt"
parses = parselistfromfile(parser, f)

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
            push!(cexlines, string(pr[1],"|", cex(id)))
        end
    end
end

open("analyses.cex","w") do io
    write(io, join(cexlines,"\n"))
end