abstract type Dataset end

"""Collect all inflectional rules in `ds`.
$(SIGNATURES)
"""
function rulesarray(ds::T) where {T <: Dataset}
    @warn("Function rulesarray not implemented for type $(typeof(ds))")
    nothing
end

"""Collect all stems in `ds`.
$(SIGNATURES)
"""
function stemsarray(ds::T) where {T <: Dataset}
    @warn("Function stemsarray not implemented for type $(typeof(ds))")
    nothing
end


"""Collect all registered collection identifiers in `ds`.
$(SIGNATURES)
"""
function registry(ds::T) where {T <: Dataset}
    @warn("Function registry not implemented for type $(typeof(ds))")
    nothing
end


"""The orthographic system to use with `ds`.
$(SIGNATURES)
"""
function orthography(ds::T) where {T <: Dataset}
    @warn("Function orthography not implemented for type $(typeof(ds))")
    nothing
end



function validate(ds::T) where {T <: Kanones.Dataset}
    @warn("NOT YET IMPLEMENTED")
end