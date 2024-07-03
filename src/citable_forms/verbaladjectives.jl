
"""Verbal adjectives have gender, case and number."""
struct GMFVerbalAdjective <: GreekMorphologicalForm
    vagender::GMPGender
    vacase::GMPCase
    vanumber::GMPNumber
end

function show(io::IO, va::GMFVerbalAdjective)
    print(io, label(va))
end
function ==(va1::GMFVerbalAdjective, va2::GMFVerbalAdjective)

    va1.vagender == va2.vagender &&
    va1.vacase == va2.vacase &&
    va1.vanumber == va2.vanumber
end

"""Verbal adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFVerbalAdjective}) = CitableByCite2Urn()

function citabletrait(::Type{GMFVerbalAdjective})
    CitableByCite2Urn()
end


"""Compose a Cite2Urn for a `GMFVerbalAdjective`.

$(SIGNATURES)
"""
function urn(vadj::GMFVerbalAdjective)
    # PosPNTMVGCDCat
    Cite2Urn(BASE_MORPHOLOGY_URN * code(vadj))
end

"""Compose a label for a `GMFVerbalAdjective`

$(SIGNATURES)
"""
function label(vadj::GMFVerbalAdjective)
    join(["verbal adjective:", label(vadj.vagender), label(vadj.vacase), label(vadj.vanumber)], " ")
end



"""Extract gender property from `vadj`.
$(SIGNATURES)
"""
function gmpGender(vadj::GMFVerbalAdjective)
    vadj.vagender
end

"""Extract case property from `vadj`.
$(SIGNATURES)
"""
function gmpCase(vadj::GMFVerbalAdjective)
    vadj.vacase
end


"""Extract number property from `vadj`.
$(SIGNATURES)
"""
function gmpNumber(vadj::GMFVerbalAdjective)
    vadj.vanumber
end



"""Compose a digital code for `vadj`.
$(SIGNATURES)
"""
function code(vadj::GMFVerbalAdjective)
    # PosPNTMVGCDCat
    string(VERBALADJECTIVE,"0",code(vadj.vanumber),"000",code(vadj.vagender), code(vadj.vacase),"00")
end



"""Create a `GMFVerbalAdjective` from a string value.

$(SIGNATURES)
"""
function gmfVerbalAdjective(code::AbstractString)
    morphchars = split(code, "")
    vagender = gmpGender(parse(Int64, morphchars[7]))
    vacase = gmpCase(parse(Int64, morphchars[8]))
    vanumber = gmpNumber(parse(Int64, morphchars[3]))
    GMFVerbalAdjective(
        vagender,
        vacase,
        vanumber
    )
end

"""Create a `GMFVerbalAdjective` from a `Cite2Urn`.

$(SIGNATURES)
"""
function gmfVerbalAdjective(urn::Cite2Urn)
    gmfVerbalAdjective(objectcomponent(urn))
end

"""Create a `GMFVerbalAdjective` from a `FormUrn`.

$(SIGNATURES)
"""
function gmfVerbalAdjective(f::FormUrn)
    gmfVerbalAdjective(f.objectid)
end


"""Create a `GMFVerbalAdjective` from an `Analysis`.

$(SIGNATURES)
"""
function gmfVerbalAdjective(a::Analysis)
    gmfVerbalAdjective(a.form)
end

"""Compose a `FormUrn` for an `GMFVerbalAdjective`.

$(SIGNATURES)
"""
function formurn(vadj::GMFVerbalAdjective)
    FormUrn("$(COLLECTION_ID)." * code(vadj))
end
