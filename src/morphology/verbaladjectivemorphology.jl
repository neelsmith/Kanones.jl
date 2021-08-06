
"""Finite verbs have person, number, tense, mood and voice."""
struct VerbalAdjectiveForm <: MorphologicalForm
    vagender::Int64
    gender::AbstractString  
    vacase::Int64
    caselabel::AbstractString 
    vanumber::Int64
    numberlabel::AbstractString 
end


"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function verbaladjectivefromfst(fstdata)
    vadjrulere = r"<([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(vadjrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (g,c,n) = matchedup[1].captures
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        VerbalAdjectiveForm(
        genderdict[g], g,
        casedict[c], c,
        numberdict[n], n
        )
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(vadj::VerbalAdjectiveForm)
    FormUrn(string("morphforms.", VERBALADJECTIVE, "0" ,vadj.vanumber,"000",vadj.vagender, vadj.vacase,"00"))
end
#PosPNTMVGCDCat