
"""Generate a form for a given adjective stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::VerbStem, 
    rule::VerbalAdjectiveRule;           
    ortho::GreekOrthography = literaryGreek())

    @debug("Gen. vadj with $(stem)")

    morphemes = split(stemstring(stem),"#")
    stembase = morphemes[end]
    if length(morphemes) > 1
        stembase = strcat(ortho, morphemes...)
    end

    if endswith(stembase,"θ")
        indices = collect(eachindex(stembase))
        quit =  indices[end - 1] 
        stembase = stembase[1:quit]

    end

    strcat(ortho, stembase, ending(rule))
 
end

"""Generate list of codes for all adjective forms.
$(SIGNATURES)
"""
function verbaladjectiveformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
   
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(VERBALADJECTIVE)0$(n)000$(g)$(c)00")
            end
        end
    end
   
    formlist
end

"""Generate list of all possible adjective forms.
$(SIGNATURES)
"""
function verbaladjectiveforms()
    verbaladjectiveformcodes() .|> gmfVerbalAdjective
end