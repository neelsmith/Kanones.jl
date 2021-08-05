


"""Compose FST representation of a single `IrregularVerbStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularVerbStem, ortho::T) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<irregular>",
        "<irregularfiniteverb>",
        "<", stem.vperson, ">",
        "<", stem.vnumber, ">",
        "<", stem.vtense, ">",
        "<", stem.vmood, ">",
        "<", stem.vvoice, ">"
    )
    end