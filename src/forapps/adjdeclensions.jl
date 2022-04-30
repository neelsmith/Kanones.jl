


"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function md_3endingadj(lex::LexemeUrn, kd::Kanones.Dataset)
    labels = ["nominative", "genitive", "dative", "accusative", "vocative"]
    lines = [
        "| | Masculine | Feminine | Neuter |", 
        "| --- | --- | --- | --- |"
    ]

    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    if isempty(stemmatches)
        throw(DomainError("No stems found for lexeme $(lex)"))
    elseif length(stemmatches) != 1
        @warn("More than one stem found for $(lex): using first stem.")
    end
    stem = stemmatches[1]
    declinedforms = []

    rules = filter(r ->   rulesarray(kd))

    #for i in 1:5
    #    push!(lines, string("| **", labels[i], "** | ", arry[i], " | ", arry[i + 5], " |"))
    #end
    #join(lines,"\n")
end
