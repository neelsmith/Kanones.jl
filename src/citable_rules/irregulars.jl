
# Single rule pattern for all irregular forms.


"Inflectional rule for irregular form."
struct IrregularRule <: KanonesRule
    ruleid::AbbreviatedUrn
    inflectionclass
end


"""Identify inflectional class for `irreg`.
$(SIGNATURES)
"""
function inflectionClass(irreg::IrregularRule)
    irreg.inflectionclass
end

function ending(irreg::IrregularRule)
    ""
end


"""Irregular rules are citable by Cite2Urn"""
CitableTrait(::Type{IrregularRule}) = CitableByCite2Urn()


"""Human-readlable label for an `IrregularRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(irreg::IrregularRule)
    string("Uninflected rule: ", irreg.ruleid, " applies to type ", inflectionClass(irreg), ".")
end

"""Identifying URN for a `UninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(irreg::IrregularRule; registry = nothing)
    if isnothing(registry)
        irreg.ruleid
    else
        expand(irreg.ruleid, registry)
    end
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



"""Compose CEX text for a `NounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(irreg::IrregularRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([irreg.ruleid, label(irreg), inflectionClass(irreg)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn, label(irreg), inflectionClass(irreg)], delimiter)
    end
end



function ruleurn(irreg::IrregularRule)
    irreg.ruleid
end