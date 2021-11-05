"""Compose FST representation of a single `AdjectiveStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.AdjectiveStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<adjective>",
        "<", stem.inflectionclass, ">"
    )
end


"""Compose FST representation of a single `AdjectiveRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.AdjectiveRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    noaccs = rmaccents(rule.ending, ortho)

    string(
        "<", rule.inflectionclass,"><adjective>", 
        noaccs,
        "<", rule.agender, ">",
        "<", rule.acase, ">",
        "<", rule.anumber, ">",
        "<", rule.adegree, ">",
        fstsafe(rule.ruleid)
    )
end