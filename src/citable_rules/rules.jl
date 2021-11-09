
abstract type KanonesRule <: Rule end

function gmpCase(stem::T) where {T <: KanonesRule}
    @warn "Function gmpCase not implemented for rules of type $(typeof(stem))."
    nothing
end