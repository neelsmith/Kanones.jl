
abstract type KanonesRule <: Rule end


function gmpGender(stem::T) where {T <: KanonesRule}
    @warn "Function gmpGender not implemented for rules of type $(typeof(stem))."
    nothing
end

function gmpCase(rule::T) where {T <: KanonesRule}
    @warn "Function gmpCase not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpNumber(rule::T) where {T <: KanonesRule}
    @warn "Function gmpNumber not implemented for rules of type $(typeof(rule))."
    nothing
end


function gmpPerson(rule::T) where {T <: KanonesRule}
    @warn "Function gmpPerson not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpTense(rule::T) where {T <: KanonesRule}
    @warn "Function gmpTense not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpMood(rule::T) where {T <: KanonesRule}
    @warn "Function gmpMood not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpVoice(rule::T) where {T <: KanonesRule}
    @warn "Function gmpVoice not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpDegree(rule::T) where {T <: KanonesRule}
    @warn "Function gmpDegree not implemented for rules of type $(typeof(rule))."
    nothing
end

function gmpUninflected(rule::T) where {T <: KanonesRule}
    @warn "Function gmpUninflected not implemented for rules of type $(typeof(rule))."
    nothing
end