abstract type KanonesStem <: Stem end
abstract type KanonesIrregularStem <: KanonesStem end

function pos(stem::T) where {T <: KanonesStem}
    @warn "Function lexeme not implemented for stems of type $(typeof(stem))."
    nothing
end

function lexeme(stem::T) where {T <: KanonesStem}
    @warn "Function lexeme not implemented for stems of type $(typeof(stem))."
    nothing
end

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


function gmpPerson(stem::T) where {T <: KanonesStem}
    @warn "Function gmpPerson not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpTense(stem::T) where {T <: KanonesStem}
    @warn "Function gmpTense not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpMood(stem::T) where {T <: KanonesStem}
    @warn "Function gmpMood not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpVoice(stem::T) where {T <: KanonesStem}
    @warn "Function gmpVoice not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpDegree(stem::T) where {T <: KanonesStem}
    @warn "Function gmpDegree not implemented for stems of type $(typeof(stem))."
    nothing
end

function gmpUninflected(stem::T) where {T <: KanonesStem}
    @warn "Function gmpUninflected not implemented for stems of type $(typeof(stem))."
    nothing
end