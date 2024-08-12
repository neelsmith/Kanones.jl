struct GMPCase <: GreekMorphologicalProperty
    code::Int64
    function GMPCase(code)
        code in keys(caselabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Override Base.show for a case property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPCase)
    print(io, label(prop))
end

"""Construct a case from a string value.
$(SIGNATURES)
"""
function gmpCase(s::AbstractString)
    s in keys(casecodedict) ? GMPCase(casecodedict[s]) : DomainError(string(s, " is not a valid value for case.")) 
end


"""Construct a case from an integer code.
$(SIGNATURES)
"""
function gmpCase(code::Int64)
    GMPCase(code)
end

"""Find integer code for a case object.
$(SIGNATURES)
"""
function code(mcase::GMPCase)
    mcase.code
end


"""String label for a case object.
$(SIGNATURES)
"""
function label(mcase::GMPCase)
    caselabeldict[mcase.code]
end

"""Dict mapping codes to labels for case.

$(SIGNATURES)
"""
const caselabeldict = Dict(
    1 => "nominative",
    2 => "genitive",
    3 => "dative",
    4 => "accusative",
    5 => "vocative"
)

"""Dict mapping labels to codes for case.

$(SIGNATURES)
"""
const casecodedict = Dict(
    "nominative" => 1,
    "genitive" => 2,
    "dative" => 3,
    "accusative" => 4,
    "vocative" => 5
)