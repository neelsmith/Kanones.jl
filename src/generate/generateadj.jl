#




"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function adjectiveformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    degreeints = keys(degreelabeldict) |> collect |> sort
    formlist = []
    for d in degreeints
        for n in numints
            for g in genderints
                for c in caseints
                    push!(formlist, "$(ADJECTIVE)0$(n)000$(g)$(c)$(d)0")
                end
            end
        end
    end
    formlist
end

"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function adjectiveforms()
    adjectiveformcodes() .|> gmfAdjective
end