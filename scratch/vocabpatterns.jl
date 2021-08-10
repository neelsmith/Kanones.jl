# Test code for use in Pluto nb
using CitableText
	
using CSV
using DataFrames
using HTTP
using Plots
#using StatsBase
using CitableParserBuilder

tknanalysisurl =  "https://raw.githubusercontent.com/hellenike/texts/main/data/analyzededition.cex"




greektknanalysesdf = ismissing(tknanalysisurl) ? missing : CSV.File(HTTP.get(tknanalysisurl).body, skipto=2, delim="|") |> DataFrame

lexicalanalyses =  ismissing(greektknanalysesdf) ? missing :  filter(row -> row[:tokencategory] == "lexical", greektknanalysesdf)

analyzedtokens =  ismissing(lexicalanalyses) ? missing :  filter(row -> row[:analysiscex] != "missing", lexicalanalyses)

analyses = ismissing(analyzedtokens) ? missing : CitableParserBuilder.fromcex.(analyzedtokens[:,:analysiscex])

lexemesByToken = ismissing(analyzedtokens ) ? missing : begin
	newurns = analyzedtokens[:, :urn]
	newlexemes = map(a -> a.lexeme, analyses)	
	
	df = DataFrame(urn = newurns, lexeme = newlexemes)
	unique!(df)
end

numlexicaltokens = ismissing(lexicalanalyses) ? missing : length(unique(lexicalanalyses[:,:urn]))

# Percentage of all lexical tokens represented by a given number of tokens
function pctOfLexicalTokens(n, precision=1)
	round(100.0 * n / numlexicaltokens, digits=precision)
end


numanalyzedtokens = ismissing(analyzedtokens) ? missing : length(unique(analyzedtokens[:,:urn]))


pctanalyzed =	ismissing(numanalyzedtokens) ? missing :  pctOfLexicalTokens(numanalyzedtokens, 1)

numtokenanalyses = ismissing(analyzedtokens) ? missing :  length(analyzedtokens[:, :urn])

numanalyzedforms = ismissing(analyzedtokens) ? missing : length(unique(map(s -> lowercase(s), analyzedtokens[:,:token])))

numlexemes = ismissing(analyses) ? missing : (map(a -> a.lexeme, analyses) |> unique |> length)



lexcounts = ismissing(lexemesByToken) ? missing : begin
	lexmap = countmap(lexemesByToken[:,:lexeme])
        sort(collect(lexmap), by=pr->pr[2], rev=true)
end