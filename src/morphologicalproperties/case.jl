struct GMPCase <: GreekMorphologicalProperty
    code::Int64
    function GMPCase(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpCase(s::AbstractString)
    s in keys(casecodes) ? GMPCase(casecodes[s]) : DomainError(string(s, " is not a valid value for case.")) 
end

function gmpCase(code::Int64)
    GMPCase(code)
end

function code(mcase::GMPCase)
    mcase.code
end

function label(mcase::GMPCase)
    caselabels[mcase.code]
end

"""Dict mapping codes to labels for case.

$(SIGNATURES)
"""
const caselabels = Dict(
    1 => "nominative",
    2 => "genitive",
    3 => "dative",
    4 => "accusative",
    5 => "vocative"
)

"""Dict mapping labels to codes for case.

$(SIGNATURES)
"""
const casecodes = Dict(
    "nominative" => 1,
    "genitive" => 2,
    "dative" => 3,
    "accusative" => 4,
    "vocative" => 5
)