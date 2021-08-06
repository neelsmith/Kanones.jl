

"""Compose FST representation of a single `PronounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.PronounStem, ortho::T) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<pronoun>",
        "<", stem.pgender, ">",
        "<", stem.pcase, ">",
        "<", stem.pnumber, ">",
        "<", stem.pronountype, ">"
    )
end



"""Compose FST representation of a single `PronounRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.PronounRule, ortho::T) where {T <: GreekOrthography}
    string(
        "<", rule.pronountype, ">",
        "<pronoun>",
        fstsafe(rule.ruleid)
    )
end
