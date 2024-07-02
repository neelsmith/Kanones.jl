
"Inflectional rule for uninflected lexical items."
struct PronounRule <: KanonesRule
    ruleid::RuleUrn
    pronountype
end



function show(io::IO, pron::PronounRule)
    print(io, label(pron))
end

function ==(pn1::PronounRule, pn2::PronounRule)
    pn1.ruleid == pn2.ruleid &&
    pn1.pronountype == pn2.pronountype
end

"""Pronoun rules are citable by Cite2Urn"""
CitableTrait(::Type{PronounRule}) = CitableByCite2Urn()
function citabletrait(::Type{PronounRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `PronounRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pnr::PronounRule)
    string("Pronoun inflection rule: type of stem ", pnr.ruleid, " is ", pnr.pronountype)
end

"""Identifying URN for a `PronounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(pnr::PronounRule; registry = nothing)
    if isnothing(registry)
        pnr.ruleid
    else
        expand(pnr.ruleid, registry)
    end
end




struct PronounRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{PronounRule})  
    PronounRuleCex()
end


"""Compose CEX text for a `PronounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(pnr::PronounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([pnr.ruleid, inflectionclass(pnr)], delimiter)
    else
        c2urn = expand(pnr.ruleid, registry)
        join([c2urn, inflectionclass(pnr)], delimiter)
    end
end


function fromcex(traitvalue::PronounRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    ruleid = RuleUrn(parts[1])
    pronountype = parts[2]
 
    PronounRule(ruleid,pronountype)
end

"""Identify inflectional class for `pron`.
$(SIGNATURES)
"""
function inflectionclass(pron::PronounRule)
    pron.pronountype
end



function ending(rule::PronounRule)
    ""
end

"""Compose an abbreviated URN for a rule from a `PronounStem`.

$(SIGNATURES)
"""
function ruleurn(rule::PronounRule)
    rule.ruleid
end