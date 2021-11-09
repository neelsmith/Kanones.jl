struct GMPGender <: GreekMorphologicalProperty
    code::Int64
    function GMPGender(code)
        @info("Creating gender property for code ", code)
        if code in keys(genderlabels)
            new(code)
        else
            @warn(string(code, " is out of range. TYpe of code ", typeof(code)))
            throw(DomainError(string(code, " is out of range.")))
            nothing
        end
        #code in keys(genderlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
        
    end
end

function gmpGender(s::AbstractString)
    s in keys(gendercodes) ? GMPGender(gendercodes[s]) : DomainError(string(s, " is not a valid value for gender.")) 
end

function gmpGender(code::Int64)
    GMPGender(code)
end

function code(gender::GMPGender)
    gender.code
end

function label(gender::GMPGender)
    genderlabels[gender.code]
end


"""Dict mapping codes to labels for gender.

$(SIGNATURES)
"""
const genderlabels = Dict(
    1 => "masculine",
    2 => "feminine",
    3 => "neuter"
)

"""Dict mapping labels to codes for gender.

$(SIGNATURES)
"""
const gendercodes = Dict(
    "masculine" => 1,
    "feminine" => 2,
    "neuter" => 3
)