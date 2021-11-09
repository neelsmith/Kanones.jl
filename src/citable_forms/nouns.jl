"""Nouns have gender, case and number."""
struct NounForm <: GreekMorphologicalForm
    ngender::GMPGender
    ncase::GMPCase
    nnumber::GMPNumber
end

"""Noun forms are citable by Cite2Urn"""
CitableTrait(::Type{NounForm}) = CitableByCite2Urn()


"""Compose a label for a `NounForm`

$(SIGNATURES)
"""
function label(noun::NounForm)    
    join([ label(noun.ngender), label(noun.ncase), label(noun.nnumber)], " ")
end

"""Compose a Cite2Urn for a `NounForm`.

$(SIGNATURES)
"""
function urn(noun::NounForm)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, NOUN,"0",code(noun.nnumber),"000",code(noun.ngender),code(noun.ncase),"00"))
end


"""Create a `NounForm` from a string value.

$(SIGNATURES)
"""
function nounform(code::AbstractString)
    morphchars = split(code, "")
    ngender = gmpGender(parse(Int64, morphchars[7]))
    ncase = gmpCase(parse(Int64, morphchars[8]))
    nnumber = gmpNumber(parse(Int64,morphchars[3]))
    
    NounForm(ngender, ncase, nnumber)
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


"""Compose a `FormUrn` for a `NounForm`.

$(SIGNATURES)
"""
function formurn(nounform::NounForm)
    FormUrn(string("morphforms.", NOUN,"0",code(nounform.nnumber),"000", code(nounform.ngender), code(nounform.ncase), "00"))
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
        (g,c,n) = matchedup[1].captures
        NounForm(gmpGender(g), gmpCase(c), gmpNumber(n)) 
    end
end


"""Compose a FormUrn for a noun form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularnounfromfst(fstdata)
    # Looks like:
    #<u>irregnoun.irregn23069a</u><u>lsj.n23069</u>γυνη<irregular><irregularnoun><feminine><nominative><singular><div><irregularnoun><irregular><u>litgreek.irregular1</u>
    # 2-4 are gcn
    ngender =  matchedup[2].captures[1]
    ncase = matchedup[3].captures[1]
    nnumber = matchedup[4].captures[1]
    NounForm(
        gmpGender(ngender),
        gmpCase(ncase),
        gmpNumber(nnumber)
    )
end


"""Compose CEX representation of URNs and labels for noun forms.

$(SIGNATURES)
"""
function nounscex()
    genderkeys = keys(genderlabels)  |> collect |> sort 
    casekeys = keys(caselabels)  |> collect |> sort 
    numberkeys = keys(numberlabels)  |> collect |> sort 
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
