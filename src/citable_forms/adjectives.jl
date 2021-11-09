"""Adjectives have gender, case, number and degree."""
struct GMFAdjective <: GreekMorphologicalForm
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
end

"""Adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFAdjective}) = CitableByCite2Urn()

"""Create an `GMFAdjective` from a string value.

$(SIGNATURES)
"""
function gmfAdjective(code::AbstractString)
    morphchars = split(code, "")    
    agender = gmpGender(parse(Int64, morphchars[7]))
    acase = gmpCase(parse(Int64, morphchars[8]))
    anumber = gmpNumber(parse(Int64, morphchars[3]))
    adegree = gmpDegree(parse(Int64, morphchars[9]))
    GMFAdjective(agender, acase, anumber, adegree)
end

"""Create an `GMFAdjective` from a CITE2 URN.

$(SIGNATURES)
"""
function gmfAdjective(urn::Cite2Urn)
    gmfAdjective(objectcomponent(urn))
end


"""Create a `GMFAdjective` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfAdjective(f::FormUrn)
     gmfAdjective(f.objectid)
end

"""Create a `GMFAdjective` from an `Analysis`.

$(SIGNATURES)
"""
function gmfAdjective(a::Analysis)
    gmfAdjective(a.form)
end

"""Compose a label for an `GMFAdjective`

$(SIGNATURES)
"""
function label(adj::GMFAdjective)
    join([label(adj.adjgender), label(adj.adjcase), label(adj.adjnumber), label(adj.adjdegree)], " ")
end


"""Compose a Cite2Urn for an `GMFAdjective`.

$(SIGNATURES)
"""
function urn(adj::GMFAdjective)
      # PosPNTMVGCDCat
      Cite2Urn(string(BASE_MORPHOLOGY_URN, ADJECTIVE,"0",code(adj.adjnumber),"000", code(adj.adjgender),code(adj.adjcase),code(adj.adjdegree),"0"))
end



"""Compose a `FormUrn` for an `GMFAdjective`.

$(SIGNATURES)
"""
function formurn(adj::GMFAdjective)
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
        GMFAdjective(
            gmpGender(g),
            gmpCase(c),
            gmpNumber(n),
            gmpDegree(d)
        )
    end
end
