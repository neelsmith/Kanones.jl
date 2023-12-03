# Parser backed by a DataFrame



"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct DFParser <: KanonesParser
    df::DataFrame
end


"""Create a `DFParser` from delimited text file.
$(SIGNATURES)
"""
function dfParser(delimitedfile)
    @info("Reading delimited-text file $(delimitedfile)...")
    CSV.File(delimitedfile) |> DataFrame |> DFParser
end

function parsetoken(s::AbstractString, parser::DFParser; data = nothing)
    @debug("SEARCH FOR $(knormal(s))...")
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

"""Find unique lexemes recognized by a parser.
$(SIGNATURES)
"""
function lexemes(dfp::DFParser)
    Array{String}(DataFrames.select(dfp.df, :Lexeme)) |> unique
end






"""Build a new `DFParser` by adding a further dataset
to an existing parser. 

- `dfp` is an existing `DFParser`.
- `rulesds` is the dataset used to build `sp`
- `newdata` is an additional dataset with any new content (rules or vocab)
"""
function concat_ds(dfp::DFParser, rulesds::FilesDataset, newdata::FilesDataset; interval = 100)
    rules_all = vcat(rulesarray(rulesds), rulesarray(newdata))
    stems_new = stemsarray(newdata)

    analyses = []
    for (i, stem) in enumerate(stems_new)
        @info("stem $(i)… $(stem)")
        if i % interval == 0
            @info("stem $(i)… $(stem)")
        end
        append!(analyses, buildparseable(stem, rules_all, delimiter = ","))
    end
    temp_sp = analyses |> StringParser
    temp_f = tempname()
    tofile(temp_sp,temp_f; delimiter = ",")
    dfp2 = dfParser(temp_f)
    rm(temp_f)
    DFParser(vcat(dfp.df, dfp2.df) )
    
end