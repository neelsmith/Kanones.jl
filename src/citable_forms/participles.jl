 """Finite verbs have person, number, tense, mood and voice."""
struct GMFParticiple <: GreekMorphologicalForm
    tense::GMPTense
    voice::GMPVoice
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

function show(io::IO, ptcp::GMFParticiple)
    print(io, label(ptcp))
end
function ==(ptcp1::GMFParticiple, ptcp2::GMFParticiple)
    ptcp1.tense == ptcp2.tense &&
    ptcp1.voice == ptcp2.voice &&
    ptcp1.pgender == ptcp2.pgender &&
    ptcp1.pcase == ptcp2.pcase &&
    ptcp1.pnumber == ptcp2.pnumber
end



"""Participle forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFParticiple}) = CitableByCite2Urn()
function citabletrait(::Type{GMFParticiple})
    CitableByCite2Urn()
end


"""Compose a Cite2Urn for a `GMFParticiple`.

$(SIGNATURES)
"""
function urn(ptcpl::GMFParticiple)
    # PosPNTMVGCDCat
    Cite2Urn(BASE_MORPHOLOGY_URN * code(ptcpl))
end

"""Compose a label for a `GMFVerbalAdjective`

$(SIGNATURES)
"""
function label(ptcpl::GMFParticiple)
    join(["participle:", label(ptcpl.tense), label(ptcpl.voice), label(ptcpl.pgender), label(ptcpl.pcase), label(ptcpl.pnumber)], " ")
end




"""Extract tense property from `p`.
$(SIGNATURES)
"""
function gmpTense(p::GMFParticiple)
    p.tense
end

"""Extract voice property from `p`.
$(SIGNATURES)
"""
function gmpVoice(p::GMFParticiple)
    p.voice
end


"""Extract gender property from `p`.
$(SIGNATURES)
"""
function gmpGender(p::GMFParticiple)
    p.pgender
end

"""Extract case property from `p`.
$(SIGNATURES)
"""
function gmpCase(p::GMFParticiple)
    p.pcase
end

"""Extract tense property from `p`.
$(SIGNATURES)
"""
function gmpNumber(p::GMFParticiple)
    p.pnumber
end



"""Compose digital code for `ptcpl`.
$(SIGNATURES)
"""
function code(ptcpl::GMFParticiple)
    #PosPNTMVGCDCat
    string(PARTICIPLE,"0",code(ptcpl.pnumber), code(ptcpl.tense), "0", code(ptcpl.voice), code(ptcpl.pgender), code(ptcpl.pcase), "00")
end



"""Create a `GMFParticiple` from a string value.

$(SIGNATURES)
"""
function gmfParticiple(code::AbstractString)
    morphchars = split(code, "")
    pgender = gmpGender(parse(Int64, morphchars[7]))
    pcase = gmpCase(parse(Int64, morphchars[8]))
    pnumber = gmpNumber(parse(Int64, morphchars[3]))
    ptense = gmpTense(parse(Int64, morphchars[4]))
    pvoice = gmpVoice(parse(Int64, morphchars[6]))
    GMFParticiple(
        ptense,
        pvoice,
        pgender,
        pcase,
        pnumber
    )
end

"""Create a `GMFParticiple` from a `Cite2Urn`.

$(SIGNATURES)
"""
function gmfParticiple(urn::Cite2Urn)
    gmfParticiple(objectcomponent(urn))
end

"""Create a `GMFParticiple` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfParticiple(f::FormUrn)
    gmfParticiple(f.objectid)
end


"""Create a `GMFParticiple` from an `Analysis`.

$(SIGNATURES)
"""
function gmfParticiple(a::Analysis)
    gmfParticiple(a.form)
end





"""Compose a `FormUrn` for an `GMFParticiple`.

$(SIGNATURES)
"""
function formurn(ptcpl::GMFParticiple)    
    FormUrn("$(COLLECTION_ID)." * code(ptcpl))
end

