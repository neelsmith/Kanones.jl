
"""Compose CEX representation of URNs and labels for noun forms.

$(SIGNATURES)
"""
function nounscex()
    genderkeys = keys(Kanones.genderlabeldict)  |> collect |> sort 
    casekeys = keys(Kanones.caselabeldict)  |> collect |> sort 
    numberkeys = keys(Kanones.numberlabeldict)  |> collect |> sort 
    lines = []
    # PosPNTMVGCDCat
    for num in numberkeys
        for gen in genderkeys
            for cs in casekeys
                u = string(BASE_MORPHOLOGY_URN, NOUN, "0", num, "000", gen, cs, "00")
                label = string("noun: ", label(gmpGender(gen)), " ", label(gmpCase(cs)), " ", label(gmpNumber(num)))
                cex = string(u, "|", label)
                push!(lines, cex)
            end
        end
    end
    join(lines, "\n")    
end
s