struct GMPDegree <: GreekMorphologicalProperty
    code::Int64
    function GMPDegree(code)
        code in keys(degreelabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Override Base.show for a degree property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPDegree)
    print(io, label(prop))
end


"""Construct degree from a string value.
$(SIGNATURES)
"""
function gmpDegree(s::AbstractString)
    s in keys(degreecodedict) ? GMPDegree(degreecodedict[s]) : DomainError(string(s, " is not a valid value for degree.")) 
end



"""Construct degree from an integer code.
$(SIGNATURES)
"""
function gmpDegree(code::Int64)
    GMPDegree(code)
end


"""Integer code for a degree object.
$(SIGNATURES)
"""
function code(degree::GMPDegree)
    degree.code
end


"""Readable label for a degree object.
$(SIGNATURES)
"""
function label(degree::GMPDegree)
    degreelabeldict[degree.code]
end


"""Dictionary mapping codes to labels for degree.

$(SIGNATURES)
"""
const degreelabeldict = Dict(
    1 => "positive",
    2 => "comparative",
    3 => "superlative"
)

"""Dictionary mapping labels to codes for degree.

$(SIGNATURES)
"""
const degreecodedict = Dict(
    "positive" => 1,
    "comparative" => 2,
    "superlative" => 3
)