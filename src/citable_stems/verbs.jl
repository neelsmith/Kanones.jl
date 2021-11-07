"""A record for a single uninflected stem.

$(SIGNATURES)
"""
struct VerbStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    stem::AbstractString
    stemclass::AbstractString  
end

"""Inflectional rule for uninflected lexical items.

$(SIGNATURES)
"""
struct FiniteVerbRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    stemclass
    ending
    vperson
    vnumber
    vtense
    vmood
    vvoice
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
