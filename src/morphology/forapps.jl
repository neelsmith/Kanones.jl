
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
        #morphchars = split(stemmatches[1].gender,"")
        genderint = genderdict[stemmatches[1].gender]
        sg = [
            FormUrn("morphform.201000$(genderint)100"),
            FormUrn("morphform.201000$(genderint)200"),
            FormUrn("morphform.201000$(genderint)300"),
            FormUrn("morphform.201000$(genderint)400")
        ]
        pl = [
            FormUrn("morphform.202000$(genderint)100"),
            FormUrn("morphform.202000$(genderint)200"),
            FormUrn("morphform.202000$(genderint)300"),
            FormUrn("morphform.202000$(genderint)400")
        ]

        rules = rulesarray(kd)
        nounrules = filter(r -> typeof(r) == NounRule, rules)

        forms = []
        for s in sg
            println("generate $s")
        end
        for p in pl
            println("generate $p")
        end
        forms
    end
end