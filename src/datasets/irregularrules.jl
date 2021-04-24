
# Single rule pattern for all irregular forms.


"Inflectional rule for irregular form."
struct IrregularRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
end

"""Implementation of reading one row of a rules table for irregular tokens.

$(SIGNATURES) 
"""
function readrulerow(::Kanones.IrregularParser,  delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflectionaltype = parts[2]
        IrregularRule(ruleid, inflectionaltype)
    end
end
