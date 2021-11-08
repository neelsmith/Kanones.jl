"""Compose FST representation of a single `ParticipleRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.ParticipleRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string("<", rule.inflectionclass,"><participle>", 
    rmaccents(rule.ending, ortho),  
    "<", label(rule.ptense), ">",
    "<", label(rule.pvoice), ">",
    "<", label(rule.pgender), ">",
    "<", label(rule.pcase), ">",
    "<", label(rule.pnumber), ">",
    fstsafe(rule.ruleid)
    )
end