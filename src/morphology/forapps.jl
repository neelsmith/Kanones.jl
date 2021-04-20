
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