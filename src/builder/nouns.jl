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
