struct GMPNumber <: GreekMorphologicalProperty
    code::Int64
    function GMPNumber(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpNumber(s::AbstractString)
    s in keys(numbercodes) ? GMPNumber(numbercodes[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

function gmpNumber(code::Int64)
    GMPNumber(code)
end

function code(num::GMPNumber)
    num.code
end

function label(num::GMPNumber)
    numberlabels[num.code]
end


"""Dict mapping codes to labels for number.

$(SIGNATURES)
"""
const numberlabels = Dict(
    1 => "singular",
    2 => "dual",
    3 => "plural"
)



"""Dict mapping labels to codes for number.

$(SIGNATURES)
"""
const numbercodes = Dict(
    "singular" => 1,
    "dual" => 2,
    "plural" => 3
)