"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(stem::NounStem, rule::NounRule;
    ortho::GreekOrthography = literaryGreek())
    raw = stemstring(stem) * ending(rule)
    @debug("Generate noun raw $(raw) with accent $(stem.accentpersistence)")
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)  |> knormal

    elseif stem.accentpersistence == "recessive"
        try
            stripmetachars(accentword(raw, :RECESSIVE, ortho))  |> knormal
        catch e
            @warn("Failed to create accented form")
            @warn("Generate noun: raw word: $(raw) (lexeme $(lexeme(stem)))")
            throw(e)
        end
    
    elseif stem.accentpersistence == "stemaccented"
        try
            stripmetachars( accentword(raw, :PENULT, ortho))  |> knormal
        catch e
            @warn("Failed to create accented form")
            @warn("Generate noun: raw word: $(raw) (lexeme $(lexeme(stem)))")
            throw(e)
        end
            
    elseif stem.accentpersistence == "obliqueaccented"
        @debug("HANDLING CASE OF obliqueaccented for $(raw)")
        caselabel = label(gmpCase(rule))   
        @debug("LOOK AT CASE LABEL $(caselabel)")
        sylls = syllabify(raw)
        @debug("SYLLABLES: $(sylls)")

        
        if caselabel == "genitive" || caselabel == "dative"    
            try
                if PolytonicGreek.longsyllable(sylls[end], ortho)
                    stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                else
                    stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                end
            catch e
                @warn("Failed to create accented form for accented gentive")
                @warn("Generate noun: raw word: $(raw) (lexeme $(lexeme(stem)))")
                throw(e)
            end
                
        else # not oblique case
           
            try
                if length(sylls) == 1
                    if PolytonicGreek.longsyllable(sylls[end], ortho)
                        stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                    else
                        stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                    end
                    
                else
                    stripmetachars( accentword(raw, :PENULT, ortho))  |> knormal
                end
            catch e
                @warn("Failed to create accented form")
                @warn("Generate noun: raw word: $(raw) (lexeme $(lexeme(stem)))")
                throw(e)
            end
        end
   


    else # inflection accented
                  
        endingsylls = syllabify(ending(rule))
        @debug("Trying accented inflection for ending sylls $(endingsylls)") 
        @debug("CHECK SYLLABLE COUNT:", length(endingsyll))
        if length(endingsylls) > 1
            accentedending =  accentword(ending(rule), :RECESSIVE, ortho)

            stemstring(stem) * accentedending |> knormal

        else
            # place correct accent on ultima:
            @debug("ACC.ULTIMA:", raw)
            caselabel = label(gmpCase(rule))   
            if caselabel == "genitive" || caselabel == "dative"
                @debug("Accent with circumflex")
                stripmetachars(accentultima(raw, :CIRCUMFLEX, ortho))  |> knormal
                
            else
                @debug("Accent with acute")
                stripmetachars(accentultima(raw, :ACUTE, ortho))  |> knormal
                
            end
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

