"""Nouns have gender, case and number."""
struct GMFNoun <: GreekMorphologicalForm
    ngender::GMPGender
    ncase::GMPCase
    nnumber::GMPNumber
end

"""Noun forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFNoun}) = CitableByCite2Urn()


"""Extract gender from `n`.
$(SIGNATURES)
"""
function gmpGender(n::GMFNoun)
    n.ngender
end


"""Extract case from `n`.
$(SIGNATURES)
"""
function gmpCase(n::GMFNoun)
    n.ncase
end


"""Extract number from `n`.
$(SIGNATURES)
"""
function gmpNumber(n::GMFNoun)
    n.nnumber
end


"""Compose a label for a `GMFNoun`

$(SIGNATURES)
"""
function label(noun::GMFNoun)    
    join([ "noun:", label(noun.ngender), label(noun.ncase), label(noun.nnumber)], " ")
end

"""Compose a Cite2Urn for a `GMFNoun`.

$(SIGNATURES)
"""
function urn(noun::GMFNoun)
    Cite2Urn(string(BASE_MORPHOLOGY_URN, code(noun)))
end

"""Create a `GMFNoun` from a string value.

$(SIGNATURES)
"""
function gmfNoun(code::AbstractString)
    morphchars = split(code, "")
    ngender = gmpGender(parse(Int64, morphchars[7]))
    ncase = gmpCase(parse(Int64, morphchars[8]))
    nnumber = gmpNumber(parse(Int64,morphchars[3]))
    
    GMFNoun(ngender, ncase, nnumber)
end

"""Create a `GMFNoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function gmfNoun(urn::Cite2Urn)
    gmfNoun(objectcomponent(urn))
end

"""Create a `GMFNoun` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfNoun(f::FormUrn)
    gmfNoun(f.objectid)
end

"""Create a `GMFNoun` from an `Analysis`.

$(SIGNATURES)
"""
function gmfNoun(a::Analysis)
    gmfNoun(a.form)
end

"""Compose a digital code for `noun`.
$(SIGNATURES)
"""
function code(noun::GMFNoun)
    # PosPNTMVGCDCat
    string(NOUN,"0",code(noun.nnumber),"000", code(noun.ngender), code(noun.ncase), "00")
end

"""Compose a `FormUrn` for a `GMFNoun`.

$(SIGNATURES)
"""
function formurn(noun::GMFNoun)
    FormUrn(string("$(COLLECTION_ID).", code(noun)))
end


"""Compose CEX representation of URNs and labels for noun forms.

$(SIGNATURES)
"""
function nounscex()
    genderkeys = keys(Kanones.genderlabels)  |> collect |> sort 
    casekeys = keys(Kanones.caselabels)  |> collect |> sort 
    numberkeys = keys(Kanones.numberlabels)  |> collect |> sort 
    lines = []
    # PosPNTMVGCDCat
    for num in numberkeys
        for gen in genderkeys
            for cs in casekeys
                u = string(BASE_MORPHOLOGY_URN, NOUN, "0", num, "000", gen, cs, "00")
                label = string("noun: ", label(gmpGender(gen)), " ", label(gmpCase(cs)), " ", label(gmpNumber(num)))
                cex = string(u, "|", label)
                push!(lines, cex)
            end
        end
    end
    join(lines, "\n")    
end
