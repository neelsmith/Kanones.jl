 """Finite verbs have person, number, tense, mood and voice."""
struct ParticipleForm <: GreekMorphologicalForm
    tense::GMPTense
    voice::GMPVoice
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

"""Participle forms are citable by Cite2Urn"""
CitableTrait(::Type{ParticipleForm}) = CitableByCite2Urn()

"""Compose a label for a `VerbalAdjectiveForm`

$(SIGNATURES)
"""
function label(ptcpl::ParticipleForm)
    join([label(ptcpl.tense), label(ptcpl.voice), label(ptcpl.pgender), label(ptcpl.pcase), label(ptcpl.pnumber)], " ")
end


"""Compose a Cite2Urn for a `ParticipleForm`.

$(SIGNATURES)
"""
function urn(ptcpl::ParticipleForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PARTICIPLE,"0",code(ptcpl.pnumber), code(ptcpl.tense), "0", code(ptcpl.voice), code(ptcpl.pgender), code(ptcpl.pcase), "00"))
end


"""Create a `ParticipleForm` from a string value.

$(SIGNATURES)
"""
function participleform(code::AbstractString)
    morphchars = split(code, "")
    pgender = gmpGender(parse(Int64, morphchars[7]))
    pcase = gmpCase(parse(Int64, morphchars[8]))
    pnumber = gmpNumber(parse(Int64, morphchars[3]))
    ptense = gmpTense(parse(Int64, morphchars[4]))
    pvoice = gmpVoice(parse(Int64, morphchars[6]))
    ParticipleForm(
        ptense,
        pvoice,
        pgender,
        pcase,
        pnumber
    )
end

"""Create a `ParticipleForm` from a `Cite2Urn`.

$(SIGNATURES)
"""
function participleform(urn::Cite2Urn)
    participleform(objectcomponent(urn))
end

"""Create a `ParticipleForm` from a `FormUrn`.

$(SIGNATURES)
"""
function participleform(f::FormUrn)
    participleform(f.objectid)
end


"""Create a `ParticipleForm` from an `Analysis`.

$(SIGNATURES)
"""
function participleform(a::Analysis)
    participleform(a.form)
end



"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function participlefromfst(fstdata)
    # Extract TVGCN from a string:
    ptcprulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(ptcprulere, fstdata))
    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as participle form.")
        nothing
    else
        (t, v, g, c, n) = matchedup[1].captures
        ParticipleForm(
        gmpTense(t), gmpVoice(v),
        gmpGender(g), gmpCase(c), gmpNumber(n)
        )
    end
end

"""Compose a `FormUrn` for an `InfinitiveForm`.

$(SIGNATURES)
"""
function formurn(ptcpl::ParticipleForm)
    #PosPNTMVGCDCat
    FormUrn(string("morphforms.", PARTICIPLE, 
    "0", code(ptcpl.pnumber), code(ptcpl.tense), "0", code(ptcpl.voice), 
    code(ptcpl.pgender), code(ptcpl.pcase), "00"))
end

