"""Inflectional rule for participial form.

$(SIGNATURES)
"""
struct ParticipleRule <: KanonesVerbalRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    ptense::GMPTense
    pvoice::GMPVoice
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
end

"""Identify tense property of `rule`.
$(SIGNATURES)
"""
function gmpTense(rule::ParticipleRule)
    rule.ptense
end

"""Identify voice property of `rule`.
$(SIGNATURES)
"""
function gmpVoice(rule::ParticipleRule)
    rule.pvoice
end

"""Identify gender property of `rule`.
$(SIGNATURES)
"""
function gmpGender(rule::ParticipleRule)
    rule.pgender
end

"""Identify case property of `rule`.
$(SIGNATURES)
"""
function gmpCase(rule::ParticipleRule)
    rule.pcase
end

"""Identify number property of `rule`.
$(SIGNATURES)
"""
function gmpNumber(rule::ParticipleRule)
    rule.pnumber
end

"""Participle rules are citable by Cite2Urn"""
CitableTrait(::Type{ParticipleRule}) = CitableByCite2Urn()

"""Human-readlable label for a `ParticipleRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ptcpl::ParticipleRule)
    string("Participle inflection rule: ending -", ptcpl.ending, " in class ", ptcpl.inflectionclass, " can be ", label(ptcpl.ptense), " ", label(ptcpl.pvoice), " ", label(ptcpl.pgender), " ", label(ptcpl.pcase), " ", label(ptcpl.pnumber), ".")
end

"""Identifying URN for a `ParticipleRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ptcpl::ParticipleRule; registry = nothing)
    if isnothing(registry)
        ptcpl.ruleid
    else
        expand(ptcpl.ruleid, registry)
    end
end


"""Identify inflection class for  `rule`
$(SIGNATURES)
"""
function inflectionClass(rule::ParticipleRule)
    rule.inflectionclass
end

"""Identify inflectional ending for  `rule`
$(SIGNATURES)
"""
function ending(rule::ParticipleRule)
    rule.ending
end


"""Compose CEX text for a `VerbalAdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ptcpl::ParticipleRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ptcpl.ruleid, label(ptcpl), ending(ptcpl), inflectionClass(ptcpl), formurn(ptcpl)], delimiter)
    else
        c2urn = expand(ptcpl.ruleid, registry)
        join([c2urn, label(ptcpl)], delimiter)
    end
end




"""Read one row of a rules table for infinitives and create an`ParticipleRule`.

$(SIGNATURES)
"""
function readrulerow(usp::ParticipleIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 5
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        t = gmpTense(parts[4])
        v = gmpVoice(parts[5])
        g = gmpGender(parts[6])
        c = gmpCase(parts[7])
        n = gmpNumber(parts[8])
        ParticipleRule(ruleid, inflclass, ending,t,v,g,c,n)
    end
    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end

"""Compose string of digits for form in `rule`.
$(SIGNATURES)
"""
function code(rule::ParticipleRule)
    # PosPNTMVGCDCat
    string(PARTICIPLE,"0",code(rule.pnumber), code(rule.ptense), "0", code(rule.pvoice), code(rule.pgender), code(rule.pcase),"00")
end

"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::ParticipleRule)
    rule.ruleid
end

"""Compose an abbreviated URN for a rule from an `InfinitiveRule`.

$(SIGNATURES)
"""
function formurn(rule::ParticipleRule)
    # PosPNTMVGCDCat
    FormUrn("$(COLLECTION_ID)." * code(rule))
end