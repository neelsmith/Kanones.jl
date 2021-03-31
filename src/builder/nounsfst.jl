

"""Compose FST representation of a single `NounStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.NounStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<noun>",
        "<", stem.gender, ">",
        "<", stem.inflectionclass, ">"
    )
    
end

"""Compose FST representation of a single `NounRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.NounRule)
    string(
        "<", rule.inflectionclass,"><noun>", 
        rule.ending,
        "<", rule.ngender, ">",
        "<", rule.ncase, ">",
        "<", rule.nnumber, ">",
        fstsafe(rule.ruleid)
    )
end