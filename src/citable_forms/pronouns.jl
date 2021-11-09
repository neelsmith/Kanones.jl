"""Nouns have gender, case and number."""
struct PronounForm <: GreekMorphologicalForm
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

"""Pronoun forms are citable by Cite2Urn"""
CitableTrait(::Type{PronounForm}) = CitableByCite2Urn()


"""Compose a label for a `PronounForm`

$(SIGNATURES)
"""
function label(pronoun::PronounForm)
    join([ label(pronoun.pgender), label(pronoun.pcase), label(pronoun.pnumber)], " ")
end

"""Compose a Cite2Urn for a `PronounForm`.

$(SIGNATURES)
"""
function urn(pronoun::PronounForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PRONOUN,"0",code(pronoun.pnumber),"000",code(pronoun.pgender),code(pronoun.pcase),"00"))
end

"""Create a `PronounForm` from a string value.

$(SIGNATURES)
"""
function progmfNoun(code::AbstractString)
    morphchars = split(code, "")
    ngender = gmpGender(parse(Int64, morphchars[7]))
    ncase = gmpCase(parse(Int64, morphchars[8]))
    nnumber = gmpNumber(parse(Int64, morphchars[3]))
    PronounForm(ngender, ncase,nnumber)
end
 # PosPNTMVGCDCat


 """Create a `PronounForm` from a `Cite2Urn`.

 $(SIGNATURES)
 """
 function progmfNoun(urn::Cite2Urn)
     progmfNoun(objectcomponent(urn))
 end


 """Create a `PronounForm` from a `FormUrn`.

 $(SIGNATURES)
 """
 function progmfNoun(f::FormUrn)
    progmfNoun(f.objectid)
 end

 """Create a `PronounForm` from an `Analysis`.

 $(SIGNATURES)
 """
 function progmfNoun(a::Analysis)
    progmfNoun(a.form)
 end


"""Compose a `FormUrn` for a `PronounForm`.
$(SIGNATURES)
"""
function formurn(progmfNoun::PronounForm)
    FormUrn(string("morphforms.", PRONOUN,"0", code(progmfNoun.pnumber),"000",code(progmfNoun.pgender),code(progmfNoun.pcase),"00"))
end



"""Compose a PronounForm for a noun form from FST representation of analytical data.

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
        PronounForm(gmpGender(g), gmpCase(c), gmpNumber(n))
    end
end
 # PosPNTMVGCDCat