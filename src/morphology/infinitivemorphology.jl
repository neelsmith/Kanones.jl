
"""Finite verbs have person, number, tense, mood and voice."""
struct InfinitiveForm <: MorphologicalForm
    tense::Int64
    tenselabel::AbstractString  
    voice::Int64
    voicelabel::AbstractString 
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
        (t, v) = matchedup[1].captures
        tensedict = labeldict(tensepairs)
        voicedict = labeldict(voicepairs)
        verbform = InfinitiveForm(
        tensedict[t], t,
        voicedict[v], v
        )
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(infinitive::InfinitiveForm)
    FormUrn(string("morphforms.", INFINITIVE, "00" ,
    infinitive.tense, "0", infinitive.voice, "000"))
end