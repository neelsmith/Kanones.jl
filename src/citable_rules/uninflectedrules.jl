"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct UninflectedRule <: KanonesRule
    ruleid::AbbreviatedUrn
    infltype::GMPUninflectedType
end


function show(io::IO, uninfl::UninflectedRule)
    print(io, label(uninfl))
end

function ==(uninfl1::UninflectedRule, uninfl2::UninflectedRule)
    uninfl1.ruleid == uninfl2.ruleid &&
    uninfl1.infltype == uninfl2.infltype
end



"""Uninflected rules are citable by Cite2Urn"""
CitableTrait(::Type{UninflectedRule}) = CitableByCite2Urn()
function citabletrait(::Type{UninflectedRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `UninflectedRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ur::UninflectedRule)
    string("Uninflected rule: ", ur.ruleid, " indicates a ", label(ur.infltype), ".")
end

"""Identifying URN for a `UninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ur::UninflectedRule; registry = nothing)
    if isnothing(registry)
        ur.ruleid
    else
        expand(ur.ruleid, registry)
    end
end




"""Identify inflectional class for `uninfl`.
$(SIGNATURES)
"""
function inflectionclass(uninfl::UninflectedRule)
    uninfl.infltype #|> label
end

function ending(uninfl::UninflectedRule)
    ""
end


struct UninflectedRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{UninflectedRule})  
    UninflectedRuleCex()
end


"""Compose CEX text for a `UninflectedRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ur::UninflectedRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ur.ruleid, label(ur.infltype)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn, label(ur.infltype)], delimiter)
    end
end

function fromcex(traitvalue::UninflectedRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for uninflected rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        @debug("Reading CEX: get uninfl type from $(parts[2])")
        inflectionaltype = gmpUninflectedType(parts[2])
        UninflectedRule(ruleid, inflectionaltype)
    end
end


"""Identify identifier URN for an `UninflectedRule`.

$(SIGNATURES)
"""
function id(uninfl::UninflectedRule)
    uninfl.ruleid
end

function ruleurn(rule::UninflectedRule)
    rule.ruleid
end

#=
   # PosPNTMVGCDCat
    RuleUrn(string("$(COLLECTION_ID).", UNINFLECTED,"00000000",code(stem.stemcategory))) 
=#