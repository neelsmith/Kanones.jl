"""Nouns have gender, case and number."""
struct GMFPronoun <: GreekMorphologicalForm
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

function show(io::IO, pn::GMFPronoun)
    print(io, label(pn))
end

function ==(pn1::GMFPronoun, pn2::GMFPronoun)

    pn1.pgender == pn2.pgender &&
    pn1.pcase == pn2.pcase &&
    pn1.pnumber == pn2.pnumber
end



"""Pronoun forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFPronoun}) = CitableByCite2Urn()
function citabletrait(::Type{GMFPronoun})
    CitableByCite2Urn()
end


"""Compose a Cite2Urn for a `GMFPronoun`.
$(SIGNATURES)
"""
function urn(pronoun::GMFPronoun)
    Cite2Urn(BASE_MORPHOLOGY_URN * code(pronoun))
end

"""Compose a label for a `GMFPronoun`
$(SIGNATURES)
"""
function label(pronoun::GMFPronoun)
    join([ "pronoun:", label(pronoun.pgender), label(pronoun.pcase), label(pronoun.pnumber)], " ")
end


"""Extract gender property from `p`.
$(SIGNATURES)
"""
function gmpGender(p::GMFPronoun)
    p.pgender
end


"""Extract case property from `p`.
$(SIGNATURES)
"""
function gmpCase(p::GMFPronoun)
    p.pcase
end


"""Extract number property from `p`.
$(SIGNATURES)
"""
function gmpNumber(p::GMFPronoun)
    p.pnumber
end




"""Compose a digital code for `pronoun`.
$(SIGNATURES)
"""
function code(pronoun::GMFPronoun)
     # PosPNTMVGCDCat
     string(PRONOUN,"0",code(pronoun.pnumber),"000",code(pronoun.pgender),code(pronoun.pcase),"00")
end



"""Create a `GMFPronoun` from a string value.

$(SIGNATURES)
"""
function gmfPronoun(code::AbstractString)
    morphchars = split(code, "")
    ngender = gmpGender(parse(Int64, morphchars[7]))
    ncase = gmpCase(parse(Int64, morphchars[8]))
    nnumber = gmpNumber(parse(Int64, morphchars[3]))
    GMFPronoun(ngender, ncase,nnumber)
end
 # PosPNTMVGCDCat


 """Create a `GMFPronoun` from a `Cite2Urn`.

 $(SIGNATURES)
 """
 function gmfPronoun(urn::Cite2Urn)
     gmfPronoun(objectcomponent(urn))
 end


 """Create a `GMFPronoun` from a `FormUrn`.

 $(SIGNATURES)
 """
 function gmfPronoun(f::FormUrn)
    gmfPronoun(f.objectid)
 end

 """Create a `GMFPronoun` from an `Analysis`.

 $(SIGNATURES)
 """
 function gmfPronoun(a::Analysis)
    gmfPronoun(a.form)
 end


"""Compose a `FormUrn` for a `GMFPronoun`.
$(SIGNATURES)
"""
function formurn(pronoun ::GMFPronoun)
    FormUrn("$(COLLECTION_ID)." * code(pronoun))
end

