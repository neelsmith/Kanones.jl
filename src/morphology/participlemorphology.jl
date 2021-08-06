
"""Finite verbs have person, number, tense, mood and voice."""
struct ParticipleForm <: MorphologicalForm
    tense::Int64
    tenselabel::AbstractString  
    voice::Int64
    voicelabel::AbstractString 
    pgender::Int64
    genderlabel::AbstractString    
    pcase::Int64
    caselabel::AbstractString    
    pnumber::Int64
    numberlabel::AbstractString  
end


"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function participlefromfst(fstdata)
    # Example rule string:

    # Extract TVGCN from a string like the example:
    infinitiverulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(infinitiverulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v, g, c, n) = matchedup[1].captures
        tensedict = labeldict(tensepairs)
        voicedict = labeldict(voicepairs)
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        verbform = ParticipleForm(
        tensedict[t], t,
        voicedict[v], v,
        genderdict[g], g,
        casedict[c], c,
        numberdict[n], n
        )
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(ptcpl::ParticipleForm)
    #PosPNTMVGCDCat
    FormUrn(string("morphforms.", PARTICIPLE, 
    "0",ptcpl.pnumber, ptcpl.tense, "0", ptcpl.voice, 
    ptcpl.pgender, ptcpl.pcase, "00"))
end