"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::VerbStem, 
    rule::InfinitiveRule;
    ortho::GreekOrthography = literaryGreek())

    stembase = stemstring(stem)
    if regularverbclass(stem) 
        stembase = principalpart(stem, rule, ortho = ortho)
    end

    raw = stembase * ending(rule)
    @debug("Generate from raw", raw)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)

        
    elseif endswith(ending(rule), "αι")
        # Smyth 425a
        
        try
            stripmetachars(accentword(raw, :PENULT, ortho))
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")
        end
    else
        try
            stripmetachars(accentword(raw, :RECESSIVE, ortho))
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")
        end
    
    end
end