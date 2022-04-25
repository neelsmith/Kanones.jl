

"""Compose FST representation of a single `PronounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.PronounStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        rmaccents(stem.form, ortho),
        "<pronoun>",
        "<", label(stem.pgender), ">",
        "<", label(stem.pcase), ">",
        "<", label(stem.pnumber), ">",
        "<", stem.pronountype, ">"
    )
end



"""Compose FST representation of a single `PronounRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.PronounRule; ortho::T =  literaryGreek()) where {T <: GreekOrthography}
    string(
        "<", rule.pronountype, ">",
        "<pronoun>",
        fstsafe(rule.ruleid)
    )
end
