"""Compose FST representation of a single `VerbStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.VerbStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        string("<stem>", stem.stem),
        "<finiteverb>",
        "<", stem.stemclass, ">"
    )
end

"""Compose FST representation of a single `VerbRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.FiniteVerbRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string("<", rule.stemclass,"><finiteverb>", 
    rmaccents(rule.ending, ortho),
    "<", label(rule.vperson), ">",
    "<", label(rule.vnumber), ">",
    "<", label(rule.vtense), ">",
    "<", label(rule.vmood), ">",
    "<", label(rule.vvoice), ">",
    fstsafe(rule.ruleid)
    )
end