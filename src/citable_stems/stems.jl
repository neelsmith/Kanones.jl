abstract type KanonesStem <: Stem end

function gmpGender(stem::T) where {T <: KanonesStem}
    @warn "Function gmpGender not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpCase(stem::T) where {T <: KanonesStem}
    @warn "Function gmpCase not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpNumber(stem::T) where {T <: KanonesStem}
    @warn "Function gmpNumber not implemented for stems of type $(typeof(stem))."
    nothing
end