struct GMPGender <: GreekMorphologicalProperty
    code::Int64
    function GMPGender(code)
        if code in keys(genderlabeldict)
            new(code)
        else
            @warn(string(code, " is out of range. TYpe of code ", typeof(code)))
            throw(DomainError(string(code, " is out of range.")))
            nothing
        end
        #code in keys(genderlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
        
    end
end


"""Override Base.show for a gender property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPGender)
    print(io, label(prop))
end


"""Construct gender property from a string value.
$(SIGNATURES)
"""
function gmpGender(s::AbstractString)
    s in keys(gendercodedict) ? GMPGender(gendercodedict[s]) : DomainError(string(s, " is not a valid value for gender.")) 
end

"""Construct gender property from an integer code.
$(SIGNATURES)
"""
function gmpGender(code::Int64)
    GMPGender(code)
end


"""Integer code for a gender property.
$(SIGNATURES)
"""
function code(gender::GMPGender)
    gender.code
end


"""Readable label for a gender property.
$(SIGNATURES)
"""
function label(gender::GMPGender)
    genderlabeldict[gender.code]
end


"""Dict mapping codes to labels for gender.

$(SIGNATURES)
"""
const genderlabeldict = Dict(
    1 => "masculine",
    2 => "feminine",
    3 => "neuter"
)

"""Dict mapping labels to codes for gender.

$(SIGNATURES)
"""
const gendercodedict = Dict(
    "masculine" => 1,
    "feminine" => 2,
    "neuter" => 3
)