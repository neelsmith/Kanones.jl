
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




"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function verbformcodes()
    personints = keys(personlabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    tenseints = keys(tenselabeldict) |> collect |> sort
    moodints = keys(moodlabeldict) |> collect |> sort
    voiceints = keys(voicelabeldict) |> collect |> sort
    formlist = []
    for v in voiceints
        for t in tenseints
            for m in moodints
                for n in numints
                    for p in personints
                        push!(formlist, "$(FINITEVERB)$(p)$(n)$(t)$(m)$(v)0000")
                    end
                end
            end
        end
    end
    formlist
end

"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function verbforms()
    verbformcodes() .|> gmfFiniteVerb
end

