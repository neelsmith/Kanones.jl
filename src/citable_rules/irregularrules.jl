
# Single rule pattern for all irregular forms.
"Inflectional rule for irregular form."
struct IrregularRule <: KanonesRule
    ruleid::AbbreviatedUrn
    inflectionclass
end



function show(io::IO, irr::IrregularRule)
    print(io, label(irr))
end

function ==(v1::IrregularRule, v2::IrregularRule)
    v1.ruleid == v2.ruleid &&
    v1.inflectionclass == v2.inflectionclass
end



"""Irregular rules are citable by Cite2Urn"""
CitableTrait(::Type{IrregularRule}) = CitableByCite2Urn()
function citabletrait(::Type{IrregularRule})
    CitableByCite2Urn()
end

"""Human-readlable label for an `IrregularRule`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(irreg::IrregularRule)
    string("Uninflected rule: ", irreg.ruleid, " applies to type ", inflectionclass(irreg), ".")
end

"""Identifying URN for a `UninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(irreg::IrregularRule; registry = nothing)
    if isnothing(registry)
        irreg.ruleid
    else
        expand(irreg.ruleid, registry)
    end
end




struct IrregularRuleCex <: CexTrait end
function cextrait(::Type{IrregularRule})  
    IrregularRuleCex()
end

"""Compose CEX text for an `IrregularRule`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(irreg::IrregularRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([irreg.ruleid,  inflectionclass(irreg)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn,  inflectionclass(irreg)], delimiter)
    end
end

function fromcex(traitvalue::IrregularRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        IrregularRule(ruleid, inflectionaltype)
    end
end


"""Identify inflectional class for `irreg`.
$(SIGNATURES)
"""
function inflectionclass(irreg::IrregularRule)
    irreg.inflectionclass
end

function ending(irreg::IrregularRule)
    ""
end


function ruleurn(irreg::IrregularRule)
    irreg.ruleid
end


"""Compose an abbreviated URN for a rule from a `IrregularRule`.

$(SIGNATURES)
"""
function formurn(irreg::IrregularRule)
    #FormUrn(string("$(COLLECTION_ID).", irreg.ruleid))
    ruleurn(irreg)
end
