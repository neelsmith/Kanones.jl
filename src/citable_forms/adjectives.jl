"""Adjectives have gender, case, number and degree."""
struct AdjectiveForm <: GreekMorphologicalForm
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
end

"""Adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveForm}) = CitableByCite2Urn()

"""Create an `AdjectiveForm` from a string value.

$(SIGNATURES)
"""
function adjectiveform(code::AbstractString)
    morphchars = split(code, "")    
    agender = gmpGender(parse(Int64, morphchars[7]))
    acase = gmpCase(parse(Int64, morphchars[8]))
    anumber = gmpNumber(parse(Int64, morphchars[3]))
    adegree = gmpDegree(parse(Int64, morphchars[9]))
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
    join([label(adj.adjgender), label(adj.adjcase), label(adj.adjnumber), label(adj.adjdegree)], " ")
end


"""Compose a Cite2Urn for an `AdjectiveForm`.

$(SIGNATURES)
"""
function urn(adj::AdjectiveForm)
      # PosPNTMVGCDCat
      Cite2Urn(string(BASE_MORPHOLOGY_URN, ADJECTIVE,"0",code(adj.adjnumber),"000", code(adj.adjgender),code(adj.adjcase),code(adj.adjdegree),"0"))
end



"""Compose a `FormUrn` for an `AdjectiveForm`.

$(SIGNATURES)
"""
function formurn(adj::AdjectiveForm)
    FormUrn(string("morphforms.", ADJECTIVE, "0" , code(adj.adjnumber),"000", code(adj.adjgender), code(adj.adjcase), code(adj.adjdegree), "0"))
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
        AdjectiveForm(
            gmpGender(g),
            gmpCase(c),
            gmpNumber(n),
            gmpDegree(d)
        )
    end
end
