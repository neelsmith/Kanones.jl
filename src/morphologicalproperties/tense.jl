struct GMPTense <: GreekMorphologicalProperty
    code::Int64
    function GMPTense(code)
        code in keys(tenselabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

function gmpTense(s::AbstractString)
    s in keys(tensecodes) ? GMPTense(tensecodes[s]) : DomainError(string(s, " is not a valid value for tense.")) 
end

function gmpTense(code::Int64)
    GMPTense(code)
end

function code(tense::GMPTense)
    tense.code
end

function label(tense::GMPTense)
    tenselabels[tense.code]
end

"""Dict mapping codes to labels for mood.

$(SIGNATURES)
"""
const tenselabels = Dict(
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
const tensecodes = Dict(
    "present" => 1,
    "imperfect" => 2,
    "aorist" => 3,
    "perfect" => 4,
    "pluperfect" => 5,
    "future" => 6
)
