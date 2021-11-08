

"""Compose FST representation of a single `NounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.NounStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<noun>",
        "<", label(stem.gender), ">",
        "<", stem.inflectionclass, ">"
    )
end

"""Compose FST representation of a single `NounRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.NounRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    noaccs = rmaccents(rule.ending, ortho)

    string(
        "<", rule.inflectionclass,"><noun>", 
        noaccs,
        "<", label(rule.ngender), ">",
        "<", label(rule.ncase), ">",
        "<", label(rule.nnumber), ">",
        fstsafe(rule.ruleid)
    )
end