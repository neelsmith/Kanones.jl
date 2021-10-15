"""Nouns have gender, case and number."""
struct AdjectiveForm <: MorphologicalForm
    agender::Int64
    #genderlabel::AbstractString    
    acase::Int64
    #caselabel::AbstractString    
    anumber::Int64
    #numberlabel::AbstractString    
    adegree::Int64
    #degreelabel::AbstractString    
end


"""Create an `AdjectiveForm` from a string value.

$(SIGNATURES)
"""
function adjectiveform(code::AbstractString)
    missing
end

"""Create an `AdjectiveForm` from a CITE2 URN.

$(SIGNATURES)
"""
function adjectiveform(urn::Cite2Urn)
    missing
end

"""Create a `AdjectiveForm` from a `FormUrn`.

$(SIGNATURES)
"""
function adjectiveform(f::FormUrn)
    missing
end


"""Create a `AdjectiveForm` from an `Analysis`.

$(SIGNATURES)
"""
function adjectiveform(a::Analysis)
    #nounform(a.form)
    missing
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
        genderdict[g],# g,
        casedict[c], #c,
        numberdict[n], #n,
        degreedict[d], #d
        )
    end
end

"""Compose a label for a `NounForm`

$(SIGNATURES)
"""
function label(adj::AdjectiveForm)
    missing
end


"""Compose a `FormUrn` for an `AdjectiveForm`.

$(SIGNATURES)
"""
function formurn(adj::AdjectiveForm)
    FormUrn(string("morphforms.", ADJECTIVE, "0" ,adj.anumber,"000",adj.agender, adj.acase, adj.adegree, "0"))
end

"""Compose a Cite2Urn for an `AdjectiveForm`.

$(SIGNATURES)
"""
function urn(adj::AdjectiveForm)
    missing
end


"""Compose an abbreviated URN for a form from a `AdjectiveRule`.

$(SIGNATURES)
"""
function abbrurn(rule::AdjectiveRule)
    missing
end



"""Compose CEX representation for a `AdjectiveForm`.

$(SIGNATURES)
"""
function cex(adj::AdjectiveForm, delim="|")
    join([urn(adj), label(adj)], delim)
end

#PosPNTMVGCDCat