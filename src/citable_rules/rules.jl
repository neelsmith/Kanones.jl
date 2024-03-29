abstract type KanonesRule <: Rule end
abstract type KanonesVerbalRule <: KanonesRule end

const REGULAR_VERB_CLASSES = [
    "w_regular",
    "w_dep",
    "numi",

    "izw",
    "izw_dep",

    "skw",
    "skw_dep",

    "ew_contract",
    "aw_contract",
    "ow_contract",

    "ew_contract_dep",
    "aw_contract_dep",
    "ow_contract_dep"
]

const CONTRACT_CLASSES = [
   
    "ew_contract",
    "aw_contract",
    "ow_contract",

    "ew_contract_dep",
    "aw_contract_dep",
    "ow_contract_dep"
]

"""Extract gender property from a `KanonesRule`.
$(SIGNATURES)
"""
function inflectionclass(rule::T) where {T <: KanonesRule}
    @warn "Function inflectionclass not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Extract gender property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpGender(stem::T) where {T <: KanonesRule}
    @warn "Function gmpGender not implemented for rules of type $(typeof(stem))."
    nothing
end

"""Extract case property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpCase(rule::T) where {T <: KanonesRule}
    @warn "Function gmpCase not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Extract number property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpNumber(rule::T) where {T <: KanonesRule}
    @warn "Function gmpNumber not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Extract person property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpPerson(rule::T) where {T <: KanonesRule}
    @warn "Function gmpPerson not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Extract tense property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpTense(rule::T) where {T <: KanonesRule}
    @warn "Function gmpTense not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Extract mood property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpMood(rule::T) where {T <: KanonesRule}
    @warn "Function gmpMood not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Extract voice property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpVoice(rule::T) where {T <: KanonesRule}
    @warn "Function gmpVoice not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Extract degree property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpDegree(rule::T) where {T <: KanonesRule}
    @warn "Function gmpDegree not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Extract uninflected part of speech property from a `KanonesRule`.
$(SIGNATURES)
"""
function gmpUninflected(rule::T) where {T <: KanonesRule}
    @warn "Function gmpUninflected not implemented for rules of type $(typeof(rule))."
    nothing
end