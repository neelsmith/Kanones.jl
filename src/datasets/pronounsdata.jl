"A record for a single noun stem."
struct PronounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    pgender
    pcase
    pnumber
    pronountype
end
#pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article


"Inflectional rule for uninflected lexical items."
struct PronounRule <: Rule
    ruleid::RuleUrn
    pronountype
end

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::PronounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    gndr = parts[4]
    cs = parts[5]
    nmbr = parts[6]
    inflclass = parts[7]
 
    PronounStem(stemid,lexid,stem,gndr, cs, nmbr,inflclass)
end



"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readrulerow(usp::PronounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = Kanones.RuleUrn(parts[1])
    pronountype = parts[2]
 
    PronounRule(stemid,pronountype)
end