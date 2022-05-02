
"Inflectional rule for uninflected lexical items."
struct PronounRule <: KanonesRule
    ruleid::RuleUrn
    pronountype
end

"""Identify inflectional class for `pron`.
$(SIGNATURES)
"""
function inflectionClass(pron::PronounRule)
    pron.pronountype
end

"""
Read one row of a stems table for pronoun tokens and create a `PronounRule`.

$(SIGNATURES)    
"""
function readrulerow(usp::PronounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    ruleid = RuleUrn(parts[1])
    pronountype = parts[2]
 
    PronounRule(ruleid,pronountype)
end


"""Pronoun rules are citable by Cite2Urn"""
CitableTrait(::Type{PronounRule}) = CitableByCite2Urn()


"""Human-readlable label for a `PronounRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pnr::PronounRule)
    string("Pronoun inflection rule: type of stem ", pnr.ruleid, " is ", pnr.pronountype)
end


"""Identifying URN for a `PronounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(pnr::PronounRule; registry = nothing)
    if isnothing(registry)
        pnr.ruleid
    else
        expand(pnr.ruleid, registry)
    end
end


"""Compose CEX text for a `PronounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(pnr::PronounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([pnr.ruleid, label(pnr), inflectionClass(pnr)], delimiter)
    else
        c2urn = expand(pnr.ruleid, registry)
        join([c2urn, label(pnr), inflectionClass(pnr)], delimiter)
    end
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