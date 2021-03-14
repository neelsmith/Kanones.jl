"A record for a single uninflected stem."
struct NounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    gender
    inflectionclass
    accent
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
    #=
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
    =#
end

"""Implementation of reading one row of a rules table for uninflected tokens.
"""
function readrulerow(usp::NounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    #=
    if length(parts) < 2
        msg = "Invalid syntax for uninflected rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = Kanones.RuleUrn(parts[1])
        inflectionaltype = parts[2]
        UninflectedRule(ruleid, inflectionaltype)
    end
    =#
end




"""Compose FST representation of a single NounStem.
"""
function fst(stem::NounStem)
    #=
    string(
        Kanones.fstsafe(stem.stemid),
        Kanones.fstsafe(stem.lexid),
        stem.form,
        "<uninflected>",
        "<", stem.stemcategory, ">"
    )
    =#
end

"""Compose FST representation of a single NounRule.
"""
function fst(rule::NounRule)
    #=
    string("<", rule.infltype,"><uninflected>", Kanones.fstsafe(rule.ruleid))
    =#
end