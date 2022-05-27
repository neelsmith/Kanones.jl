

"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::PronounStem, 
    rule::PronounRule;           
    ortho::GreekOrthography = literaryGreek())

    raw = stemstring(stem) * ending(rule)
    stripmetachars(raw)  |> nfkc
end





"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function pronounformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(PRONOUN)0$(n)000$(g)$(c)00")
            end
        end
    end
    formlist
end

"""Generate list of all possible prnoun forms.
$(SIGNATURES)
"""
function pronounforms()
    pronounformcodes() .|> gmfPronoun
end


