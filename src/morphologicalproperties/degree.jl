struct GMPDegree <: GreekMorphologicalProperty
    code::Int64
    function GMPDegree(code)
        code in keys(degreelabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

function gmpDegree(s::AbstractString)
    s in keys(degreecodedict) ? GMPDegree(degreecodedict[s]) : DomainError(string(s, " is not a valid value for degree.")) 
end

function gmpDegree(code::Int64)
    GMPDegree(code)
end

function code(degree::GMPDegree)
    degree.code
end

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