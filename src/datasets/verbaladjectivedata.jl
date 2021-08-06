"""Inflectional rule for a verbal adjective.

$(SIGNATURES)
"""
struct VerbalAdjectiveRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
    ending
    vagender
    vacase
    vanumber
end


"""Read one row of a rules table for infinitives and create an `InfinitiveRule`.

$(SIGNATURES)
"""
function readrulerow(usp::VerbalAdjectiveRuleParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 6
        msg = "Invalid syntax for verbal adjective: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = parts[4]
        c = parts[5]
        n = parts[6]

        VerbalAdjectiveRule(ruleid, inflclass, ending,g,c,n)
    end

end

