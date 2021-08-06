"""Nouns have gender, case and number."""
struct AdjectiveForm <: MorphologicalForm
    agender::Int64
    genderlabel::AbstractString    
    acase::Int64
    caselabel::AbstractString    
    anumber::Int64
    numberlabel::AbstractString    
    adegree::Int64
    degreelabel::AbstractString    
end



"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function adjectivefromfst(fstdata)
    adjrulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(adjrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as adjective form.")
        nothing
    else
        (g,c,n, d) = matchedup[1].captures
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        degreedict = labeldict(degreepairs)
        
        AdjectiveForm(
        genderdict[g], g,
        casedict[c], c,
        numberdict[n], n,
        degreedict[d], d
        )
    end
end


"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(adj::AdjectiveForm)
    FormUrn(string("morphforms.", ADJECTIVE, "0" ,adj.anumber,"000",adj.agender, adj.acase, adj.adegree, "0"))
end
#PosPNTMVGCDCat