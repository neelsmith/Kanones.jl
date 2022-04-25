
# Single rule pattern for all irregular forms.


"Inflectional rule for irregular form."
struct IrregularRule <: KanonesRule
    ruleid::AbbreviatedUrn
    inflectionclass
end

"""Implementation of reading one row of a rules table for irregular tokens.

$(SIGNATURES) 
"""
function readrulerow(ruleparser::Kanones.IrregularRuleParser, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        IrregularRule(ruleid, inflectionaltype)
    end
end


#=
"""Compose FST representation of a single `IrregularRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.IrregularRuleParser, ortho::T) where {T <: GreekOrthography}

    string("<", rule.infltype,"><irregular>", fstsafe(rule.ruleid))
end\=#