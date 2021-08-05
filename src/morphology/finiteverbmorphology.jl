
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

"""Create a `FiniteVerbForm` from a string value.

$(SIGNATURES)
"""
function finiteverbform(code::AbstractString)
    morphchars = split(code,"")
    @info(morphchars)
    # PosPNTMVGCDCat
    prsn = parse(Int64,morphchars[2])
    nmbr = parse(Int64,morphchars[3])
    tns = parse(Int64,morphchars[4])
    md = parse(Int64,morphchars[5])
    vc = parse(Int64,morphchars[6])

    persondict = valuedict(personpairs)
    numberdict = valuedict(numberpairs)
    tensedict = valuedict(tensepairs)
    mooddict = valuedict(moodpairs)
    voicedict = valuedict(voicepairs)
    FiniteVerbForm(
        prsn, persondict[prsn],
        nmbr, numberdict[nmbr],
        tns, tensedict[tns],
        md, mooddict[md],
        vc, voicedict[vc]
    )
end


"""Create a `FiniteVerbForm` from a `Cite2URN`.

$(SIGNATURES)
"""
function finiteverbform(urn::Cite2Urn)
    finiteverbform(objectcomponent(urn))
end


"""Create a `FiniteVerbForm` from a `FormUrn`.

$(SIGNATURES)
"""
function finiteverbform(f::FormUrn)
    finiteverbform(f.objectid)
end

"""Create a `FiniteVerbForm` from an `Analysis`.

$(SIGNATURES)
"""
function finiteverbform(a::Analysis)
    finiteverbform(a.form)
end


"""Compose URN for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function urn(verb::FiniteVerbForm)
    nothing
end


"""Compose CEX representation for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function cex(verb::FiniteVerbForm)
    nothing
end


"""Compose URN for finite verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function verbfromfst(fstdata)
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

        #FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
        #verbform.vtense, verbform.vmood, verbform.vvoice, "000"))
    end
end


"""Compose a `FormUrn` for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function formurn(verbform::FiniteVerbForm)
    FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
    verbform.vtense, verbform.vmood, verbform.vvoice, "000"))
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
                     pers, num, tense, INDICATIVE, voice,"00000")
                    
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
                    pers, num, FUTURE, mood, voice,"00000")
                    
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
                        pers, num, tense, mood, voice,"00000")
                        
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