"""Inflectional rule for a verbal adjective.

$(SIGNATURES)
"""
struct VerbalAdjectiveRule <: KanonesRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    vagender::GMPGender
    vacase::GMPCase
    vanumber::GMPNumber
end


"""Verbal adjective rules are citable by Cite2Urn"""
CitableTrait(::Type{VerbalAdjectiveRule}) = CitableByCite2Urn()

"""Human-readlable label for a `VerbalAdjectiveRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vadj::VerbalAdjectiveRule)
    string("Verbal adjective inflection rule: ending -", vadj.ending, " in class ", vadj.inflectionclass, " can be ", label(vadj.vagender), " ", label(vadj.vacase), " ", label(vadj.vanumber), ".")
end

"""Identifying URN for a `VerbalAdjectiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(vadj::VerbalAdjectiveRule; registry = nothing)
    if isnothing(registry)
        vadj.ruleid
    else
        expand(vadj.ruleid, registry)
    end
end


"""Compose CEX text for a `VerbalAdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vadj::VerbalAdjectiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vadj.ruleid, label(vadj)], delimiter)
    else
        c2urn = expand(vadj.ruleid, registry)
        join([c2urn, label(vadj)], delimiter)
    end
end

"""Read one row of a rules table for infinitives and create an `InfinitiveRule`.

$(SIGNATURES)
"""
function readrulerow(usp::VerbalAdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 6
        msg = "Invalid syntax for verbal adjective: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])

        VerbalAdjectiveRule(ruleid, inflclass, ending,g,c,n)
    end

end

"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::VerbalAdjectiveRule)
    # PosPNTMVGCDCat
    RuleUrn(string("$(COLLECTION_ID).", VERBALADJECTIVE,"0",code(rule.vanumber),"000",code(rule.vagender),code(rule.vacase),"00"))
end
