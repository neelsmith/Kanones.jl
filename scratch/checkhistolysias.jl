using DelimitedFiles


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
function reportscore(terms, parser, freqs)
    #terms = hist[:,1]
    #freqs = hist[:,2]
    parses = parsewordlist(parser, terms)
    checkboxes = checklist.(parses)
    scorecard = hcat(terms, checkboxes, freqs)
    writedlm("scorecard.cex", scorecard, '|')     

    badonly = []
    for i in 1:length(terms)
        if checkboxes[i] == "❌"
            push!(badonly, string(terms[i], " ❌", freqs[i]))
        end
    end
    writedlm("failed.txt", badonly, '|')
end

# Rinse, lather, repeat:
# build new parser, reparse list
p = lysiasparser()


# Report on histogram
f = "histo-1-wbreathings.cex"
#lns = readdlm(f, '|')
#terms = lns[:,:1]
#counts = lns[:,:2]
#reportscore(terms, p, counts)




# More..
using CSV
using HTTP

lysiasurl = "https://raw.githubusercontent.com/hellenike/texts/main/data/histo-1-wbreathings.cex"

lysiaslnsdf = CSV.File(HTTP.get(lysiasurl).body) |> DataFrame
terms = lowercase.(lysiaslnsdf[:, :1])
counts = lysiaslnsdf[:, :2]


reportscore(terms, p, counts)