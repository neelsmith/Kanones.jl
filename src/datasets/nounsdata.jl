"A record for a single noun stem."
struct NounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    gender
    inflectionclass
    accentpersistence
end

"""Identify identifier URN for a `NounStem`.

$(SIGNATURES)
"""
function id(n::NounStem)
    n.stemid
end

"""Identify lexeme URN for a `NounStem`.

$(SIGNATURES)
"""
function lexeme(n::NounStem)
    n.lexid
end

"Inflectional rule for uninflected lexical items."
struct NounRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    inflectionclass
    ending
    ngender
    ncase
    nnumber
end


"""Identify identifier URN for a `NounRule`.

$(SIGNATURES)
"""
function id(n::NounRule)
    n.ruleid
end

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::NounIO, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    gender = parts[4]
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
end

"""Implementation of reading one row of a rules table for uninflected tokens.

$(SIGNATURES) 
"""
function readrulerow(usp::NounIO, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = parts[2]
        ending = nfkc(parts[3])
        g = parts[4]
        c = parts[5]
        n = parts[6]
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end
