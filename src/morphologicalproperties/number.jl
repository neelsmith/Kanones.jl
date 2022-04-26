struct GMPNumber <: GreekMorphologicalProperty
    code::Int64
    function GMPNumber(code)
        code in keys(numberlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

function gmpNumber(s::AbstractString)
    s in keys(numbercodedict) ? GMPNumber(numbercodedict[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

function gmpNumber(code::Int64)
    GMPNumber(code)
end

function code(num::GMPNumber)
    num.code
end

function label(num::GMPNumber)
    numberlabeldict[num.code]
end


"""Dict mapping codes to labels for number.

$(SIGNATURES)
"""
const numberlabeldict = Dict(
    1 => "singular",
    2 => "dual",
    3 => "plural"
)



"""Dict mapping labels to codes for number.

$(SIGNATURES)
"""
const numbercodedict = Dict(
    "singular" => 1,
    "dual" => 2,
    "plural" => 3
)