"""Nouns have gender, case and number."""
struct PronounForm <: MorphologicalForm
    pgender::Int64
    pcase::Int64
    pnumber::Int64
end

"""Pronoun forms are citable by Cite2Urn"""
CitableTrait(::Type{PronounForm}) = CitableByCite2Urn()


"""Compose a label for a `PronounForm`

$(SIGNATURES)
"""
function label(pronoun::PronounForm)
    gdict = Kanones.genderpairs |> Kanones.valuedict
    cdict = Kanones.casepairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    join([gdict[pronoun.pgender], cdict[pronoun.pcase], ndict[pronoun.pnumber]], " ")
end

"""Compose a Cite2Urn for a `PronounForm`.

$(SIGNATURES)
"""
function urn(pronoun::PronounForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PRONOUN,"0",pronoun.pnumber,"000",pronoun.pgender,pronoun.pcase,"00"))
end

"""Create a `PronounForm` from a string value.

$(SIGNATURES)
"""
function pronounform(code::AbstractString)
    morphchars = split(code, "")
    ngender = parse(Int64, morphchars[7])
    ncase = parse(Int64, morphchars[8])
    nnumber = parse(Int64, morphchars[3])
    PronounForm(
        ngender, #genderdict[ngender],
        ncase, #casedict[ncase],
        nnumber, #numberdict[nnumber]
    )
end
 # PosPNTMVGCDCat


 """Create a `PronounForm` from a `Cite2Urn`.

 $(SIGNATURES)
 """
 function pronounform(urn::Cite2Urn)
     pronounform(objectcomponent(urn))
 end


 """Create a `PronounForm` from a `FormUrn`.

 $(SIGNATURES)
 """
 function pronounform(f::FormUrn)
    pronounform(f.objectid)
 end

 """Create a `PronounForm` from an `Analysis`.

 $(SIGNATURES)
 """
 function pronounform(a::Analysis)
    pronounform(a.form)
 end


"""Compose a `FormUrn` for a `PronounForm`.
$(SIGNATURES)
"""
function formurn(pronounform::PronounForm)
    FormUrn(string("morphforms.", PRONOUN,"0",pronounform.pnumber,"000",pronounform.pgender,pronounform.pcase,"00"))
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
        # E.g.,
        # 1="feminine", 2="accusative", 3="singular")

        (g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)
        PronounForm(genderdict[g],
            casedict[c],
            numberdict[n]  
        )
    end
end


 # PosPNTMVGCDCat