struct GMPPerson <: GreekMorphologicalProperty
    code::Int64
    function GMPPerson(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpPerson(s::AbstractString)
    s in keys(personcodes) ? GMPPerson(personcodes[s]) : DomainError(string(s, " is not a valid value for person.")) 
end

function gmpPerson(code::Int64)
    GMPPerson(code)
end

function code(person::GMPPerson)
    person.code
end

function label(person::GMPPerson)
    personlabels[person.code]
end


"""Dict mapping codes to labels for person.

$(SIGNATURES)
"""
const personlabels = Dict(
    1 => "first",
    2 => "second",
    3 => "third"
)



"""Dict mapping labels to codes for person.

$(SIGNATURES)
"""
const personcodes = Dict(
    "first" => 1,
    "second" => 2,
    "third" => 3
)