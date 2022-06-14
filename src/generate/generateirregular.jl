

"""Generate a form for a given noun stem and rule by combining
stem and ending, then adding appropriate accent for this lexical
item in this form, and finally stripping off metadata characters
marking vowel quantity and morpheme boundaries.
$(SIGNATURES)
"""
function generate(
    stem::T, 
    rule::IrregularRule;           
    ortho::GreekOrthography = literaryGreek()) where {T <: KanonesIrregularStem}
    
    stemstring(stem)  |> knormal
end

