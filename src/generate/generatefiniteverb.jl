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
    if stem.augmented
        @debug("AUGMENTED! Generating verb ", stem, rule)
    end
    
    # stembase is just the normalized string value for this stem
    stembase = stemstring(stem)  |> knormal
    if regularverbclass(stem)
        # This needs to be changed.
        # principal part is doing augment and redupe,
        # but athat also needs to happen for non-regular?
        stembase = principalpart(stem, rule, ortho = ortho) |> knormal
        @debug("Starting from stembase", stembase)
    else
        if  takesreduplication(greekForm(rule), inflectionclass(rule))
            stembase = reduplicate(stembase, ortho)
        end
        if rule isa FiniteVerbRule && takesaugment(greekForm(rule)) && stem.augmented == false
            stembase = augment(stembase, ortho)
            @debug("Augmented:", stembase)
            stembase
        end
    end


    @debug("prin.part with morphemes:", stembase)
    baseparts = split(stembase, "#")
    basemorpheme = baseparts[end]
    @debug("STEMBASE, morphemes", stembase, basemorpheme)
    
    raw = strcat(basemorpheme, ending(rule), ortho) |> knormal
    @debug("apply rule to get raw", ending(rule), raw)
    if length(baseparts) > 1
        prefix = replace(join(baseparts[1:end-1],""), "#" => "")
        @debug("Prefix is ", prefix)
        raw = strcat(prefix, raw, ortho)

    end


    @debug("Generate finite verb from raw", raw)

    if countaccents(raw, ortho) == 1
        # Already has accent! 
        stripmetachars(raw)

    else
        
        try
           accented = debugaccent(raw, :RECESSIVE, ortho)
            #stripmetachars(accentword(raw, :RECESSIVE, ortho))
            stripmetachars(accented)
        catch e
            @warn("Failed to create accented finite verb form from stem/rule/erro", stem, rule, e)
            @warn("Raw word: $(raw)")
            @warn("Stem/rule:", stem, rule)
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



"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function deponentformcodes()
    personints = keys(personlabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    tenseints = keys(tenselabeldict) |> collect |> sort
    moodints = [1,2,3] # Gather imperative separately!
    keys(moodlabeldict) |> collect |> sort
    voiceints = [2,3] # omit active
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




"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function deponentverbforms()
    deponentformcodes() .|> gmfFiniteVerb
end
