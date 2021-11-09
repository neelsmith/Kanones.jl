"""Finite verbs have person, number, tense, mood and voice."""
struct GMFFiniteVerb <: GreekMorphologicalForm
    vperson::GMPPerson
    vnumber::GMPNumber
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
end

"""Finite verb forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFFiniteVerb}) = CitableByCite2Urn()


"""Compose a label for a `GMFFiniteVerb`

$(SIGNATURES)
"""
function label(verb::GMFFiniteVerb)
    join(
        [
        label(verb.vtense), 
        label(verb.vmood), 
        label(verb.vvoice),
        label(verb.vperson),  
        label(verb.vnumber)
        ], " ")
end

"""Compose a Cite2Urn for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function urn(verb::GMFFiniteVerb)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, FINITEVERB, code(verb.vperson),code(verb.vnumber), code(verb.vtense), code(verb.vmood), code(verb.vvoice),"0000"))
end

"""Create a `GMFFiniteVerb` from a string value.

$(SIGNATURES)
"""
function gmfFiniteVerb(code::AbstractString)
    morphchars = split(code,"")
    # PosPNTMVGCDCat
    
    tns = gmpTense(parse(Int64, morphchars[4]))
    md = gmpMood(parse(Int64, morphchars[5]))
    vc = gmpVoice(parse(Int64,morphchars[6]))
    prsn = gmpPerson(parse(Int64, morphchars[2]))
    nmbr = gmpNumber(parse(Int64, morphchars[3]))
    
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
function gmfFiniteVerb(urn::Cite2Urn)
    gmfFiniteVerb(objectcomponent(urn))
end


"""Create a `GMFFiniteVerb` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfFiniteVerb(f::FormUrn)
    gmfFiniteVerb(f.objectid)
end

"""Create a `GMFFiniteVerb` from an `Analysis`.

$(SIGNATURES)
"""
function gmfFiniteVerb(a::Analysis)
    gmfFiniteVerb(a.form)
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
        GMFFiniteVerb(
            gmpPerson(p),
            gmpNumber(n), 
            gmpTense(t),
            gmpMood(m),
            gmpVoice(v)
        )
    end
end

"""Compose URN for finite verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularverbfromfst(fstdata)
     # Looks like
    # <u>irregverb.irregverbnn26447af</u><u>lsj.n26447</u>δοιντο<irregular><irregularfiniteverb><third><plural><aorist><subjunctive><middle>
    # 2-6 are pntmv
    prsn =  matchedup[2].captures[1]
    nmbr = matchedup[3].captures[1]
    tns = matchedup[4].captures[1]
    md = matchedup[5].captures[1]
    vc = matchedup[6].captures[1]
    
    GMFFiniteVerb(
        gmpTense(prsn),
        gmpNumber(nmbr),
    
        gmpMood(tns), 
        gmpMood(md), 
        gmpVoice(vc) 
    )
end

"""Compose a `FormUrn` for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(verbform::GMFFiniteVerb)
    FormUrn(string("morphforms.", FINITEVERB, code(verbform.vperson), code(verbform.vnumber), code(verbform.vtense), code(verbform.vmood), code(verbform.vvoice), "0000"))
end




"""Compose delimited-text representation of CITE collection for morphological forms of finite verbs.

$(SIGNATURES)
"""
function finiteverbscex()

    tensekeys = keys(Kanones.tenselabels)   |> collect |> sort 
    moodkeys = keys(Kanones.moodlabels)   |> collect |> sort 
    voicekeys = keys(Kanones.voicelabels)   |> collect |> sort 
    personkeys = keys(Kanones.personlabels)  |> collect |> sort 
    numberkeys = keys(Kanones.numberlabels)  |> collect |> sort 

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
                    label(gmpPerson(pers)), 
                    label(gmpNumber(num)), 
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
                    code(gmpPerson(pers)), 
                    code(gmpNumber(num))s, 
                    "future", 
                    code(gmpMood(mood)), 
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
                        code(gmpPerson(pers)), 
                        code(gmpNumber(num)), 
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