
"Inflectional rule for uninflected lexical items."
struct PronounRule <: Rule
    ruleid::RuleUrn
    pronountype
end

"""
Read one row of a stems table for pronoun tokens and create a `PronounRule`.

$(SIGNATURES)    
"""
function readrulerow(usp::PronounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = RuleUrn(parts[1])
    pronountype = parts[2]
 
    PronounRule(stemid,pronountype)
end