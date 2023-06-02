
"""Find unique lexemes recognized by a parser.
$(SIGNATURES)
"""
function lexemes(dfp::DFParser)
    DataFrames.select(dfp.df, :Lexeme) |> unique
end