"A record for a single noun stem."
struct NounStem <: Stem
    stemid
    lexid
    form::AbstractString
    gender
    inflectionclass
    accentpersistence
end

"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{NounStem}) = CitableByCite2Urn()

"""Human-readlable label for a `NounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::NounStem)
    string("Noun stem ", ns.form, "- (", ns.gender, ")")
end

"""Compose CEX text for a `NounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::NounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([label(ns), ns.stemid], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        join([label(ns), c2urn], delimiter)
    end
end


"""Identifying URN for a `NounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::NounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end

"""Identifier for a `NounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::NounStem)
    n.stemid
end

"""Lexeme for a `NounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(n::NounStem)
    n.lexid
end

"Inflectional rule for a noun form."
struct NounRule <: Rule
    ruleid
    inflectionclass
    ending
    ngender
    ncase
    nnumber
end

"""Noun rules are citable by Cite2Urn"""
CitableTrait(::Type{NounRule}) = CitableByCite2Urn()



"""Human-readlable label for a `NounRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(nr::NounRule)
    string("Noun inflection rule: ending -", nr.ending, " in class ", nr.inflectionclass, " can be ", nr.ngender, " ", nr.ncase, " ", nr.nnumber, ".")
end

"""Compose CEX text for a `NounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(nr::NounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([label(nr), nr.ruleid], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([label(nr), c2urn], delimiter)
    end
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



"""Identifier for a  `NounRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::NounRule)
    n.ruleid
end

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    gender = parts[4]
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
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
        g = parts[4]
        c = parts[5]
        n = parts[6]
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end
