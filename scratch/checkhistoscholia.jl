using HTTP
using CSV
using DataFrames
using DelimitedFiles



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
function reportscore(terms, parser)
    if ! isdir("reports")
        mkdir("reports")
    end
    #terms = lowercase.(hist[:,1])
    #freqs = hist[:,2]
    parses = parsewordlist(parser, terms)
    checkboxes = checklist.(parses)
    scorecard = hcat(terms, checkboxes)
    writedlm("reports/scorecard.cex", scorecard, '|')     

    badonly = []
    for i in 1:length(terms)
        if checkboxes[i] == "❌"
            #push!(badonly, string(terms[i], "|", freqs[i], "| ❌"))
            push!(badonly, string(terms[i], " ❌"))
        end
    end
    writedlm("reports/failed.cex", badonly, '|')
end

# Rinse, lather, repeat:
# build new parser, reparse list
p = scholiaparser()

# Report on previous list of failures
fails = readdlm("reports/failed.cex")[:,:1]

reportscore(lowercase.(fails), p)



# Report on histogram
url = "https://raw.githubusercontent.com/hmteditors/composite-summer21/main/data/histowaccs-scholia-tweaked.cex"
lnsdf = CSV.File(HTTP.get(url).body) |> DataFrame
lns = lowercase.(lnsdf[:, :1])
reportscore(lns[1:1000][:,:1], p)
