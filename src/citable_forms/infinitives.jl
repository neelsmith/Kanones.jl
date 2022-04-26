"""Infinitive verbs have tense and voice."""
struct GMFInfinitive <: GreekMorphologicalForm
    tense::GMPTense
    voice::GMPVoice
end

"""Infinitive forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFInfinitive}) = CitableByCite2Urn()


"""Extract tense value from `inf`.
$(SIGNATURES)
"""
function gmpTense(inf::GMFInfinitive)
    inf.tense
end

"""Extract voice value from `inf`.
$(SIGNATURES)
"""
function gmpVoice(inf::GMFInfinitive)
    inf.voice
end


"""Create an `GMFInfinitive` from a string value.

$(SIGNATURES)
"""
function gmfInfinitive(code::AbstractString)
    morphchars = split(code, "")
    tense = gmpTense(parse(Int64, morphchars[4]))
    voice = gmpVoice(parse(Int64, morphchars[6]) )
    GMFInfinitive(tense, voice)
end


"""Create an `GMFInfinitive` from a `Cite2Urn`.

$(SIGNATURES)
"""
function gmfInfinitive(urn::Cite2Urn)
    gmfInfinitive(objectcomponent(urn))
end


"""Create an `GMFInfinitive` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfInfinitive(f::FormUrn)
    gmfInfinitive(f.objectid)
end


"""Create an `GMFInfinitive` from an `Analysis`.

$(SIGNATURES)
"""
function gmfInfinitive(a::Analysis)
    gmfInfinitive(a.form)
end



"""Compose a digital code for `inf`.
$(SIGNATURES)
"""
function code(inf::GMFInfinitive)
    # PosPNTMVGCDCat
    string(INFINITIVE, "00" , code(inf.tense), "0", code(inf.voice), "0000")
end

"""Compose a `FormUrn` for an `GMFInfinitive`.

$(SIGNATURES)
"""
function formurn(infinitive::GMFInfinitive)
    FormUrn("$(COLLECTION_ID)." * code(infinitive))
end

"""Compose a label for an `GMFInfinitive`.

$(SIGNATURES)
"""
function label(inf::GMFInfinitive)
    join(["infinitive:", label(inf.tense), label(inf.voice)]," ")
end


"""Compose a Cite2Urn for an `GMFInfinitive`.

$(SIGNATURES)
"""
function urn(inf::GMFInfinitive)
    Cite2Urn(string(BASE_MORPHOLOGY_URN, code(inf)))
end

