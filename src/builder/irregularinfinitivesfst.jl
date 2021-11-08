"""Compose FST representation of a single `IrregularVerbStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularInfinitiveStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<irregular>",
        "<irregularinfinitive>",
        "<", label(stem.tense), ">",
        "<", label(stem.voice), ">"
    )
end