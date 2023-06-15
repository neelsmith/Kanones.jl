
"""Generate a form for a given adjective stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(stem::AdjectiveStem, rule::AdjectiveRule;           ortho::GreekOrthography = literaryGreek())
    raw = stemstring(stem) * ending(rule)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw) |> knormal

    else
        
        try
            if stem.accentpersistence == "recessive"
                stripmetachars(accentword(raw, :RECESSIVE, ortho))  |> knormal
            
            elseif stem.accentpersistence == "stemaccented"
                stripmetachars( accentword(raw, :PENULT, ortho))  |> knormal
            
            else 
                # place correct accent on ultima:
                
                caselabel = label(gmpCase(rule))   
                @debug("ACC.ULTIMA:", raw)
                @debug("Case: $(caselabel)")
                if caselabel == "genitive" || caselabel == "dative"
                    stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                    
                else
                    stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                    
                end
            end
        catch e
            @warn("Failed to create accented adjective", e)
            @warn("Raw word: $(raw)")

        end
    end
end





"""Generate list of codes for all adjective forms.
$(SIGNATURES)
"""
function adjectiveformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    degreeints = keys(degreelabeldict) |> collect |> sort
    formlist = []
    for d in degreeints
        for n in numints
            for g in genderints
                for c in caseints
                    push!(formlist, "$(ADJECTIVE)0$(n)000$(g)$(c)$(d)0")
                end
            end
        end
    end
    formlist
end

"""Generate list of all possible adjective forms.
$(SIGNATURES)
"""
function adjectiveforms()
    adjectiveformcodes() .|> gmfAdjective
end