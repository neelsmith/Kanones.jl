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
        stripmetachars(raw) |> nfkc

    elseif gmpTense(rule) == gmpTense("perfect") &&
        (gmpVoice(rule) == gmpVoice("middle") || gmpVoice(rule) ==  gmpVoice("passive"))
        @debug("CATCH PERFECT M/P accent")

        sylls = syllabify(raw, literaryGreek())
        pen = PolytonicGreek.penult(raw,ortho)
        penaccented = PolytonicGreek.accentsyllable(pen, :ACUTE, ortho)

        sylls[end - 1]  = penaccented
        join(sylls)
        
    elseif endswith(ending(rule), "αι") && gmpVoice(rule) == gmpVoice("active")
        # Smyth 425a
        
        try
            stripmetachars(accentword(raw, :PENULT, ortho)) |> nfkc
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")
        end
    else
        try
            stripmetachars(accentword(raw, :RECESSIVE, ortho)) |> nfkc
        catch e
            @warn("Failed to create accented form", e)
            @warn("Raw word: $(raw)")
        end
    
    end
end






"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function infinitiveformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    voiceints = keys(voicelabeldict) |> collect |> sort
    tenseints = [tensecodedict["present"], tensecodedict["future"], tensecodedict["aorist"], tensecodedict["perfect"]]


    formlist = []
    for t in tenseints
        for v in voiceints
            push!(formlist, "$(INFINITIVE)00$(t)0$(v)0000")
        end
    end
    formlist
end

"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function infinitiveforms()
    infinitiveformcodes() .|> gmfInfinitive
end
