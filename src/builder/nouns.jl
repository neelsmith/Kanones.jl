"A record for a single uninflected stem."
struct NounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    gender
    inflectionclass
    accentpersistence
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


"""Implementation of reading one row of a stems table for noun tokens.
"""
function readstemrow(usp::NounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = parts[3]
    gender = parts[4]
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
end

"""Implementation of reading one row of a rules table for uninflected tokens.
"""
function readrulerow(usp::NounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 7
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = parts[4]
        c = parts[5]
        n = parts[6]
 
        NounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end




"""Compose FST representation of a single NounStem.
"""
function fst(stem::NounStem)

    string(
        Kanones.fstsafe(stem.stemid),
        Kanones.fstsafe(stem.lexid),
        stem.form,
        "<noun>",
        "<", stem.gender, ">",
        "<", stem.inflectionclass, ">"
    )
    
end

"""Compose FST representation of a single NounRule.
"""
function fst(rule::NounRule)
    string()
    #=
    string("<", rule.infltype,"><uninflected>", Kanones.fstsafe(rule.ruleid))
    =#
        #=

<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> 
<u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>
[#stemchars#]+
<noun>
$=gender$ 
$=nounclass$   
<div> 
$=nounclass$  
<noun> 
[#stemchars#]* $=gender$
 $case$ $number$ 
 <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"
    =#
end