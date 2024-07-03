"""Adjectives have gender, case, number and degree."""
struct GMFAdjective <: GreekMorphologicalForm
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
end

function show(io::IO, adj::GMFAdjective)
    print(io, label(adj))
end

function ==(adj1::GMFAdjective, adj2::GMFAdjective)
    adj1.adjgender == adj2.adjgender && 
    adj1.adjcase == adj2.adjcase && 
    adj1.adjnumber  == adj2.adjnumber &&
    adj1.adjdegree == adj2.adjdegree
end

"""Adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFAdjective}) = CitableByCite2Urn()
function citabletrait(::Type{GMFAdjective})
    CitableByCite2Urn()
end
"""Compose a Cite2Urn for an `GMFAdjective`.

$(SIGNATURES)
"""
function urn(adj::GMFAdjective)
      Cite2Urn(BASE_MORPHOLOGY_URN * code(adj))
end


"""Compose a label for an `GMFAdjective`

$(SIGNATURES)
"""
function label(adj::GMFAdjective)
    join(["adjective: ", label(adj.adjgender), label(adj.adjcase), label(adj.adjnumber), label(adj.adjdegree)], " ")
end






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

"""Extract gender from `adj`.
$(SIGNATURES)
"""
function gmpGender(adj::GMFAdjective)
    adj.adjgender
end

"""Extract case from `adj`.
$(SIGNATURES)
"""
function gmpCase(adj::GMFAdjective)
    adj.adjcase
end

"""Extract number from `adj`.
$(SIGNATURES)
"""
function gmpNumber(adj::GMFAdjective)
    adj.adjnumber
end

"""Extract degree from `adj`.
$(SIGNATURES)
"""
function gmpDegree(adj::GMFAdjective)
    adj.adjdegree
end

"""Compose a digital code for `adj`.
$(SIGNATURES)
"""
function code(adj::GMFAdjective)
    # PosPNTMVGCDCat
    string(ADJECTIVE,"0",code(adj.adjnumber),"000", code(adj.adjgender),code(adj.adjcase),code(adj.adjdegree),"0")
end

"""Compose a `FormUrn` for an `GMFAdjective`.

$(SIGNATURES)
"""
function formurn(adj::GMFAdjective)
    FormUrn("$(COLLECTION_ID).$(code(adj))")
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