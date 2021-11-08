
"""Finite verbs have person, number, tense, mood and voice."""
struct FiniteVerbForm <: MorphologicalForm
    vperson::Int64
    vnumber::Int64
    vtense::Int64
    vmood::Int64
    vvoice::Int64
end

"""Finite verb forms are citable by Cite2Urn"""
CitableTrait(::Type{FiniteVerbForm}) = CitableByCite2Urn()


"""Compose a label for a `NounForm`

$(SIGNATURES)
"""
function label(verb::FiniteVerbForm)
    pdict = Kanones.personpairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    tdict = Kanones.tensepairs |> Kanones.valuedict
    mdict = Kanones.moodpairs |> Kanones.valuedict
    vdict = Kanones.voicepairs |> Kanones.valuedict
    join(
        [
            pdict[verb.vperson],  
            ndict[verb.vnumber], 
            tdict[verb.vtense], 
            mdict[verb.vmood], 
            vdict[verb.vvoice]
            ], " ")
end

"""Compose a Cite2Urn for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function urn(verb::FiniteVerbForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, FINITEVERB,verb.vperson,verb.vnumber, verb.vtense, verb.vmood, verb.vvoice,"0000"))
end

"""Create a `FiniteVerbForm` from a string value.

$(SIGNATURES)
"""
function finiteverbform(code::AbstractString)
    morphchars = split(code,"")
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
        prsn,
        nmbr,
        tns,
        md, 
        vc
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


"""Compose URN for finite verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function verbfromfst(fstdata)
    # Example rule string:
    #  "<third><singular><present><indicative><active>"
    # Extract PNTMV from a string like the example:
    verbrulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
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
        verbform = FiniteVerbForm(persondict[p], #p,
        numberdict[n], #n,
        tensedict[t],# t,
        mooddict[m], #m,
        voicedict[v]#, v
        )
    end
end


"""Compose a `FormUrn` for a `FiniteVerbForm`.

$(SIGNATURES)
"""
function formurn(verbform::FiniteVerbForm)
    FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
    verbform.vtense, verbform.vmood, verbform.vvoice, "0000"))
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