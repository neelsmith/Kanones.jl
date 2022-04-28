
"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(stem::VerbStem, rule::FiniteVerbRule;           ortho::GreekOrthography = literaryGreek())
    raw = stemstring(stem) * ending(rule)
    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)

    else
        try
            stripmetachars(accentword(raw, :RECESSIVE, ortho))
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")
        end
    end
end