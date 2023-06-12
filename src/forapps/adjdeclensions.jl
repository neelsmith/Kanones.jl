


"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function md_3endingadj(lex::LexemeUrn, degree::GMPDegree, kd::Kanones.FilesDataset)
    stemmatches = filter(s -> lexeme(s) == lex, stemsarray(kd))
    if isempty(stemmatches)
        throw(DomainError("No stems found for lexeme $(lex)"))
    elseif length(stemmatches) != 1
        @warn("More than one stem found for $(lex): using first stem.")
    end
    stem = stemmatches[1]
    rules = filter(r ->  inflectionclass(r) == inflectionclass(stem) && gmpDegree(r) == degree, rulesarray(kd))

    labels = ["nominative", "genitive", "dative", "accusative"]
    caselist = map(l -> gmpCase(l), labels)

    lines = [
        "| | Masculine | Feminine | Neuter |", 
        "| --- | --- | --- | --- |"
    ]
    push!(lines, "| *singular* |  |  |  |")
    for i in 1:length(labels)
        mform = ""
        mrules = filter(r -> gmpNumber(r) == gmpNumber("singular") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("masculine"), rules)
        if ! isempty(mrules)
            generated = generate(lex, formurn(mrules[1]),  kd)
            mform = join(generated,", ")
        end

        fform = ""
        frules = filter(r -> gmpNumber(r) == gmpNumber("singular") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("feminine"), rules)
        if ! isempty(frules)
            generated = generate(lex, formurn(frules[1]),  kd)
            fform = join(generated,", ")
        end



        nform = ""
        nrules = filter(r -> gmpNumber(r) == gmpNumber("singular") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("neuter"), rules)
        if ! isempty(frules)
            generated = generate(lex, formurn(nrules[1]),  kd)
            nform = join(generated,", ")
        end

        push!(lines, string("| **", labels[i], "** | ", mform, " | ", fform , " | ", nform, " |"))
    end
    push!(lines, "| *plural* |  |  |  |")
    for i in 1:length(labels)
        mform = ""
        mrules = filter(r -> gmpNumber(r) == gmpNumber("plural") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("masculine"), rules)
        if ! isempty(mrules)
            generated = generate(lex, formurn(mrules[1]),  kd)
            mform = join(generated,", ")
        end

        fform = ""
        frules = filter(r -> gmpNumber(r) == gmpNumber("plural") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("feminine"), rules)
        if ! isempty(frules)
            generated = generate(lex, formurn(frules[1]),  kd)
            fform = join(generated,", ")
        end



        nform = ""
        nrules = filter(r -> gmpNumber(r) == gmpNumber("plural") && gmpCase(r) == caselist[i] && gmpGender(r) == gmpGender("neuter"), rules)
        if ! isempty(frules)
            generated = generate(lex, formurn(nrules[1]),  kd)
            nform = join(generated,", ")
        end

        push!(lines, string("| **", labels[i], "** | ", mform, " | ", fform , " | ", nform, " |"))
    end


    

    join(lines,"\n")
end
