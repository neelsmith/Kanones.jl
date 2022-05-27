"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::VerbStem, 
    rule::FiniteVerbRule;
    ortho::GreekOrthography = literaryGreek())
    @debug("Generating ", stem, rule)

    stembase = stemstring(stem)
    if regularverbclass(stem) 
        stembase = principalpart(stem, rule, ortho = ortho)
    end

    @debug("prin.part with morphemes:", stembase)
    baseparts = split(stembase, "#")
    basemorpheme = baseparts[end]
    @debug("STEMBASE, morphemes", stembase, basemorpheme)
    
    raw = strcat(basemorpheme, ending(rule), ortho)
    @debug("apply rule to get raw", ending(rule), raw)
    if length(baseparts) > 1
        prefix = replace(join(baseparts[1:end-1],""), "#" => "")
        @debug("Prefix is ", prefix)
        raw = strcat(prefix, raw, ortho)

    end


    @debug("Generate inf. from raw", raw)

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

"""True if `verbcode` identifies a finite verb form with
a valid combination of tense and mood.
$(SIGNATURES)
"""
function validverbform(verbcode::AbstractString)
    verb = gmfFiniteVerb(verbcode)
    if gmpTense(verb) == gmpTense("imperfect")
        # Only accept imperfect indicative:
        gmpMood(verb) == gmpMood("indicative")

    elseif gmpTense(verb) == gmpTense("pluperfect")
        # Only accept pluperfect indicative:
        gmpMood(verb) == gmpMood("indicative")

    elseif gmpTense(verb) == gmpTense("future")
        # No future subjunctive:
        gmpMood(verb) != gmpMood("subjunctive")

    else
        true
    end
end

"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function verbformcodes()
    personints = keys(personlabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    tenseints = keys(tenselabeldict) |> collect |> sort
    moodints = [1,2,3] # Gather imperative separately!
    keys(moodlabeldict) |> collect |> sort
    voiceints = keys(voicelabeldict) |> collect |> sort
    formlist = []
    for v in voiceints
        for t in tenseints
            for m in moodints
                for n in numints
                    for p in personints
                        formcode = "$(FINITEVERB)$(p)$(n)$(t)$(m)$(v)0000"
                        if validverbform(formcode)
                            push!(formlist, formcode)
                        end
                    end
                end
            end
        end
    end
    # Cycle through possible imperative forms, and add them here:
    # 
    imperativecode = moodcodedict["imperative"]
    tensecodes = [ 
        tensecodedict["present"], 
        tensecodedict["aorist"], 
        tensecodedict["perfect"] 
    ] 
    personcodes = [2,3]
    for v in voiceints
        for t in tensecodes
            for n in numints
                for p in personcodes
                    formcode = "$(FINITEVERB)$(p)$(n)$(t)$(imperativecode)$(v)0000"
                    push!(formlist, formcode)
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

