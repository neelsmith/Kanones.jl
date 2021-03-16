"A record for a single uninflected stem."
struct FiniteVerbStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    stem::AbstractString
    stemclass::AbstractString  
end

"Inflectional rule for uninflected lexical items."
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

function readstemrow(usp::VerbParser, delimited::AbstractString, delimiter = "|")
end
function readrulerow(usp::VerbParser, delimited::AbstractString, delimiter = "|")
end

"""Compose FST representation of a single FiniteVerbStem.
"""
function fst(stem::FiniteVerbStem)
end

"""Compose FST representation of a single NounRule.
"""
function fst(rule::FiniteVerbRule)
end