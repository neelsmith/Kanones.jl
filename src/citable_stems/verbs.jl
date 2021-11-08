"""A record for a single uninflected stem.

$(SIGNATURES)
"""
struct VerbStem <: Stem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    stem::AbstractString
    stemclass::AbstractString  
end


"""Verb stems are citable by Cite2Urn"""
CitableTrait(::Type{VerbStem}) = CitableByCite2Urn()

"""Human-readlable label for a `VerbStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vs::VerbStem)
    string("Verb stem ", 
        vs.stem, 
        "- (", 
        vs.lexid, 
        ", ", 
        "stem class ", vs.stemclass, ")")
end


"""Identifying URN for a `VerbStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(vs::VerbStem; registry = nothing)
    if isnothing(registry)
        vs.stemid
    else
        expand(vs.stemid, registry)
    end
end


"""Compose CEX text for a `VerbStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vs::VerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, label(vs) ], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        join([c2urn, label(vs)], delimiter)
    end
end




"""Implementation of reading one row of a stems table for finite verbs.

$(SIGNATURES)
"""
function readstemrow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    stemclass = parts[4]
    VerbStem(stemid,lexid,stem,stemclass)
    # Rule|LexicalEntity|StemClass|Stem|
end
