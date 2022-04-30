


"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function md_ptcpl(lex::LexemeUrn, tense::GMPTense, voice::GMPVoice, kd::Kanones.Dataset)
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    if isempty(stemmatches)
        throw(DomainError("No stems found for lexeme $(lex)"))
    elseif length(stemmatches) != 1
        @warn("More than one stem found for $(lex): using first stem.")
    end
    stem = stemmatches[1]
    rules = filter(r ->  gmpTense(r) == tense && gmpVoice(r) == voice, rulesarray(kd))

    labels = ["nominative", "genitive", "dative", "accusative", "vocative"]
    caselist = map(l -> gmpCase(l), labels)

    lines = [
        "| | Masculine | Feminine | Neuter |", 
        "| --- | --- | --- | --- |"
    ]
    for i in 1:5
        mrules = filter(r -> gmpNumber(r) == gmpNumber("singular") && gmpCase(r) == caselist[i], rules)
        mform = ""
        if ! isempty(mrules)
            generated = generate(lex, mrules[1],  kd)
        end

        fform = ""
        nform = ""

       push!(lines, string("| **", labels[i], "** | ", mform, " | ", fform , " | ", nform, " |"))
    end
    join(lines,"\n")
end
