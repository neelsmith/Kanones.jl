"""Compose FST representation of a single `VerbStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.VerbStem, ortho::T) where {T <: GreekOrthography}
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
function fst(rule::Kanones.FiniteVerbRule, ortho::T) where {T <: GreekOrthography}
    string("<", rule.stemclass,"><finiteverb>", 
    rmaccents(rule.ending, ortho),
    "<", rule.vperson, ">",
    "<", rule.vnumber, ">",
    "<", rule.vtense, ">",
    "<", rule.vmood, ">",
    "<", rule.vvoice, ">",
    fstsafe(rule.ruleid)
    )
end