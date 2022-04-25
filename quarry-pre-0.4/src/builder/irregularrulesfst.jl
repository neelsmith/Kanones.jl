
"""Compose FST representation of a single `UninflectedRule`.

$(SIGNATURES)
"""
function fst(rule::Kanones.IrregularRule; ortho::T = literaryGreek()) where {T <: GreekOrthography}

    string("<", rule.inflectionclass,"><irregular>", fstsafe(rule.ruleid))
end

