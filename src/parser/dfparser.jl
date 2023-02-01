# Parser backed by a DataFrame



"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct DFParser <: KanonesParser
    df::DataFrame
end


"""Create a `DFParser` from delimited text file.
$(SIGNATURES)
"""
function dfParser(delimitedfile)
    @info("Reading delimited-text file $(delimited)")
    CSV.File(delimitedfile) |> DataFrame |> DFParser
end

function parsetoken(s::AbstractString, parser::DFParser; data = nothing)
    resultdf = subset(parser.df, :Token => t -> t .== knormal(s))

    resultarray = Analysis[]

    for r in eachrow(resultdf)
        a =  Analysis(
            r.Token, 
            LexemeUrn(r.Lexeme),
            FormUrn(r.Form),
            StemUrn(r.Stem),
            RuleUrn(r.Rule)
        )
        push!(resultarray, a)
    end
    resultarray
end