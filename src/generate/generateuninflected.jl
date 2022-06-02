

"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::UninflectedStem, 
    rule::UninflectedRule;           
    ortho::GreekOrthography = literaryGreek())

    raw = stemstring(stem) * ending(rule)
    stripmetachars(raw)  |> knormal
end




"""Generate list of codes for all adjective forms.
$(SIGNATURES)
"""
function uninflectedformcodes()
    
    categoryints = keys(uninflectedlabeldict) |> collect |> sort
    formlist = []
    for c in categoryints
        push!(formlist, "$(UNINFLECTED)00000000$(c)")
    end
    formlist
end


"""Generate list of all possible noun forms.
$(SIGNATURES)
"""
function uninflectedforms()
    uninflectedformcodes() .|> gmfUninflected
end
