"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct FiniteVerbRule <: KanonesVerbalRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    vperson::GMPPerson
    vnumber::GMPNumber
    vtense::GMPTense
    vmood::GMPMood
    vvoice::GMPVoice
end


function show(io::IO, adj::FiniteVerbRule)
    print(io, label(adj))
end

function ==(v1::FiniteVerbRule, v2::FiniteVerbRule)
    v1.ruleid == v2.ruleid &&
    v1.inflectionclass == v2.inflectionclass &&
    v1.ending == v2.ending &&
    v1.vperson == v2.vperson && 
    v1.vnumber == v2.vnumber && 
    v1.vtense  == v2.vtense &&
    v1.vmood == v2.vmood &&
    v1.vvoice == v2.vvoice
end

"""Finite verb rules are citable by Cite2Urn"""
CitableTrait(::Type{FiniteVerbRule}) = CitableByCite2Urn()
function citabletrait(::Type{FiniteVerbRule})
    CitableByCite2Urn()
end


"""Human-readlable label for a `FiniteVerbRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(verb::FiniteVerbRule)
    string("Verb inflection rule: ending -", ending(verb), " in class ", inflectionclass(verb), " can be ", label(verb.vtense), " ", label(verb.vmood), " ", label(verb.vvoice), " ", label(verb.vperson)," ", label(verb.vnumber), ".")
end

"""Identifying URN for a `FiniteVerbRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(verb::FiniteVerbRule; registry = nothing)
    if isnothing(registry)
        verb.ruleid
    else
        expand(verb.ruleid, registry)
    end
end





struct FiniteVerbRuleCex <: CexTrait end
function cextrait(::Type{FiniteVerbRule})  
    FiniteVerbRuleCex()
end

"""Compose CEX text for a `FiniteVerbRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(verb::FiniteVerbRule; delimiter = "|", registry = nothing)
    @info("Serialize $(verb)")
    if isnothing(registry)
        join([verb.ruleid, verb.inflectionclass, ending(verb), 
        label(gmpPerson(verb)),
        label(gmpNumber(verb)),
        label(gmpTense(verb)), 
        label(gmpMood(verb)),
        label(gmpVoice(verb))
        ], 
        delimiter)
    else
        c2urn = expand(inf.ruleid, registry)
        join([c2urn, inf.inflectionclass, ending(inf), label(gmpTense(inf)), label(gmpVoice(inf))], delimiter)
    end
    #=
    if isnothing(registry)
        join([verb.ruleid, label(verb), ending(verb), inflectionclass(verb), formurn(verb)], delimiter)
    else
        c2urn = expand(verb.ruleid, registry)
        join([c2urn, label(verb), ending(verb), inflectionclass(verb), formurn(verb)], delimiter)
    end =#
end


function fromcex(traitvalue::FiniteVerbRuleCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        @warn(msg)
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
end


"""Find person property for `rule`.
$(SIGNATURES)
"""
function gmpPerson(rule::FiniteVerbRule)
    rule.vperson
end


"""Find number property for `rule`.
$(SIGNATURES)
"""
function gmpNumber(rule::FiniteVerbRule)
    rule.vnumber
end


"""Find tense property for `rule`.
$(SIGNATURES)
"""
function gmpTense(rule::FiniteVerbRule)
    rule.vtense
end


"""Find mood property for `rule`.
$(SIGNATURES)
"""
function gmpMood(rule::FiniteVerbRule)
    rule.vmood
end


"""Find voice property for `rule`.
$(SIGNATURES)
"""
function gmpVoice(rule::FiniteVerbRule)
    rule.vvoice
end





"""Identify inflection class for  `vr`
$(SIGNATURES)
"""
function inflectionclass(vr::FiniteVerbRule)
    vr.inflectionclass
end

"""Identify inflectional ending for  `vr`
$(SIGNATURES)
"""
function ending(vr::FiniteVerbRule)
    vr.ending
end





"""Compose a `FormUrn` for `rule`.
$(SIGNATURES)
"""
function ruleurn(rule::FiniteVerbRule)
    rule.ruleid
end


#=

"""Read one row of a rules table for verb tokens and create a `FiniteVerbRule`

$(SIGNATURES)
"""
function readrulerow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        @warn(msg)
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

=#

"""Compose a digital code string for the form identified in `rule`.
$(SIGNATURES)
"""
function code(rule::FiniteVerbRule)
      # PosPNTMVGCDCat
      string(FINITEVERB,
        code(rule.vperson),
        code(rule.vnumber),
        code(rule.vtense),
        code(rule.vmood),
        code(rule.vvoice),
        "0000")
end

"""Compose an abbreviated URN for a rule from a `FiniteVerbRule`.

$(SIGNATURES)
"""
function formurn(rule::FiniteVerbRule)
    FormUrn("$(COLLECTION_ID)." * code(rule))
end

"""True if rule `r` is an irregular form from a verbal stem.
$(SIGNATURES)
"""
function irregularverbalrule(r::Rule)
    infclass =   inflectionclass(r)
    infclass == "irregularfiniteverb" ||
    infclass == "irregularinfinitive" ||
    infclass == "irregularparticiple" ||
    infclass == "irregularverbaladjective"
    
end


"""True if rule `r` is a form from a verbal stem.
$(SIGNATURES)
"""
function verbalrule(r::Rule)
    typeof(r) <: KanonesVerbalRule || irregularverbalrule(r) 
end