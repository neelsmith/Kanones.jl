"""Compose FST representation of a single `VerbStem`.

$(SIGNATURES)
"""
function fst(stem::FiniteVerbStem, ortho::T) where {T <: GreekOGreekOrthographyrtho}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<finiteverb>",
        "<", stem.stemclass, ">"
    )
end

"""Compose FST representation of a single `VerbRule`.

$(SIGNATURES)
"""
function fst(rule::FiniteVerbRule, ortho::T) where {T <: GreekOrthography}
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