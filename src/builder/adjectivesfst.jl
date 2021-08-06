"""Compose FST representation of a single `AdjectiveStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.AdjectiveStem, ortho::T) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<adjective>",
        "<", stem.inflectionclass, ">"
    )
end