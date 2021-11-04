


"""Compose FST representation of a single `IrregularNounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.IrregularNounStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<irregular>",
        #"<", stem.inflectionclass, ">",
        "<irregularnoun>",
        "<", stem.noungender, ">",
        "<", stem.nouncase, ">",
        "<", stem.nounnumber, ">"
    )
    
end