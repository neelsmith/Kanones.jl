
"""Finite verbs have person, number, tense, mood and voice."""
struct GMFFiniteVerb <: GreekMorphologicalForm
    vperson::Int64
    vnumber::Int64
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
end

function gmpTense(verb::GMFFiniteVerb)
    verb.vmood
end

function gmpTense(verb::GMFFiniteVerb)
    verb.vtense
end

function gmpVoice(verb::GMFFiniteVerb)
    verb.vvoice
end


"""Finite verb forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFFiniteVerb}) = CitableByCite2Urn()


"""Compose a label for a `GMFFiniteVerb`

$(SIGNATURES)
"""
function label(verb::GMFFiniteVerb)
    pdict = Kanones.personpairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
 
    join(
        [
             
            label(verb.vtense), 
            label(verb.vmood), 
            label(verb.vvoice),
            pdict[verb.vperson],  
            ndict[verb.vnumber]
            
            ], " ")
end

"""Compose a Cite2Urn for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function urn(verb::GMFFiniteVerb)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, FINITEVERB,verb.vperson,verb.vnumber, code(verb.vtense), code(verb.vmood), code(verb.vvoice),"0000"))
end

"""Create a `GMFFiniteVerb` from a string value.

$(SIGNATURES)
"""
function finiteverbform(code::AbstractString)
    morphchars = split(code,"")
    # PosPNTMVGCDCat
    prsn = parse(Int64,morphchars[2])
    nmbr = parse(Int64,morphchars[3])
    tns = GMPTense(morphchars[4])
    md = GMPMood(morphchars[5])
    vc = GMPVoice(morphchars[6])

    persondict = valuedict(personpairs)
    numberdict = valuedict(numberpairs)


    
    GMFFiniteVerb(
        prsn,
        nmbr,
        tns,
        md, 
        vc
    )
end


"""Create a `GMFFiniteVerb` from a `Cite2URN`.

$(SIGNATURES)
"""
function finiteverbform(urn::Cite2Urn)
    finiteverbform(objectcomponent(urn))
end


"""Create a `GMFFiniteVerb` from a `FormUrn`.

$(SIGNATURES)
"""
function finiteverbform(f::FormUrn)
    finiteverbform(f.objectid)
end

"""Create a `GMFFiniteVerb` from an `Analysis`.

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

        
        GMFFiniteVerb(persondict[p],
        numberdict[n], 
        gmpTense(t),
        gmpMood(m),
        gmpVoice(v)
        )
    end
end


"""Compose a `FormUrn` for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(verbform::GMFFiniteVerb)
    FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
    code(verbform.vtense), code(verbform.vmood), code(verbform.vvoice), "0000"))
end




"""Compose delimited-text representation of CITE collection for morphological forms of finite verbs.

$(SIGNATURES)
"""
function finiteverbscex()

    persondict = valuedict(personpairs)
    personkeys = keys(persondict)  |> collect |> sort 

    
    numberdict = valuedict(numberpairs)
    numberkeys = keys(numberdict)  |> collect |> sort 

    tensekeys = keys(Kanones.tenselabels)   |> collect |> sort 
    moodkeys = keys(Kanones.moodlabels)   |> collect |> sort 
    voicekeys = keys(Kanones.voicelabels)   |> collect |> sort 


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
                    persondict[pers], 
                    numberdict[num], 
                    label(gmpTense(tense)), 
                    "indicative", 
                    label(gmpVoice(voice)))
                    
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
                    persondict[pers], 
                    numberdict[num], 
                    "future", 
                    code(gmpVoice(mood)), 
                    code(gmpVoice(voice)))
                    
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
                        persondict[pers], 
                        numberdict[num], 
                        code(gmpTense(tense)), 
                        code(gmpMood(mood)), 
                        code(gmpVoice(voice)))
                        
                        cex = string(u, "|", label)
                        push!(lines, cex)
                    end
                end
            end
        end 
    end
    join(lines, "\n")  
end