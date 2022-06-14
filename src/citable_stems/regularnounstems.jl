"A record for a single noun stem."
struct NounStem <: KanonesStem
    stemid
    lexid
    form::AbstractString
    gender::GMPGender
    inflectionclass
    accentpersistence
end

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3]) |> lowercase
    gender = gmpGender(parts[4])
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
end

"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{NounStem}) = CitableByCite2Urn()

"""Identify value of stem string for `ns`.
$(SIGNATURES)
"""
function stemstring(ns::NounStem)
    ns.form |> knormal
end

"""Identify lexeme for `ns`.
$(SIGNATURES)
"""
function lexeme(ns::NounStem)
    ns.lexid
end

"""Identify inflection class for `ns`.
$(SIGNATURES)
"""
function inflectionClass(ns::NounStem)
    ns.inflectionclass
end

"""Identify gender of `ns`.
$(SIGNATURES)
"""
function gmpGender(ns::NounStem)
    ns.gender
end

"""Human-readlable label for a `NounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::NounStem)
    string("Noun stem ", ns.form, "- (", label(ns.gender), ")")
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


"""Compose CEX text for a `NounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::NounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ns.stemid, label(ns), stemstring(ns), lexeme(ns), inflectionClass(ns), label(ns.gender), ns.accentpersistence ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        join([c2urn, label(ns), stemstring(ns), lexeme(ns), inflectionClass(ns), label(ns.gender), ns.accentpersistence], delimiter)
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