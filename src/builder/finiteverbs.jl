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
    parts = split(delimited, delimiter)
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = parts[3]
    stemclass = parts[4]
    FiniteVerbStem(stemid,lexid,stem,stemclass)
    # Rule|LexicalEntity|StemClass|Stem|
end

function readrulerow(usp::VerbParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        
        p = parts[4]
        n = parts[5]
        t = parts[6]
        m = parts[7]
        m = parts[8]

        FiniteVerbRule(ruleid, inflclass, ending,p,n,t,m,v)
    end

    # Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice
end

"""Compose FST representation of a single FiniteVerbStem.
"""
function fst(stem::FiniteVerbStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<finiteverb>",
        "<", stem.stemclass, ">"
    )
end

"""Compose FST representation of a single FiniteVerbRule.
"""
function fst(rule::FiniteVerbRule)
    string("<", rule.stemclass,"><finiteverb>", 
    rule.ending,
    "<", rule.vperson, ">",
    "<", rule.vnumber, ">",
    "<", rule.vtense, ">",
    "<", rule.vmood, ">",
    "<", rule.vvoice, ">",
    fstsafe(rule.ruleid)
    )
end