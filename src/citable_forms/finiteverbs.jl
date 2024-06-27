"""Finite verbs have person, number, tense, mood and voice."""
struct GMFFiniteVerb <: GreekMorphologicalForm
    vperson::GMPPerson
    vnumber::GMPNumber
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
end

function show(io::IO, vb::GMFFiniteVerb)
    print(io, label(vb))
end

function ==(v1::GMFFiniteVerb, v2::GMFFiniteVerb)
    v1.vperson == v2.vperson &&
    v1.vnumber == v2.vnumber &&
    v1.vtense == v2.vtense &&
    v1.vmood == v2.vmood &&
    v1.vvoice == v2.vvoice
end



"""Finite verb  forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFFiniteVerb}) = CitableByCite2Urn()
function citabletrait(::Type{GMFFiniteVerb})
    CitableByCite2Urn()
end

"""Compose a Cite2Urn for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function urn(verb::GMFFiniteVerb)
    # PosPNTMVGCDCat
    Cite2Urn(BASE_MORPHOLOGY_URN * code(verb) )
end

"""Compose a label for a `GMFFiniteVerb`

$(SIGNATURES)
"""
function label(verb::GMFFiniteVerb)
    join(
        [
        "finite verb: ",
        label(verb.vtense), 
        label(verb.vmood), 
        label(verb.vvoice),
        label(verb.vperson),  
        label(verb.vnumber)
        ], " ")
end



"""Extract person property from `v`.
$(SIGNATURES)
"""
function gmpPerson(v::GMFFiniteVerb)
    v.vperson
end

"""Extract number property from `v`.
$(SIGNATURES)
"""
function gmpNumber(v::GMFFiniteVerb)
    v.vnumber
end


"""Extract tense property from `v`.
$(SIGNATURES)
"""
function gmpTense(v::GMFFiniteVerb)
    v.vtense
end

"""Extract mood property from `v`.
$(SIGNATURES)
"""
function gmpMood(v::GMFFiniteVerb)
    v.vmood
end

"""Extract voice property from `v`.
$(SIGNATURES)
"""
function gmpVoice(v::GMFFiniteVerb)
    v.vvoice
end

"""Compose a digital code for `adj`.
$(SIGNATURES)
"""
function code(verb::GMFFiniteVerb)
    string(FINITEVERB, code(verb.vperson),code(verb.vnumber), code(verb.vtense), code(verb.vmood), code(verb.vvoice),"0000")
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



"""Compose a `FormUrn` for a `GMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(verbform::GMFFiniteVerb)
    FormUrn(string("$(COLLECTION_ID).", code(verbform)))
end


"""Compose delimited-text representation of CITE collection for morphological forms of finite verbs.

$(SIGNATURES)
"""
function finiteverbscex()

    #tensekeys = keys(Kanones.tenselabeldict)   |> collect |> sort 
    moodkeys = keys(Kanones.moodlabeldict)   |> collect |> sort 
    voicekeys = keys(Kanones.voicelabeldict)   |> collect |> sort 
    personkeys = keys(Kanones.personlabeldict)  |> collect |> sort 
    numberkeys = keys(Kanones.numberlabeldict)  |> collect |> sort 

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