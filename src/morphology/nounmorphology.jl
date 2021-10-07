"""Nouns have gender, case and number."""
struct NounForm <: MorphologicalForm
    ngender::Int64
    #genderlabel::AbstractString    
    ncase::Int64
    #caselabel::AbstractString    
    nnumber::Int64
    #numberlabel::AbstractString    
end

"""Create a `NounForm` from a string value.

$(SIGNATURES)
"""
function nounform(code::AbstractString)
    morphchars = split(code, "")
    ngender = parse(Int64, morphchars[7])
    ncase = parse(Int64, morphchars[8])
    nnumber = parse(Int64, morphchars[3])
    #genderdict = valuedict(genderpairs)
    #casedict = valuedict(casepairs)
    #numberdict = valuedict(numberpairs)
    NounForm(
        ngender,# genderdict[ngender],
        ncase, #casedict[ncase],
        nnumber, #numberdict[nnumber]
    )
end


"""Create a `NounForm` from a `Cite2Urn`.

$(SIGNATURES)
"""
function nounform(urn::Cite2Urn)
    nounform(objectcomponent(urn))
end

"""Create a `NounForm` from a `FormUrn`.

$(SIGNATURES)
"""
function nounform(f::FormUrn)
    nounform(f.objectid)
end

"""Create a `NounForm` from an `Analysis`.

$(SIGNATURES)
"""
function nounform(a::Analysis)
    nounform(a.form)
end

"""Compose a label for a `NounForm`

$(SIGNATURES)
"""
function label(noun::NounForm)
    gdict = Kanones.genderpairs |> Kanones.valuedict
    cdict = Kanones.casepairs |> Kanones.valuedict
    ndict = Kanones.numberpairs |> Kanones.valuedict
    join([gdict[noun.ngender], cdict[noun.ncase], ndict[noun.nnumber]], " ")
end

"""Compose a Cite2Urn for a `NounForm`.

$(SIGNATURES)
"""
function urn(noun::NounForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, NOUN,"0",noun.nnumber,"000",noun.ngender,noun.ncase,"00"))
end


"""Compose an abbreviated URN for a form from a `NounRule`.

$(SIGNATURES)
"""
function abbrurn(rule::NounRule)
    numdict = labeldict(numberpairs)
    casedict = labeldict(casepairs)
    genderdict = labeldict(genderpairs)

    # PosPNTMVGCDCat
    FormUrn(string("morphforms.", NOUN,"0",numdict[rule.nnumber],"000",genderdict[rule.ngender],casedict[rule.ncase],"00"))
end


"""Compose CEX representation for a `NounForm`.

$(SIGNATURES)
"""
function cex(noun::NounForm, delim="|")
    join([urn(noun), label(noun)], delim)
end



"""Compose a `FormUrn` for a `NounForm`.

$(SIGNATURES)
"""
function formurn(nounform::NounForm)
    FormUrn(string("morphforms.", NOUN,"0",nounform.nnumber,"000",nounform.ngender, nounform.ncase, "00"))
end

"""Compose a FormUrn for a noun form from FST representation of analytical data.

$(SIGNATURES)
"""
function nounfromfst(fstdata)
    # Example:
    # <feminine><accusative><singular>
    #@warn("Parse FST noun " * fstdata)
    nounrulere = r"<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\"")
        nothing
    else
        # E.g.,
        # 1="feminine", 2="accusative", 3="singular")

        (g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)

        nounform = NounForm(genderdict[g], #g,
        casedict[c], #c,
        numberdict[n] ) #, n)
        
    end
end

"""Compose CEX representation of URNs and labels for noun forms.

$(SIGNATURES)
"""
function nounscex()
    genderdict = valuedict(genderpairs)
    genderkeys = keys(genderdict)  |> collect |> sort 
    casedict = valuedict(casepairs)
    casekeys = keys(casedict)  |> collect |> sort 
    numberdict = valuedict(numberpairs)
    numberkeys = keys(numberdict)  |> collect |> sort 
    lines = []
    # PosPNTMVGCDCat
    for num in numberkeys
        for gen in genderkeys
            for cs in casekeys
                u = string(BASE_MORPHOLOGY_URN, NOUN, "0", num, "000", gen, cs, "00")
                label = string("noun: ", genderdict[gen], " ", casedict[cs], " ", numberdict[num])
                cex = string(u, "|", label)
                push!(lines, cex)
            end
        end
    end
    join(lines, "\n")    
end
