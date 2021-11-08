"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct FiniteVerbRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    stemclass
    ending
    vperson::GMPPerson
    vnumber::GMPNumber
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
end


"""Finite verb rules are citable by Cite2Urn"""
CitableTrait(::Type{FiniteVerbRule}) = CitableByCite2Urn()

"""Human-readlable label for a `FiniteVerbRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(verb::FiniteVerbRule)
    string("Verb inflection rule: ending -", verb.ending, " in class ", verb.stemclass, " can be ", label(verb.vtense), " ", label(verb.vmood), " ", label(verb.vvoice), " ", label(verb.vperson)," ", label(verb.vnumber), ".")
end

"""Identifying URN for a `FiniteVerbRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(verb::FiniteVerbRule; registry = nothing)
    if isnothing(registry)
        verb.ruleid
    else
        expand(verb.ruleid, registry)
    end
end


"""Compose CEX text for a `FiniteVerbRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(verb::FiniteVerbRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([verb.ruleid, label(verb)], delimiter)
    else
        c2urn = expand(verb.ruleid, registry)
        join([c2urn, label(verb)], delimiter)
    end
end

function ruleurn(rule::FiniteVerbRule)
    # PosPNTMVGCDCat
    RuleUrn(string("morphforms.", FINITEVERB,
    code(rule.vperson),
    code(rule.vnumber),
    code(rule.vtense),
    code(rule.vmood),
    code(rule.vvoice),
    "0000"))
end



"""Read one row of a rules table for verb tokens and create a `FiniteVerbRule`

$(SIGNATURES)
"""
function readrulerow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        
        p = gmpPerson(parts[4])
        n = gmpNumber(parts[5])
        t = gmpTense(parts[6])
        m = gmpMood(parts[7])
        v = gmpVoice(parts[8])

        FiniteVerbRule(ruleid, inflclass, ending,p,n,t,m,v)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end