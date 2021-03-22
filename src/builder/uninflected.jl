
"A record for a single uninflected stem."
struct UninflectedStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    stemcategory::AbstractString
end

function id(uninfl::UninflectedStem)
    uninfl.stemid
end

function lexeme(uninfl::UninflectedStem)
    uninfl.lexid
end

"Inflectional rule for uninflected lexical items."
struct UninflectedRule <: Rule
    ruleid::Kanones.AbbreviatedUrn
    infltype
end


function id(uninfl::UninflectedRule)
    uninfl.ruleid
end

"""Implementation of reading one row of a stems table for uninflected tokens.
"""
function readstemrow(usp::UninflectedParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 4
        msg = "Invalid syntax for uninflected stem: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        stemid = Kanones.StemUrn(parts[1])
        lexid = Kanones.LexemeUrn(parts[2])
        form = fstgreek(parts[3])
        stemclass = parts[4]
        UninflectedStem(stemid, lexid, form, stemclass)
    end
end

"""Implementation of reading one row of a rules table for uninflected tokens.
"""
function readrulerow(usp::UninflectedParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for uninflected rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflectionaltype = parts[2]
        UninflectedRule(ruleid, inflectionaltype)
    end
end


"""Compose FST representation of a single UniflectedStem.
"""
function fst(stem::UninflectedStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<uninflected>",
        "<", stem.stemcategory, ">"
    )
end

"""Compose FST representation of a single UninflectedRule.
"""
function fst(rule::UninflectedRule)
    string("<", rule.infltype,"><uninflected>", fstsafe(rule.ruleid))
end
