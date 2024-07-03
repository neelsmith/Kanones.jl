"""Inflectional rule for a verbal adjective.

$(SIGNATURES)
"""
struct VerbalAdjectiveRule <: KanonesVerbalRule
    ruleid::AbbreviatedUrn
    inflectionclass
    ending
    vagender::GMPGender
    vacase::GMPCase
    vanumber::GMPNumber
end



function show(io::IO, adj::VerbalAdjectiveRule)
    print(io, label(adj))
end

function ==(v1::VerbalAdjectiveRule, v2::VerbalAdjectiveRule)
    v1.ruleid == v2.ruleid &&
    v1.inflectionclass == v2.inflectionclass &&
    v1.ending == v2.ending &&
    v1.vagender == v2.vagender && 
    v1.vanumber == v2.vanumber && 
    v1.vacase  == v2.vacase
end



"""Verbal adjective rules are citable by Cite2Urn"""
CitableTrait(::Type{VerbalAdjectiveRule}) = CitableByCite2Urn()
function citabletrait(::Type{VerbalAdjectiveRule})
    CitableByCite2Urn()
end


"""Human-readlable label for a `VerbalAdjectiveRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vadj::VerbalAdjectiveRule)
    string("Verbal adjective inflection rule: ending -", vadj.ending, " in class ", vadj.inflectionclass, " can be ", label(vadj.vagender), " ", label(vadj.vacase), " ", label(vadj.vanumber), ".")
end

"""Identifying URN for a `VerbalAdjectiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(vadj::VerbalAdjectiveRule; registry = nothing)
    if isnothing(registry)
        vadj.ruleid
    else
        expand(vadj.ruleid, registry)
    end
end

struct VerbalAdjectiveRuleCex <: CexTrait end
function cextrait(::Type{VerbalAdjectiveRule})  
    VerbalAdjectiveRuleCex()
end

"""Compose CEX text for a `VerbalAdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vadj::VerbalAdjectiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vadj.ruleid, inflectionclass(vadj), ending(vadj), 
        label(gmpGender(vadj)),
        label(gmpCase(vadj)),
        label(gmpNumber(vadj))
        
        ], delimiter)
    else
        c2urn = expand(vadj.ruleid, registry)
        join([c2urn, label(vadj), ending(vadj), inflectionclass(vadj), formurn(vadj)], delimiter)
    end
end


function fromcex(traitvalue::VerbalAdjectiveRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

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


"""Identify inflection class for `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::VerbalAdjectiveRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::VerbalAdjectiveRule)
    rule.ending
end



"""Identifying `RuleUrn` for a `VerbalAdjectiveRule`. 
$(SIGNATURES)
"""
function ruleurn(vadj::VerbalAdjectiveRule)
    vadj.ruleid
end

function gmpGender(va::VerbalAdjectiveRule)
    va.vagender
end

function gmpCase(va::VerbalAdjectiveRule)
    va.vacase
end


function gmpNumber(va::VerbalAdjectiveRule)
    va.vanumber
end



function code(rule::VerbalAdjectiveRule)
    string(VERBALADJECTIVE,"0",code(rule.vanumber),"000",code(rule.vagender),code(rule.vacase),"00")
end

"""Compose an abbreviated URN for a rule from a `VerbalAdjectiveRule`.

$(SIGNATURES)
"""
function formurn(rule::VerbalAdjectiveRule)
    FormUrn("$(COLLECTION_ID)." * code(rule))
end
