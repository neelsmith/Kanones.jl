using HTTP
using CSV
using DataFrames
using DelimitedFiles


coreinfl = pwd() * "/datasets/core-infl/"
corevocab = pwd() * "/datasets/core-vocab/"
lysias = pwd()  * "/datasets/lysias/"
scholia = pwd()  * "/datasets/scholia/"

lysiasdatasets =  [ coreinfl, corevocab,lysias]
scholiadatasets = [corevocab, coreinfl, lysias, scholia]



using Kanones.FstBuilder
using Kanones

# Build a parser with datasets for Lysias 1.
function kparser(kd)
    tgt = Kanones.Dataset(pwd() * "/parsers/kanones/")
    fstsrc  =  pwd() * "/fst/"
    buildparser(kd, fstsrc, tgt)
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
p = kparser(lysiasdatasets)
#p = parser(scholiadatasets)

# Report on previous list of failures
fails = readdlm("reports/failed.cex")[:,:1]

reportscore(lowercase.(fails), p)



# Report on histogram of scholia
url = "https://raw.githubusercontent.com/hmteditors/composite-summer21/main/data/histowaccs-scholia-tweaked.cex"
lnsdf = CSV.File(HTTP.get(url).body) |> DataFrame
lns = lowercase.(lnsdf[:, :1])
reportscore(lns[1:1000], p)



# Report on histogram of Lysias 1
lysiasurl = "https://raw.githubusercontent.com/hellenike/texts/main/data/histo-1-wbreathings.cex"

lysiaslnsdf = CSV.File(HTTP.get(lysiasurl).body) |> DataFrame
lysiaslns = lowercase.(lysiaslnsdf[:, :1])


reportscore(lysiaslns, p)