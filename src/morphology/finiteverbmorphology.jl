
"""Finite verbs have person, number, tense, mood and voice."""
struct FiniteVerbForm <: MorphologicalForm
    vperson::Int64
    personlabel::AbstractString    
    vnumber::Int64
    numberlabel::AbstractString    
    vtense::Int64
    tenselabel::AbstractString   
    vmood::Int64
    moodlabel::AbstractString    
    vvoice::Int64
    voicelabel::AbstractString 
end

"""Create a `NounForm` from a URN.

$(SIGNATURES)
"""
function FiniteVerbForm(urn::Cite2Urn)
    nothing
end

"""Compose URN for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function urn(noun::FiniteVerbForm)
    nothing
end


"""Compose CEX representation for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function cex(noun::FiniteVerbForm)
    nothing
end


"""Compose URN for finite verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function finiteverbabbrurn(fstdata)
    # Example rule string:
    #  "<w_regular><finiteverb>ει<third><singular><present><indicative><active>"
    # Extract PNTMV from a string like the example:
    verbrulere = r"<[^<]+><finiteverb>[^<]*<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(verbrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (p,n, t, m, v) = matchedup[1].captures

        persondict = labeldict(personpairs)
        numberdict = labeldict(numberpairs)
        tensedict = labeldict(tensepairs)
        mooddict = labeldict(moodpairs)
        voicedict = labeldict(voicepairs)
        verbform = FiniteVerbForm(persondict[p], p,
        numberdict[n], n,
        tensedict[t], t,
        mooddict[m], m,
        voicedict[v], v
        )

        FormUrn(string("morphforms.", FINITEVERB,"0",verbform.vperson, verbform.vnumber, 
        verbform.vtense, verbform.vmood, verbform.vvoice, "000"))
    end
end



"""Compose delimited-text representation of CITE collection for morphological forms of finite verbs.

$(SIGNATURES)
"""
function finiteverbscex()

    persondict = valuedict(personpairs)
    personkeys = keys(persondict)  |> collect |> sort 

    
    numberdict = valuedict(numberpairs)
    numberkeys = keys(numberdict)  |> collect |> sort 

    tensedict = valuedict(tensepairs)
    tensekeys = keys(tensedict)  |> collect |> sort 

    mooddict = valuedict(moodpairs)
    moodkeys = keys(mooddict)  |> collect |> sort 

    voicedict = valuedict(voicepairs)
    voicekeys = keys(voicedict)  |> collect |> sort 

    lines = []
    PRESENT = 1
    IMPERFECT = 2
    FUTURE = 3
    AORIST = 4
    PERFECT = 5
    PLUPERFECT = 6
    
    
    # indic mood only: imperfect, pluperfect
    INDICATIVE = 1
    # PosPNTMVGCDCat
    for tense in [IMPERFECT, PLUPERFECT]
        for pers in personkeys
            for num in numberkeys
                for voice in voicekeys
                    u = string(BASE_MORPHOLOGY_URN, FINITEVERB, 
                    "0", pers, num, tense, INDICATIVE, voice,"0000")
                    
                    label = string("verb: ", 
                    persondict[pers], numberdict[num], tensedict[tense], "indicative", voicedict[voice])
                    
                    cex = string(u, "|", label)
                    push!(lines, cex)
                end
            end
        end 
    end

    # indicative and optative moods only: future
    OPTATIVE = 3
    for mood in [INDICATIVE, OPTATIVE]
        for pers in personkeys
            for num in numberkeys
                for voice in voicekeys
                    u = string(BASE_MORPHOLOGY_URN, FINITEVERB, 
                    "0", pers, num, FUTURE, mood, voice,"0000")
                    
                    label = string("verb: ", 
                    persondict[pers], numberdict[num], "future", mooddict[mood], voicedict[voice])
                    
                    cex = string(u, "|", label)
                    push!(lines, cex)
                end
            end
        end 
    end
  
    # all tense/mood combinations
    # present, aorist, perfect
    for tense in [PRESENT, AORIST, PERFECT]
        for pers in personkeys
            for num in numberkeys
                for mood in moodkeys
                    for voice in voicekeys
                        u = string(BASE_MORPHOLOGY_URN, FINITEVERB, 
                        "0", pers, num, tense, mood, voice,"0000")
                        
                        label = string("verb: ", 
                        persondict[pers], numberdict[num], tensedict[tense], mooddict[mood], voicedict[voice])
                        
                        cex = string(u, "|", label)
                        push!(lines, cex)
                    end
                end
            end
        end 
    end
    
    join(lines, "\n")  
end