using DelimitedFiles

f = "histo-1-wbreathings.cex"
lns = readdlm(f, '|')
terms = lns[:,1]
freqs = lns[:,2]

using Kanones.FstBuilder
using Kanones


function lysiasparser()
    fstsrc  =  pwd() * "/fst/"
    coreinfl = pwd() * "/datasets/core-infl/"
    corevocab = pwd() * "/datasets/core-vocab/"
    lysias = pwd()  * "/datasets/lysias/"

    datasets = [corevocab, coreinfl, lysias]
    kd = Kanones.Dataset(datasets)
    tgt = pwd() * "/parsers/lysiasparser/"
    buildparser(kd,fstsrc, tgt)
end

p = lysiasparser()


parses = parsewordlist(p, terms)

parses |> length

zip(lns, parses)