"""Compose FST representation of a single `InfinitiveRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.VerbalAdjectiveRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    string("<", rule.inflectionclass,"><verbaladjective>", 
    rmaccents(rule.ending, ortho),  
    "<", rule.vagender, ">",
    "<", rule.vacase, ">",
    "<", rule.vanumber, ">",
    fstsafe(rule.ruleid)
    )
end