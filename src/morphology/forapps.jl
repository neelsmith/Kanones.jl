
"""Decline all case-number combinations of a lexeme.

$(SIGNATURES)
"""
function decline(lex::LexemeUrn, kd::Kanones.Dataset; withvocative::Bool = false)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)
    stemmatches = filter(s -> s.lexid == lex, nounstems)
    
    # Make sure stemmatches is not empty first:
    if isempty(stemmatches)
        @warn "No matches in dataset for lexeme $lex"
        nothing

    else
        gender = stemmatches[1].gender
        # Find gender and construct form ids:
        genderdict = labeldict(genderpairs)
        genderint = genderdict[stemmatches[1].gender]
        sg = [
            FormUrn("morphforms.201000$(genderint)100"),
            FormUrn("morphforms.201000$(genderint)200"),
            FormUrn("morphforms.201000$(genderint)300"),
            FormUrn("morphforms.201000$(genderint)400")
        ]
        # No duals by default
        pl = [
            FormUrn("morphforms.203000$(genderint)100"),
            FormUrn("morphforms.203000$(genderint)200"),
            FormUrn("morphforms.203000$(genderint)300"),
            FormUrn("morphforms.203000$(genderint)400")
        ]

        rules = rulesarray(kd)
        nounrules = filter(r -> typeof(r) == NounRule, rules)

        forms = []
        for srule in sg
            push!(forms, generate(srule,lex,  kd))
        end
        for plrule in pl
            push!(forms, generate(plrule, lex, kd))
        end
        forms
    end
end

"""Compose markdown table with a declension of a single noun.

$(SIGNATURES)
"""
function mddeclension(lex::LexemeUrn, kd::Kanones.Dataset; withvocative::Bool = false)
    labels = ["nominative", "genitive", "dative", "accusative"]
    lines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    arry = decline(lex, kd;  withvocative = withvocative)
    for i in 1:4
        push!(lines, string("| **", labels[i], "** | ", join(arry[i], ", "), " | ", join(arry[i + 4], ", "), " |"))
    end
    join(lines,"\n")
end


function mddeclension(lexlist::Array, kd::Kanones.Dataset; withvocative::Bool = false)
    columns = []
    labels = ["nominative", "genitive", "dative", "accusative"]
    lines = [
        "| | " * repeat(" |", length(lexlist)),
        "| --- | " * repeat( " --- |", length(lexlist))
    ]
    for i in 1:4
        push!(lines, string("| **", labels[i], "** | "))
        for j in 1:length(lexlist)
            push!(columns, decline(lexlist[i], kd; withvocative = withvocative))
            cells = []
            
        end
    end
    join(lines, "\n")
end
 