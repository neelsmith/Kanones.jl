"""Inflectional rule for participial form.

$(SIGNATURES)
"""
struct ParticipleRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
    ending
    ptense
    pvoice
    pgender
    pcase
    pnumber
end

"""Participle rules are citable by Cite2Urn"""
CitableTrait(::Type{ParticipleRule}) = CitableByCite2Urn()


"""Human-readlable label for a `ParticipleRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ptcpl::ParticipleRule)
    string("Participle inflection rule: ending -", ptcpl.ending, " in class ", ptcpl.inflectionclass, " can be ", ptcpl.ptense, " ", ptcpl.pvoice, " ", ptcpl.pgender, " ", ptcpl.pcase, " ", ptcpl.pnumber, ".")
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


"""Compose CEX text for a `VerbalAdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ptcpl::ParticipleRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ptcpl.ruleid, label(ptcpl)], delimiter)
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
        t = parts[4]
        v = parts[5]
        g = parts[6]
        c = parts[7]
        n = parts[8]

        ParticipleRule(ruleid, inflclass, ending,t,v,g,c,n)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end


"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::ParticipleRule)
    numdict = labeldict(numberpairs)
    casedict = labeldict(casepairs)
    genderdict = labeldict(genderpairs)
    tensedict = labeldict(tensepairs)
    voicedict = labeldict(voicepairs)

    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", PARTICIPLE,"0",numdict[rule.pnumber],tensedict[rule.ptense], "0",voicedict[rule.pvoice],genderdict[rule.pgender],casedict[rule.pcase],"00"))
end