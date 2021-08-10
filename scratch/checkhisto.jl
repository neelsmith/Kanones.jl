using DelimitedFiles

f = "histo-1-wbreathings.cex"
lns = readdlm(f, '|')

using Kanones.FstBuilder
using Kanones

# Build a parser with datasets for Lysias 1.
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


# Format a checkbox column
function checklist(v)
    nope  = "❌"
    yes = "✔️"
    isempty(v) ? nope : yes
end


# Write a report on coverage.
# - hist is a delimited-text histogram
# - parser is a Kanones parser.
function reportscore(hist, parser)
    terms = hist[:,1]
    #freqs = hist[:,2]
    parses = parsewordlist(parser, terms)
    checkboxes = checklist.(parses)
    scorecard = hcat(hist, checkboxes)
    writedlm("scorecard.cex", scorecard, '|')     
end

# Rinse, lather, repeat:
# build new parser, reparse list
p = lysiasparser()
reportscore(lns, p)



