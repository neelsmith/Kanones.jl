struct GMPDegree <: GreekMorphologicalProperty
    code::Int64
    function GMPDegree(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpDegree(s::AbstractString)
    s in keys(degreecodes) ? GMPDegree(degreecodes[s]) : DomainError(string(s, " is not a valid value for degree.")) 
end

function gmpDegree(code::Int64)
    GMPDegree(code)
end

function code(degree::GMPDegree)
    degree.code
end

function label(degree::GMPDegree)
    degreelabels[degree.code]
end


"""Dict mapping codes to labels for degree.

$(SIGNATURES)
"""
const degreelabels = Dict(
    1 => "positive",
    2 => "comparative",
    3 => "superlative"
)

"""Dict mapping labels to codes for degree.

$(SIGNATURES)
"""
const degreecodes = Dict(
    "positive" => 1,
    "comparative" => 2,
    "superlative" => 3
)