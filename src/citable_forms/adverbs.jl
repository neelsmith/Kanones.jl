"""Adverbs have degree."""
struct GMFAdverb <: GreekMorphologicalForm
    advdegree::GMPDegree
end

function label(adv::GMFAdverb)
    string("adverb: ", label(adv.advdegree), " degree")
end

"""Construct a `GMFAdverb` from a digital code.
$(SIGNATURES)
"""
function gmfAdverb(code::AbstractString)
    morphchars = split(code, "")    
    gmpDegree(parse(Int64, morphchars[9])) |> GMFAdverb
end


"""Construct a `GMFAdverb` from a `FormUrn`.
$(SIGNATURES)
"""
function gmfAdverb(abbrurn::FormUrn)
    gmfAdverb(abbrurn.objectid)
end

"""Construct a `GMFAdverb` from a `Cite2Urn`.
$(SIGNATURES)
"""
function gmfAdverb(urn::Cite2Urn)
    gmfAdverb(objectcomponent(urn))
end

"""Retrieve degree property of `adv`.
$(SIGNATURES)
"""
function gmpDegree(adv::GMFAdverb)
    adv.advdegree
end

"""Compose a digital code for `adv`.
$(SIGNATURES)
"""
function code(adv::GMFAdverb)
    # PosPNTMVGCDCat
    string(ADVERB,"0","000000", code(adv.advdegree),"0")
end

"""Compose a Cite2Urn for an `GMFAdjective`.

$(SIGNATURES)
"""
function urn(adv::GMFAdverb)
      Cite2Urn(BASE_MORPHOLOGY_URN * code(adv))
end

"""Compose a `FormUrn` for an `GMFAdjective`.

$(SIGNATURES)
"""
function formurn(adv::GMFAdverb)
    FormUrn("$(COLLECTION_ID).$(code(adv))")
end
