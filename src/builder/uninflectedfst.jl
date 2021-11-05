"""Compose FST representation of a single `UniflectedStem`.

$(SIGNATURES)
"""
function fst(stem::Kanones.UninflectedStem; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    noaccs = rmaccents(stem.form,ortho)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        fstgreek(noaccs),
        "<uninflected>",
        "<", stem.stemcategory, ">"
    )
end

"""Compose FST representation of a single `UninflectedRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.UninflectedRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}

    string("<", rule.infltype,"><uninflected>", fstsafe(rule.ruleid))
end
