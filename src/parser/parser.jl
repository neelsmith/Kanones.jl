"""Abstract type of a morphological parser."""
abstract type KanonesParser <: CitableParser end

"""Parse a single token `s` using parser `p`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, p::T) where {T <: KanonesParser}
    @warn("Function parsetoken is not implemented for type $(typeof(p))")::Vector{Analysis}
    []
end
