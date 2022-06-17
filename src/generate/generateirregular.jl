

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
    rawentry = stemstring(stem)  
    if occursin("#", rawentry)
        baseparts = split(rawentry, "#")
  
        if length(baseparts) > 1
            basemorpheme = baseparts[end]
            prefix = replace(join(baseparts[1:end-1],""), "#" => "")
            @debug("Prefix is ", prefix)
            raw = strcat(prefix, basemorpheme, ortho)
            knormal(raw)
        end


    else
        knormal(rawentry)
    end
end

