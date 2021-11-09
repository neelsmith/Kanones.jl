
"Inflectional rule for a noun rule."
struct NounRule <: KanonesRule
    ruleid
    inflectionclass
    ending
    ngender::GMPGender
    ncase::GMPCase
    nnumber::GMPNumber
end

"""Read one row of a rules table for noun tokens,
and create a `NounRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = nfkc(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end

"""Noun rules are citable by Cite2Urn"""
CitableTrait(::Type{NounRule}) = CitableByCite2Urn()


"""Human-readlable label for a `NounRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(nr::NounRule)
    string("Noun inflection rule: ending -", nr.ending, " in class ", nr.inflectionclass, " can be ", label(nr.ngender), " ", label(nr.ncase), " ", label(nr.nnumber), ".")
end


"""Identifying URN for a `NounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(nr::NounRule; registry = nothing)
    if isnothing(registry)
        nr.ruleid
    else
        expand(nr.ruleid, registry)
    end
end


"""Compose CEX text for a `NounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(nr::NounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([nr.ruleid, label(nr)], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([c2urn, label(nr)], delimiter)
    end
end

"""Identifier for a  `NounRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::NounRule)
    n.ruleid
end

"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::NounRule)
    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", NOUN,"0",code(rule.nnumber),"000",code(rule.ngender),code(rule.ncase),"00"))
end

