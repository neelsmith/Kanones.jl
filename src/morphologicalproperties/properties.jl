"""Abstract type of a morphological form in Kanones."""
abstract type GreekMorphologicalProperty end

function code(gmp::T) where {T <: GreekMorphologicalProperty}
    @warn "Function code not implemented for forms of type $(typeof(gmp))."
    nothing
end

function label(gmp::T) where {T <: GreekMorphologicalProperty}
    @warn "Function label not implemented for forms of type $(typeof(gmp))."
    nothing
end

"""Find voice of a form.

$(SIGNATURES)
"""
function gmpVoice(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpVoice not implemented for forms of type $(typeof(gmf))."
    nothing
end


"""Find voice of a form.

$(SIGNATURES)
"""
function gmpMood(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpMood not implemented for forms of type $typeof(gmf)."
    nothing
end