"""Infinitive verbs have tense and voice."""
struct InfinitiveForm <: MorphologicalForm
    tense::Int64
    voice::Int64
end

"""Infinitive forms are citable by Cite2Urn"""
CitableTrait(::Type{InfinitiveForm}) = CitableByCite2Urn()


"""Create an `InfinitiveForm` from a string value.

$(SIGNATURES)
"""
function infinitiveform(code::AbstractString)
    morphchars = split(code, "")
    tense = parse(Int64, morphchars[4])
    voice = parse(Int64, morphchars[6]) 
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
    # Example rule string:
    #  "<w_regular><infinitive>εσθαι
    # <present><middle><u>infinfl.wreg2</u>"
    # Extract TV from a string like the example:
    infinitiverulere = r"<([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(infinitiverulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v) = matchedup[2].captures
        tensedict = labeldict(tensepairs)
        voicedict = labeldict(voicepairs)
        InfinitiveForm(tensedict[t],voicedict[v])    
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(infinitive::InfinitiveForm)
    FormUrn(string("morphforms.", INFINITIVE, "00" ,
    infinitive.tense, "0", infinitive.voice, "000"))
end

