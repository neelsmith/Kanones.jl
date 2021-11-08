struct GMPGender <: GreekMorphologicalProperty
    code::Int64
    function GMPGender(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
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