struct GMPNumber <: GreekMorphologicalProperty
    code::Int64
    function GMPNumber(code)
        code in keys(numberlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Override Base.show for a number property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPNumber)
    print(io, label(prop))
end


"""Construct a number property from a string value.
$(SIGNATURES)
"""
function gmpNumber(s::AbstractString)
    s in keys(numbercodedict) ? GMPNumber(numbercodedict[s]) : DomainError(string(s, " is not a valid value for number.")) 
end


"""Construct a number property from an integer code.
$(SIGNATURES)
"""
function gmpNumber(code::Int64)
    GMPNumber(code)
end


"""Integer code for number property.
$(SIGNATURES)
"""
function code(num::GMPNumber)
    num.code
end

"""Readable label for a number property.
$(SIGNATURES)
"""
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