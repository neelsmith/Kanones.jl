
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