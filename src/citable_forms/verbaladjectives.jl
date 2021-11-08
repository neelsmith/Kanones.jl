
"""Verbal adjectives have gender, case and number."""
struct VerbalAdjectiveForm <: GreekMorphologicalForm
    vagender::Int64
    vacase::Int64
    vanumber::Int64
end

"""Verbal adjective forms are citable by Cite2Urn"""
CitableTrait(::Type{VerbalAdjectiveForm}) = CitableByCite2Urn()

"""Compose a label for a `VerbalAdjectiveForm`

$(SIGNATURES)
"""
function label(vadj::VerbalAdjectiveForm)
    gdict = Kanones.genderpairs |> Kanones.valuedict
    cdict = Kanones.casepairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    join([gdict[vadj.vagender], cdict[vadj.vacase], ndict[vadj.vanumber]], " ")
end

"""Compose a Cite2Urn for a `VerbalAdjectiveForm`.

$(SIGNATURES)
"""
function urn(vadj::VerbalAdjectiveForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, VERBALADJECTIVE,"0",vadj.vanumber,"000",vadj.vagender,vadj.vacase,"00"))
end

"""Create a `VerbalAdjectiveForm` from a string value.

$(SIGNATURES)
"""
function verbaladjectiveform(code::AbstractString)
    morphchars = split(code, "")
    vagender = parse(Int64, morphchars[7])
    vacase = parse(Int64, morphchars[8])
    vanumber = parse(Int64, morphchars[3])
    VerbalAdjectiveForm(
        vagender,
        vacase,
        vanumber
    )
end

"""Create a `VerbalAdjectiveForm` from a `Cite2Urn`.

$(SIGNATURES)
"""
function verbaladjectiveform(urn::Cite2Urn)
    verbaladjectiveform(objectcomponent(urn))
end

"""Create a `VerbalAdjectiveForm` from a `FormUrn`.

$(SIGNATURES)
"""
function verbaladjectiveform(f::FormUrn)
    verbaladjectiveform(f.objectid)
end


"""Create a `VerbalAdjectiveForm` from an `Analysis`.

$(SIGNATURES)
"""
function verbaladjectiveform(a::Analysis)
    verbaladjectiveform(a.form)
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
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        VerbalAdjectiveForm(
        genderdict[g],
        casedict[c],
        numberdict[n]
        )
    end
end

"""Compose a `FormUrn` for an `VerbalAdjectiveForm`.

$(SIGNATURES)
"""
function formurn(vadj::VerbalAdjectiveForm)
    FormUrn(string("morphforms.", VERBALADJECTIVE, "0" ,vadj.vanumber,"000",vadj.vagender, vadj.vacase,"00"))
end
#PosPNTMVGCDCat
