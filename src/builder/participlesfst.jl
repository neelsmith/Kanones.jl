"""Compose FST representation of a single `ParticipleRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.ParticipleRule, ortho::T) where {T <: GreekOrthography}
    string("<", rule.inflectionclass,"><participle>", 
    rmaccents(rule.ending, ortho),  
    "<", rule.ptense, ">",
    "<", rule.pvoice, ">",
    "<", rule.pgender, ">",
    "<", rule.pcase, ">",
    "<", rule.pnumber, ">",
    fstsafe(rule.ruleid)
    )
end