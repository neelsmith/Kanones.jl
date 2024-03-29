struct GMPPerson <: GreekMorphologicalProperty
    code::Int64
    function GMPPerson(code)
        code in keys(personlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

function gmpPerson(s::AbstractString)
    s in keys(personcodedict) ? GMPPerson(personcodedict[s]) : DomainError(string(s, " is not a valid value for person.")) 
end

function gmpPerson(code::Int64)
    GMPPerson(code)
end

function code(person::GMPPerson)
    person.code
end

function label(person::GMPPerson)
    personlabeldict[person.code]
end


"""Dict mapping codes to labels for person.

$(SIGNATURES)
"""
const personlabeldict = Dict(
    1 => "first",
    2 => "second",
    3 => "third"
)



"""Dict mapping labels to codes for person.

$(SIGNATURES)
"""
const personcodedict = Dict(
    "first" => 1,
    "second" => 2,
    "third" => 3
)