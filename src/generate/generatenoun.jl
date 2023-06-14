function accentultima(s,ortho)
end

"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(stem::NounStem, rule::NounRule;
    ortho::GreekOrthography = literaryGreek())
    raw = stemstring(stem) * ending(rule)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)  |> knormal

    else
        try
            if stem.accentpersistence == "recessive"
                stripmetachars(accentword(raw, :RECESSIVE, ortho))  |> knormal
            
            elseif stem.accentpersistence == "stemaccented"
                stripmetachars( accentword(raw, :PENULT, ortho))  |> knormal

            elseif stem.accentpersistence == "obliqueaccented"
                @info("HANDLING CASE OF obliqueaccented for $(raw)")
                caselabel = label(gmpCase(rule))   
                @info("LOOK AT CASE LABEL $(caselabel)")
                sylls = syllabify(raw)
                @info("SYLLABLES: $(sylls)")

                if caselabel == "genitive" || caselabel == "dative"    
                    if PolytonicGreek.longsyllable(sylls[end], ortho)
                        stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                    else
                        stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                    end
                    
                else
                    if length(sylls) == 1
                        if PolytonicGreek.longsyllable(sylls[end], ortho)
                            stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                        else
                            stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                        end
                        
                    else
                        stripmetachars( accentword(raw, :PENULT, ortho))  |> knormal
                    end
                end
                


            else 
                # place correct accent on ultima:
                @debug("ACC.ULTIMA:", raw)
                caselabel = label(gmpCase(rule))   
                if caselabel == "genitive" || caselabel == "dative"
                    stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                    
                else
                    stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                    
                end
            end
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw) (lexeme $(lexeme(stem)))")

        end
    end
end


"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function nounformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "20$(n)000$(g)$(c)00")
            end
        end
    end
    formlist
end

"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function nounforms()
    nounformcodes() .|> gmfNoun
end

