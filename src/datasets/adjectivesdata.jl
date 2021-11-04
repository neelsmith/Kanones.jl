"A record for a single adjective stem."
struct AdjectiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    inflectionclass
    accentpersistence
end


"Inflectional rule for adjectives."
struct AdjectiveRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
    ending
    agender
    acase
    anumber
    adegree
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



"""Implementation of reading one row of a rules table for uninflected tokens.

$(SIGNATURES) 
"""
function readrulerow(usp::AdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for adjective rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = nfkc(parts[3])
        g = parts[4]
        c = parts[5]
        n = parts[6]
        d = parts[7]
 
        AdjectiveRule(ruleid, inflclass, ending, g,c,n,d)
    end
    
end