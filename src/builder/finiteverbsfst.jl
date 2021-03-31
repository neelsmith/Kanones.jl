"""Compose FST representation of a single `VerbStem`.

$(SIGNATURES)
"""
function fst(stem::FiniteVerbStem)
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
function fst(rule::FiniteVerbRule)
    string("<", rule.stemclass,"><finiteverb>", 
    rule.ending,
    "<", rule.vperson, ">",
    "<", rule.vnumber, ">",
    "<", rule.vtense, ">",
    "<", rule.vmood, ">",
    "<", rule.vvoice, ">",
    fstsafe(rule.ruleid)
    )
end