"""Infinitive verbs have tense and voice."""
struct InfinitiveForm <: GreekMorphologicalForm
    tense::GMPTense
    voice::GMPVoice
end

"""Infinitive forms are citable by Cite2Urn"""
CitableTrait(::Type{InfinitiveForm}) = CitableByCite2Urn()


"""Create an `InfinitiveForm` from a string value.

$(SIGNATURES)
"""
function infinitiveform(code::AbstractString)
    morphchars = split(code, "")
    tense = gmpTense(parse(Int64, morphchars[4]))
    voice = gmpVoice(parse(Int64, morphchars[6]) )
    InfinitiveForm(tense, voice)
end


"""Create an `InfinitiveForm` from a `Cite2Urn`.

$(SIGNATURES)
"""
function infinitiveform(urn::Cite2Urn)
    infinitiveform(objectcomponent(urn))
end


"""Create an `InfinitiveForm` from a `FormUrn`.

$(SIGNATURES)
"""
function infinitiveform(f::FormUrn)
    infinitiveform(f.objectid)
end


"""Create an `InfinitiveForm` from an `Analysis`.

$(SIGNATURES)
"""
function infinitiveform(a::Analysis)
    infinitiveform(a.form)
end




"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function infinitivefromfst(fstdata)
    # The fst parameter shoud look like
    # <present><middle>
    # Extract TV from a string like the example:
    infinitiverulere = r"<([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(infinitiverulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v) = matchedup[1].captures
        InfinitiveForm(gmpTense(t),gmpVoice(v))    
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(infinitive::InfinitiveForm)
    FormUrn(string("morphforms.", INFINITIVE, "00" ,
    code(infinitive.tense), "0", code(infinitive.voice), "0000"))
end

"""Compose a label for an `InfinitiveForm`.

$(SIGNATURES)
"""
function label(inf::InfinitiveForm)
    join([label(inf.tense), label(inf.voice), "infinitive"]," ")
end


"""Compose a Cite2Urn for an `InfinitiveForm`.

$(SIGNATURES)
"""
function urn(inf::InfinitiveForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, INFINITIVE,"00",code(inf.tense),"0", code(inf.voice),"0000"))
end

