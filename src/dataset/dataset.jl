abstract type Dataset end

function rulesarray(ds::T) where {T <: Dataset}
    @warn("Function rulesarray not implemented for type $(typeof(ds))")
    nothing
end


function stemsarray(ds::T) where {T <: Dataset}
    @warn("Function stemsarray not implemented for type $(typeof(ds))")
    nothing
end


function registry(ds::T) where {T <: Dataset}
    @warn("Function registry not implemented for type $(typeof(ds))")
    nothing
end


function orthography(ds::T) where {T <: Dataset}
    @warn("Function orthography not implemented for type $(typeof(ds))")
    nothing
end
