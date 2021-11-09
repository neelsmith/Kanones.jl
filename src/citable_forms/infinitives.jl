"""Infinitive verbs have tense and voice."""
struct GMFInfinitive <: GreekMorphologicalForm
    tense::GMPTense
    voice::GMPVoice
end

"""Infinitive forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFInfinitive}) = CitableByCite2Urn()


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




"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function infinitivefromfst(fstdata)
    # The fst parameter shoud look like
    # <present><middle>
    # Extract TV from a string like the example:
    infinitiverulere = r"<([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(infinitiverulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v) = matchedup[1].captures
        GMFInfinitive(gmpTense(t),gmpVoice(v))    
    end
end

"""Compose a `FormUrn` for an `GMFInfinitive`.

$(SIGNATURES)
"""
function formurn(infinitive::GMFInfinitive)
    FormUrn(string("morphforms.", INFINITIVE, "00" ,
    code(infinitive.tense), "0", code(infinitive.voice), "0000"))
end

"""Compose a label for an `GMFInfinitive`.

$(SIGNATURES)
"""
function label(inf::GMFInfinitive)
    join([label(inf.tense), label(inf.voice), "infinitive"]," ")
end


"""Compose a Cite2Urn for an `GMFInfinitive`.

$(SIGNATURES)
"""
function urn(inf::GMFInfinitive)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, INFINITIVE,"00",code(inf.tense),"0", code(inf.voice),"0000"))
end

