

"""Compose FST representation of a single `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularAdjectiveStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<irregular>",
        #"<", stem.inflectionclass, ">",
        "<irregularnoun>",
        "<", stem.adjgender, ">",
        "<", stem.adjcase, ">",
        "<", stem.adjnumber, ">",
        "<", stem.adjdegree, ">",
    )
end