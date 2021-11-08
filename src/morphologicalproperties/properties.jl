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

"""Find tense of a form.

$(SIGNATURES)
"""
function gmpTense(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpTense not implemented for forms of type $typeof(gmf)."
    nothing
end

"""Find mood of a form.

$(SIGNATURES)
"""
function gmpMood(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpMood not implemented for forms of type $typeof(gmf)."
    nothing
end


"""Find voice of a form.

$(SIGNATURES)
"""
function gmpVoice(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpVoice not implemented for forms of type $(typeof(gmf))."
    nothing
end


"""Find person of a form.

$(SIGNATURES)
"""
function gmpPerson(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpPerson not implemented for forms of type $(typeof(gmf))."
    nothing
end


"""Find number of a form.

$(SIGNATURES)
"""
function gmpNumber(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpNumber not implemented for forms of type $(typeof(gmf))."
    nothing
end



"""Find gender of a form.

$(SIGNATURES)
"""
function gmpGender(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpGender not implemented for forms of type $(typeof(gmf))."
    nothing
end

"""Find case of a form.

$(SIGNATURES)
"""
function gmpCase(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpCase not implemented for forms of type $(typeof(gmf))."
    nothing
end

"""Find degree of a form.

$(SIGNATURES)
"""
function gmpDegree(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpDegree not implemented for forms of type $(typeof(gmf))."
    nothing
end

"""Find part of speech of an uninflected form.

$(SIGNATURES)
"""
function gmpUninflectedType(gmf::T) where {T <: GreekMorphologicalForm}
    @warn "Function gmpUninflectedType not implemented for forms of type $(typeof(gmf))."
    nothing
end