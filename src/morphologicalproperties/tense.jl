struct GMPTense <: GreekMorphologicalProperty
    code::Int64
    function GMPTense(code)
        code in keys(tenselabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Override Base.show for a tense property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPTense)
    print(io, label(prop))
end


"""Construct tense property from a string value.
$(SIGNATURES)
"""
function gmpTense(s::AbstractString)
    s in keys(tensecodedict) ? GMPTense(tensecodedict[s]) : DomainError(string(s, " is not a valid value for tense.")) 
end

"""Construct tense property from an integer code.
$(SIGNATURES)
"""
function gmpTense(code::Int64)
    GMPTense(code)
end


"""Integer code for a tense value.
$(SIGNATURES)
"""
function code(tense::GMPTense)
    tense.code
end


"""Readable label for a tense value.
$(SIGNATURES)
"""
function label(tense::GMPTense)
    tenselabeldict[tense.code]
end

"""Dict mapping codes to labels for mood.

$(SIGNATURES)
"""
const tenselabeldict = Dict(
    1 => "present",
    2 => "imperfect",
    3 => "aorist",
    4 => "perfect",
    5 => "pluperfect",
    6 => "future"
)

"""Dict mapping labels to codes for mood.

$(SIGNATURES)
"""
const tensecodedict = Dict(
    "present" => 1,
    "imperfect" => 2,
    "aorist" => 3,
    "perfect" => 4,
    "pluperfect" => 5,
    "future" => 6
)
