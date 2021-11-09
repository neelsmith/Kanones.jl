"Inflectional rule for adjectives."
struct AdjectiveRule <: KanonesRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    agender::GMPGender
    acase::GMPCase
    anumber::GMPNumber
    adegree::GMPDegree
end


"""Implementation of reading one row of a rules table for uninflected tokens.

$(SIGNATURES) 
"""
function readrulerow(usp::AdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for adjective rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = nfkc(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
        d = gmpDegree(parts[7])
        AdjectiveRule(ruleid, inflclass, ending, g,c,n,d)
    end
    
end


"""Adjective rules are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveRule}) = CitableByCite2Urn()

"""Human-readlable label for an `AdjectiveRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::AdjectiveRule)
    string("Adjective inflection rule: ending -", adj.ending, " in class ", adj.inflectionclass, " can be ", label(adj.agender), " ", label(adj.acase), " ", label(adj.anumber), " ", label(adj.adegree),".")
end


"""Identifying URN for an `AdjectiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::AdjectiveRule; registry = nothing)
    if isnothing(registry)
        adj.ruleid
    else
        expand(adj.ruleid, registry)
    end
end

"""Compose CEX text for an `AdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::AdjectiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.ruleid, label(adj)], delimiter)
    else
        c2urn = expand(adj.ruleid, registry)
        join([c2urn, label(adj)], delimiter)
    end
end


"""Compose an abbreviated URN for a rule from a `AdjectiveRule`.

$(SIGNATURES)
"""
function ruleurn(rule::AdjectiveRule)
    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", ADJECTIVE,"0",code(rule.anumber),"000",code(rule.agender),code(rule.acase),code(rule.adegree),"0"))
end
#PosPNTMVGCDCat