"""Nouns have gender, case and number."""
struct GMFPronoun <: GreekMorphologicalForm
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

"""Pronoun forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFPronoun}) = CitableByCite2Urn()


"""Compose a label for a `GMFPronoun`

$(SIGNATURES)
"""
function label(pronoun::GMFPronoun)
    join([ label(pronoun.pgender), label(pronoun.pcase), label(pronoun.pnumber)], " ")
end

"""Compose a Cite2Urn for a `GMFPronoun`.

$(SIGNATURES)
"""
function urn(pronoun::GMFPronoun)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PRONOUN,"0",code(pronoun.pnumber),"000",code(pronoun.pgender),code(pronoun.pcase),"00"))
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
function formurn(gmfPronoun::GMFPronoun)
    FormUrn(string("$(COLLECTION_ID).", PRONOUN,"0", code(gmfPronoun.pnumber),"000",code(gmfPronoun.pgender),code(gmfPronoun.pcase),"00"))
end



"""Compose a GMFPronoun for a noun form from FST representation of analytical data.

$(SIGNATURES)
"""
function pronounfromfst(fstdata)
    # Example:
    # <feminine><accusative><singular>
    #@warn("Parse FST noun " * fstdata)
    nounrulere = r"<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("pronounfromfst: unable to parse FST analysis \"" * fstdata * "\"")
        nothing
    else
        (g,c,n) = matchedup[1].captures
        GMFPronoun(gmpGender(g), gmpCase(c), gmpNumber(n))
    end
end
 # PosPNTMVGCDCat