"A record for a single adjective stem."
struct AdjectiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    inflectionclass
    accentpersistence
end



"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::AdjectiveParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    inflclass = parts[4]
    accent = parts[5]
    AdjectiveStem(stemid,lexid,stem,inflclass,accent)
end