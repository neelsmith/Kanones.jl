"""Compose FST representation of a single `UniflectedStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.UninflectedStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        fstgreek(stem.form),
        "<uninflected>",
        "<", stem.stemcategory, ">"
    )
end

"""Compose FST representation of a single `UninflectedRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.UninflectedRule)
    string("<", rule.infltype,"><uninflected>", fstsafe(rule.ruleid))
end
