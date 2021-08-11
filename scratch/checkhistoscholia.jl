using HTTP
using CSV
using DataFrames

url = "https://raw.githubusercontent.com/hmteditors/composite-summer21/main/data/histowaccs-scholia-tweaked.cex"
lnsdf = CSV.File(HTTP.get(url).body) |> DataFrame

#f = "histo-1-wbreathings.cex"
#lns = readdlm(f, '|')



using Kanones.FstBuilder
using Kanones

# Build a parser with datasets for Lysias 1.
function scholiaparser()
    fstsrc  =  pwd() * "/fst/"
    coreinfl = pwd() * "/datasets/core-infl/"
    corevocab = pwd() * "/datasets/core-vocab/"
    lysias = pwd()  * "/datasets/lysias/"
    scholia = pwd()  * "/datasets/scholia/"

    datasets = [corevocab, coreinfl, lysias, scholia]
    kd = Kanones.Dataset(datasets)
    tgt = pwd() * "/parsers/scholiaparser/"
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
    terms = lowercase.(hist[:,1])
    #freqs = hist[:,2]
    parses = parsewordlist(parser, terms)
    checkboxes = checklist.(parses)
    scorecard = hcat(hist, checkboxes)
    writedlm("scorecard.cex", scorecard, '|')     

    badonly = []
    for i in 1:length(terms)
        if checkboxes[i] == "❌"
            push!(badonly, string(terms[i], " ❌"))
        end
    end
    writedlm("failed.txt", badonly, '|')
end

# Rinse, lather, repeat:
# build new parser, reparse list
lns = lowercase.(lnsdf[:, :1])
p = scholiaparser()
reportscore(lns[1:1500], p)
