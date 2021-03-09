"Implementations of this type can read delimited and write fst."
abstract type KanonesIO end



"KanonesIO type for reading and writing stem data for uninflected stems."
struct UninflectedStemParser <: KanonesIO
    label::AbstractString
end

#=
"Convenience function to create an `UninflectedStemParser`"
function uninflectedstemparser()
    UninflectedStemParser("KanonesIO type for reading and writing stem and rule data for uninflected lexical items.")
end
=#

"A record for a single uninflected stem."
struct UninflectedStem <: Kanones.StemType
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    stemclass
end

"Inflectional rule for uninflected lexical items."
struct UninflectedRule <: Kanones.RuleType
    ruleid::AbbreviatedUrn
    infltype
end

function readstemrow(usp::UninflectedStemParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 4
        msg = "Invalid syntax for uninflected stem: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        stemid = StemUrn(parts[1])
        lexid = StemUrn(parts[2])
        form = fstgreek(parts[3])
        stemclass = parts[4]
        UninflectedStem(stemid, lexid, form, stemclass)
    end
end


function fst(stem::UninflectedStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<uninflected>",
        "<", stem.stemclass, ">"
    )
end


function readrulerow(usp::UninflectedStemParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for uninflected rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        UninflectedRule(ruleid, inflectionaltype)
    end
    
end

function fst(rule::UninflectedRule)
    string("<", rule.infltype,"><uninflected>", fstsafe(rule.ruleid))
end
