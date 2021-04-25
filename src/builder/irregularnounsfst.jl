


"""Compose FST representation of a single `IrregularNounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularNounStem, ortho::T) where {T <: GreekOrthography}
    @warn "KANONES IRREG STEM"
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<", stem.gender, ">",
        "<", stem.gcase, ">",
        "<", stem.gnumber, ">",
        "<irregular>",
        "<", stem.inflectionclass, ">"
    )
    
end