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
function readstemrow(usp::VerbParser, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    stemclass = parts[4]
    VerbStem(stemid,lexid,stem,stemclass)
    # Rule|LexicalEntity|StemClass|Stem|
end


"""Read one row of a rules table for verb tokens and create a `FiniteVerbRule`

$(SIGNATURES)
"""
function readrulerow(usp::VerbParser, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        
        p = parts[4]
        n = parts[5]
        t = parts[6]
        m = parts[7]
        v = parts[8]

        FiniteVerbRule(ruleid, inflclass, ending,p,n,t,m,v)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end
