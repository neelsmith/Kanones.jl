"A record for a single adjective stem."
struct AdjectiveStem <: KanonesStem
    stemid
    lexid
    form::AbstractString
    inflectionclass
    accentpersistence
end


"""Adjective stems are citable by Cite2Urn"""
CitableTrait(::Type{AdjectiveStem}) = CitableByCite2Urn()

"""Human-readlable label for an `AdjectiveStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(astem::AdjectiveStem)
    string("Adjective stem ", astem.form, "- (type ", astem.inflectionclass, ")")
end

"""Identifying URN for an `AdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::AdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end

"""Compose CEX text for an `AdjectiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::AdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.stemid, label(adj) ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        join([c2urn, label(adj)], delimiter)
    end
end

"""
Read one row of a stems table for adjective tokens and create an `AdjectiveStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::AdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    inflclass = parts[4]
    accent = parts[5]
    AdjectiveStem(stemid,lexid,stem,inflclass,accent)
end

