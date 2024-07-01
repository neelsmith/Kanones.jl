
"Inflectional rule for a noun rule."
struct NounRule <: KanonesRule
    ruleid
    inflectionclass
    ending
    ngender::GMPGender
    ncase::GMPCase
    nnumber::GMPNumber
end


function show(io::IO, noun::NounRule)
    print(io, label(noun))
end

function ==(n1::NounRule, n2::NounRule)
    n1.ruleid == n2.ruleid &&
    n1.inflectionclass == n2.inflectionclass &&
    n1.ending == n2.ending &&
    n1.agender == n2.agender && 
    n1.acase == n2.acase && 
    n1.anumber  == n2.anumber
end



"""Noun rules are citable by Cite2Urn"""
CitableTrait(::Type{NounRule}) = CitableByCite2Urn()
function citabletrait(::Type{NounRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `NounRule`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(nr::NounRule)
    string("Noun inflection rule: ending -", nr.ending, " in class ", nr.inflectionclass, " can be ", label(nr.ngender), " ", label(nr.ncase), " ", label(nr.nnumber), ".")
end


"""Identifying URN for a `NounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(nr::NounRule; registry = nothing)
    if isnothing(registry)
        nr.ruleid
    else
        expand(nr.ruleid, registry)
    end
end



struct NounRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{NounRule})  
    NounRuleCex()
end

"""Compose CEX text for a `NounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(nr::NounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([nr.ruleid, inflectionclass(nr), ending(nr), label(gmpGender(nr)), label(gmpCase(nr)), label(gmpNumber(nr))], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([c2urn,  inflectionclass(nr), ending(nr), label(gmpGender(nr)), label(gmpCase(nr)), label(gmpNumber(nr))], delimiter)
    end
end

function fromcex(traitvalue::NounRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 6
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = knormal(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
end

"""Identify inflection class for  `nr`
$(SIGNATURES)
"""
function inflectionclass(nr::NounRule)
    nr.inflectionclass
end

"""Identify inflectional ending for  `nr`
$(SIGNATURES)
"""
function ending(nr::NounRule)
    nr.ending
end

"""Identify gender property for `nr`.
$(SIGNATURES)
"""
function gmpGender(nr::NounRule)
    nr.ngender
end


"""Identify case property for `nr`.
$(SIGNATURES)
"""
function gmpCase(nr::NounRule)
    nr.ncase
end


"""Identify number property for `nr`.
$(SIGNATURES)
"""
function gmpNumber(nr::NounRule)
    nr.nnumber
end

#=
"""Read one row of a rules table for noun tokens,
and create a `NounRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    @debug(parts)
    if length(parts) < 6
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = knormal(parts[3])
        g = gmpGender(parts[4])
        c = gmpCase(parts[5])
        n = gmpNumber(parts[6])
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end
=#




"""Identifier for a  `NounRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function ruleurn(n::NounRule)
    n.ruleid
end


"""Compose a digital code string for the form identified in `rule`.
$(SIGNATURES)
"""
function code(rule::NounRule)
      # PosPNTMVGCDCat
     string( NOUN,"0",code(rule.nnumber),"000",code(rule.ngender),code(rule.ncase),"00")
end


"""Compose an abbreviated URN for a rule from a `NounRule`.

$(SIGNATURES)
"""
function formurn(rule::NounRule)
    FormUrn("$(COLLECTION_ID)." * code(rule))
end

