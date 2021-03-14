
"""Nouns have gender, case and number."""
struct NounForm <: MorphologicalForm
    ngender::Int64
    genderlabel::AbstractString    
    ncase::Int64
    caselabel::AbstractString    
    nnumber::Int64
    numberlabel::AbstractString    
end

"""Create a `NounForm` from a URN."""
function nounform(urn::Cite2Urn)
    morphchars = split(objectcomponent(urn),"")
    ngender = parse(Int64, morphchars[7])
    ncase = parse(Int64, morphchars[8])
    nnumber = parse(Int64, morphchars[3])
    genderdict = valuedict(genderpairs)
    casedict = valuedict(casepairs)
    numberdict = valuedict(numberpairs)
    NounForm(
        ngender, genderdict[ngender],
        ncase, casedict[ncase],
        nnumber, numberdict[nnumber]
    )
end


"""Compose URN for a `NounForm`."""
function urn(noun::NounForm)
    nothing
end


"""Compose CEX representation for a `NounForm`."""
function cex(noun::NounForm)
end

"""Compose URN for noun form from FST representation of analytical data."""
function nounurn(fstdata)
end

"""Compose CEX representation of URNs and labels for noun forms."""
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
