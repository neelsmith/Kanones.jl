

"""Compose FST representation of a single `NounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.NounStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<noun>",
        "<", stem.gender, ">",
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
        "<", rule.ngender, ">",
        "<", rule.ncase, ">",
        "<", rule.nnumber, ">",
        fstsafe(rule.ruleid)
    )
end