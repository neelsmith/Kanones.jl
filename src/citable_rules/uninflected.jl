"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct UninflectedRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    infltype
end

"""Identify identifier URN for an `UninflectedRule`.

$(SIGNATURES)
"""
function id(uninfl::UninflectedRule)
    uninfl.ruleid
end

"""Implementation of reading one row of a rules table for uninflected tokens.

$(SIGNATURES)
"""
function readrulerow(usp::UninflectedIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for uninflected rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        UninflectedRule(ruleid, inflectionaltype)
    end
end

function ruleurn(rule::UninflectedRule)
    posdict = labeldict(uninflectedpairs)
    # PosPNTMVGCDCat
    FormUrn(string("morphforms.", UNINFLECTED,"00000000",posdict[rule.infltype])) 

end
