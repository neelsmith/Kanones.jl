"""Compose markdown table to display declension of a pronoun.
$(SIGNATURES)
"""
function pronoun_md(lex::LexemeUrn, kd::Kanones.FilesDataset)

    stems = filter(s -> lexeme(s) == lex, stemsarray(kd))
    if isempty(stems)
        throw(DomainError("No stems found for lexeme $(lex)"))
    end

    labels = ["nominative", "genitive", "dative", "accusative"]
    caselist = map(l -> gmpCase(l), labels)

    lines = [
        "| | Masculine | Feminine | Neuter |", 
        "| --- | --- | --- | --- |"
    ]
    push!(lines, "| *singular* |  |  |  |")
    for i in 1:length(labels)
        mform = ""
        mstems = filter(stem -> gmpNumber(stem) == gmpNumber("singular") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("masculine"), stems)
        if length(mstems) == 1
            mform = mstems[1].form
        else
            @warn("Could not find matching stem for masc. $(labels[i]) sing.")
        end
        
        fform = ""
        fstems = filter(stem -> gmpNumber(stem) == gmpNumber("singular") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("feminine"), stems)
        if length(fstems) == 1
            fform = fstems[1].form
        else
            @warn("Could not find matching stem for fem. $(labels[i]) sing.")
        end

        nform = ""
        nstems = filter(stem -> gmpNumber(stem) == gmpNumber("singular") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("neuter"), stems)
        if length(nstems) == 1
            nform = nstems[1].form
        else
            @warn("Could not find matching stem for neut. $(labels[i]) sing.")
        end
 
        push!(lines, string("| **", labels[i], "** | ", mform, " | ", fform , " | ", nform, " |"))
    end


    push!(lines, "| *plural* |  |  |  |")
    for i in 1:length(labels)
        mform = ""
        mstems = filter(stem -> gmpNumber(stem) == gmpNumber("plural") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("masculine"), stems)
        if length(mstems) == 1
            mform = mstems[1].form
        else
            @warn("Could not find matching stem for masc. $(labels[i]) pl.")
        end
        
        fform = ""
        fstems = filter(stem -> gmpNumber(stem) == gmpNumber("plural") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("feminine"), stems)
        if length(fstems) == 1
            fform = fstems[1].form
        else
            @warn("Could not find matching stem for fem. $(labels[i]) pl.")
        end

        nform = ""
        nstems = filter(stem -> gmpNumber(stem) == gmpNumber("plural") && gmpCase(stem) == caselist[i] && gmpGender(stem) == gmpGender("neuter"), stems)
        if length(nstems) == 1
            nform = nstems[1].form
        else
            @warn("Could not find matching stem for neut. $(labels[i]) pl.")
        end
 
        push!(lines, string("| **", labels[i], "** | ", mform, " | ", fform , " | ", nform, " |"))
        
    end


    join(lines,"\n")
end
