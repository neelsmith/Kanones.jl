"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct UninflectedRule <: KanonesRule
    ruleid::AbbreviatedUrn
    infltype::GMPUninflectedType
end




"""Identify inflectional class for `uninfl`.
$(SIGNATURES)
"""
function inflectionClass(uninfl::UninflectedRule)
    uninfl.infltype
end

function ending(uninfl::UninflectedRule)
    ""
end

"""Uninflected rules are citable by Cite2Urn"""
CitableTrait(::Type{UninflectedRule}) = CitableByCite2Urn()


"""Human-readlable label for a `UninflectedRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ur::UninflectedRule)
    string("Uninflected rule: ", ur.ruleid, " indicates a ", label(ur.infltype), ".")
end

"""Identifying URN for a `UninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ur::UninflectedRule; registry = nothing)
    if isnothing(registry)
        ur.ruleid
    else
        expand(ur.ruleid, registry)
    end
end



"""Compose CEX text for a `NounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ur::UninflectedRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ur.ruleid, label(ur), label(ur.infltype)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn, label(ur), label(ur.infltype)], delimiter)
    end
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
        inflectionaltype = gmpUninflectedType(parts[2])
        UninflectedRule(ruleid, inflectionaltype)
    end
end

function ruleurn(rule::UninflectedRule)
    rule.ruleid
end

#=
   # PosPNTMVGCDCat
    RuleUrn(string("$(COLLECTION_ID).", UNINFLECTED,"00000000",code(stem.stemcategory))) 
=#