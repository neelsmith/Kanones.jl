"""Inflectional rule for infinitive verb form.

$(SIGNATURES)
"""
struct InfinitiveRule <: KanonesVerbalRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    tense::GMPTense
    voice::GMPVoice
end



function show(io::IO, adj::InfinitiveRule)
    print(io, label(adj))
end

function ==(v1::InfinitiveRule, v2::InfinitiveRule)
    v1.ruleid == v2.ruleid &&
    v1.inflectionclass == v2.inflectionclass &&
    v1.ending == v2.ending &&
    v1.tense  == v2.tense &&
    v1.voice == v2.voice
end


"""Finite verb rules are citable by Cite2Urn"""
CitableTrait(::Type{InfinitiveRule}) = CitableByCite2Urn()
function citabletrait(::Type{InfinitiveRule})
    CitableByCite2Urn()
end

"""Human-readlable label for an `InfinitiveRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(inf::InfinitiveRule)
    string("Infinitive inflection rule: ending -", inf.ending, " in class ", inf.inflectionclass, " can be ", label(inf.tense), " ", label(inf.voice), ".")
end


"""Identifying URN for an `InfinitiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(inf::InfinitiveRule; registry = nothing)
    if isnothing(registry)
        inf.ruleid
    else
        expand(inf.ruleid, registry)
    end
end




struct InfinitiveRuleCex <: CexTrait end
function cextrait(::Type{InfinitiveRule})  
    InfinitiveRuleCex()
end

"""Compose CEX text for a `InfinitiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(inf::InfinitiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([inf.ruleid, inf.inflectionclass, ending(inf), label(gmpTense(inf)), label(gmpVoice(inf))], delimiter)
    else
        c2urn = expand(inf.ruleid, registry)
        join([c2urn, inf.inflectionclass, ending(inf), label(gmpTense(inf)), label(gmpVoice(inf))], delimiter)
    end
end



function fromcex(traitvalue::InfinitiveRuleCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    @debug("Make infin from $(parts)")
    if length(parts) < 5
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        
        t = gmpTense(parts[4])
        @debug("Tense is $(t)")
        v = gmpVoice(parts[5])
        @debug("Found all the pieces for an infin")
        InfinitiveRule(ruleid, inflclass, ending,t,v)
    end
end



"""Find tense property of `inf`.
$(SIGNATURES)
"""
function gmpTense(inf::InfinitiveRule)
    inf.tense
end

"""Find voice property of `inf`.
$(SIGNATURES)
"""
function gmpVoice(inf::InfinitiveRule)
    inf.voice
end



"""Identify inflection class for  `rule`
$(SIGNATURES)
"""
function inflectionclass(rule::InfinitiveRule)
    rule.inflectionclass
end

"""Identify inflectional ending for  `rule`
$(SIGNATURES)
"""
function ending(rule::InfinitiveRule)
    rule.ending
end



#=
"""Read one row of a rules table for infinitives and create an `InfinitiveRule`.

$(SIGNATURES)
"""
function readrulerow(infio::InfinitiveIO, delimited::AbstractString; delimiter = "|")
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

        InfinitiveRule(ruleid, inflclass, ending,t,v)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end
=#


"""Compose digital code for morphological form identified in `rule`.
$(SIGNATURES)
"""
function code(rule::InfinitiveRule)
    #PosPNTMVGCDCat
    string(INFINITIVE,"00",code(rule.tense),"0",code(rule.voice),"0000")
end

"""Compose an abbreviated URN for a rule from an `InfinitiveRule`.

$(SIGNATURES)
"""
function formurn(rule::InfinitiveRule)
    # PosPNTMVGCDCat
    FormUrn("$(COLLECTION_ID)." * code(rule))
end



"""Identify `rule` with a `RuleUrn`.
$(SIGNATURES)
"""
function ruleurn(rule::InfinitiveRule)
    rule.ruleid
end