


"""Compose FST representation of a single `IrregularNounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularNounStem, ortho::T) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<irregular>",
        "<", stem.inflectionclass, ">",
        "<", stem.gender, ">",
        "<", stem.gcase, ">",
        "<", stem.gnumber, ">"
    )
    
end