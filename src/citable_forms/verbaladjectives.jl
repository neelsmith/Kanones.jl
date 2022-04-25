
"""Verbal adjectives have gender, case and number."""
struct GMFVerbalAdjective <: GreekMorphologicalForm
    vagender::GMPGender
    vacase::GMPCase
    vanumber::GMPNumber
end

"""Verbal adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFVerbalAdjective}) = CitableByCite2Urn()

"""Compose a label for a `GMFVerbalAdjective`

$(SIGNATURES)
"""
function label(vadj::GMFVerbalAdjective)
    join([label(vadj.vagender), label(vadj.vacase), label(vadj.vanumber)], " ")
end

"""Compose a Cite2Urn for a `GMFVerbalAdjective`.

$(SIGNATURES)
"""
function urn(vadj::GMFVerbalAdjective)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, VERBALADJECTIVE,"0",code(vadj.vanumber),"000",code(vadj.vagender), code(vadj.vacase),"00"))
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


"""Compose URN for verbal adjective form from FST representation of analytical data.

$(SIGNATURES)
"""
function verbaladjectivefromfst(fstdata)
    vadjrulere = r"<([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(vadjrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (g,c,n) = matchedup[1].captures
        GMFVerbalAdjective(gmpGender(g),gmpCase(c),gmpNumber(n))
    end
end

"""Compose a `FormUrn` for an `GMFVerbalAdjective`.

$(SIGNATURES)
"""
function formurn(vadj::GMFVerbalAdjective)
    FormUrn(string("$(COLLECTION_ID).", VERBALADJECTIVE, "0" ,code(vadj.vanumber),"000", code(vadj.vagender), code(vadj.vacase),"00"))
end
#PosPNTMVGCDCat
