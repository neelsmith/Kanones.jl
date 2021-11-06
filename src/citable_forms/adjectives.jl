"""Adjectives have gender, case, number and degree."""
struct AdjectiveForm <: MorphologicalForm
    adjgender::Int64
    adjcase::Int64
    adjnumber::Int64
    adjdegree::Int64
end

"""Adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveForm}) = CitableByCite2Urn()

"""Create an `AdjectiveForm` from a string value.

$(SIGNATURES)
"""
function adjectiveform(code::AbstractString)
    morphchars = split(code, "")    
    agender = parse(Int64, morphchars[7])
    acase = parse(Int64, morphchars[8])
    anumber = parse(Int64, morphchars[3])
    adegree = parse(Int64, morphchars[9])    
    AdjectiveForm(agender, acase, anumber, adegree)
end

"""Create an `AdjectiveForm` from a CITE2 URN.

$(SIGNATURES)
"""
function adjectiveform(urn::Cite2Urn)
    adjectiveform(objectcomponent(urn))
end


"""Create a `AdjectiveForm` from a `FormUrn`.

$(SIGNATURES)
"""
function adjectiveform(f::FormUrn)
     adjectiveform(f.objectid)
end

"""Create a `AdjectiveForm` from an `Analysis`.

$(SIGNATURES)
"""
function adjectiveform(a::Analysis)
    adjectiveform(a.form)
end

"""Compose a label for an `AdjectiveForm`

$(SIGNATURES)
"""
function label(adj::AdjectiveForm)
    gdict = Kanones.genderpairs |> Kanones.valuedict
    cdict = Kanones.casepairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    ddict = Kanones.degreepairs |> Kanones.valuedict
    join([gdict[adj.adjgender], cdict[adj.adjcase], ndict[adj.adjnumber], ddict[adj.adjdegree]], " ")
end


"""Compose a Cite2Urn for an `AdjectiveForm`.

$(SIGNATURES)
"""
function urn(adj::AdjectiveForm)
      # PosPNTMVGCDCat
      Cite2Urn(string(BASE_MORPHOLOGY_URN, ADJECTIVE,"0",adj.adjnumber,"000",adj.adjgender,adj.adjcase,adj.adjdegree,"0"))
end



"""Compose a `FormUrn` for an `AdjectiveForm`.

$(SIGNATURES)
"""
function formurn(adj::AdjectiveForm)
    FormUrn(string("morphforms.", ADJECTIVE, "0" ,adj.adjnumber,"000",adj.adjgender, adj.adjcase, adj.adjdegree, "0"))
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
