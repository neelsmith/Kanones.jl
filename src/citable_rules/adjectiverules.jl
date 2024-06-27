"Inflectional rule for adjectives."
struct AdjectiveRule <: KanonesRule
    ruleid::RuleUrn
    inflectionclass
    ending
    agender::GMPGender
    acase::GMPCase
    anumber::GMPNumber
    adegree::GMPDegree
end

function show(io::IO, adj::AdjectiveRule)
    print(io, label(adj))
end

function ==(adj1::AdjectiveRule, adj2::AdjectiveRule)
    adj1.ruleid == adj2.ruleid &&
    adj1.inflectionclass == adj2.inflectionclass &&
    adj1.ending == adj2.ending &&
    adj1.agender == adj2.agender && 
    adj1.acase == adj2.acase && 
    adj1.anumber  == adj2.anumber &&
    adj1.adegree == adj2.adegree
end


"""Adjective rules are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveRule}) = CitableByCite2Urn()
function citabletrait(::Type{AdjectiveRule})
    CitableByCite2Urn()
end

"""Human-readlable label for an `AdjectiveRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::AdjectiveRule)
    string("Adjective inflection rule: ending -", adj.ending, " in class ", adj.inflectionclass, " can be ", label(adj.agender), " ", label(adj.acase), " ", label(adj.anumber), " ", label(adj.adegree),".")
end

"""Identifying URN for an `AdjectiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::AdjectiveRule; registry = nothing)::Union{RuleUrn, Cite2Urn}
    if isnothing(registry)
        adj.ruleid
    else
        
        expand(adj.ruleid, registry)
    end
end

struct AdjRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{AdjectiveRule})  
    AdjRuleCex()
end

function fromcex(traitvalue::AdjRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for adjective rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = knormal(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
        d = gmpDegree(parts[7])
        AdjectiveRule(ruleid, inflclass, ending, g,c,n,d)
    end

end

function cex(adj::AdjectiveRule; delimiter = "|", registry = nothing)
    #"adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    if isnothing(registry)
        join([adj.ruleid, label(adj), ending(adj), inflectionclass(adj), formurn(adj)], delimiter)
    else
        c2urn = expand(adj.ruleid, registry)
        join([c2urn, label(adj),ending(adj), inflectionclass(adj), formurn(adj)], delimiter)
    end
end


"""Identify `adj` with a `RuleUrn`.
$(SIGNATURES)
"""
function ruleurn(adj::AdjectiveRule)
    adj.ruleid
end

"""Identify gender for `adj`.
$(SIGNATURES)
"""
function gmpGender(adj::AdjectiveRule)
    adj.agender
end

"""Identify case for `adj`.
$(SIGNATURES)
"""
function gmpCase(adj::AdjectiveRule)
    adj.acase
end

"""Identify number for `adj`.
$(SIGNATURES)
"""
function gmpNumber(adj::AdjectiveRule)
    adj.anumber
end

"""Identify degree for `adj`.
$(SIGNATURES)
"""
function gmpDegree(adj::AdjectiveRule)
    adj.adegree
end


"""Identify inflection class for `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::AdjectiveRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::AdjectiveRule)
    rule.ending
end



#=
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
        ending = knormal(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
        d = gmpDegree(parts[7])
        AdjectiveRule(ruleid, inflclass, ending, g,c,n,d)
    end
    
end




"""Compose CEX text for an `AdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::AdjectiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.ruleid, label(adj), ending(adj), inflectionclass(adj), formurn(adj)], delimiter)
    else
        c2urn = expand(adj.ruleid, registry)
        join([c2urn, label(adj),ending(adj), inflectionclass(adj), formurn(adj)], delimiter)
    end
end
=#

"""Compose digital code for morphological form identified in `rule`.
$(SIGNATURES)
"""
function code(rule::AdjectiveRule)
    #PosPNTMVGCDCat
    string(ADJECTIVE,"0",code(rule.anumber),"000",code(rule.agender),code(rule.acase),code(rule.adegree),"0")
end

"""Compose an abbreviated URN for a morphological form identified in `rule`.

$(SIGNATURES)
"""
function formurn(rule::AdjectiveRule)
    FormUrn("$(COLLECTION_ID)." * code(rule) )
end
