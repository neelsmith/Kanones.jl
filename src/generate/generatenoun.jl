
"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(stem::NounStem, rule::NounRule;           ortho::GreekOrthography = literaryGreek())
    raw = stemstring(stem) * ending(rule)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)

    else
        if stem.accentpersistence == "recessive"
            stripmetachars(accentword(raw, :RECESSIVE, ortho))
           
        elseif stem.accentpersistence == "stemaccented"
            stripmetachars( accentword(raw, :PENULT, ortho))
          
        else 
            # place correct accent on ultima:
            @debug("ACC.ULTIMA:", raw)
            caselabel = label(gmpCase(rule))   
            if caselabel == "genitive" || caselabel == "dative"
                stripmetachars(accentultima(r, :CIRCUMFLEX, ortho))
                
            else
                stripmetachars(accentultima(r, :ACUTE, ortho))
                
            end
        end
    end
end
