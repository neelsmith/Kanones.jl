struct GMPMood <: GreekMorphologicalProperty
    code::Int64
    function GMPMood(code)
        code in 1:4 ? new(code) : throw(DomainError(string(code, " is not in range 1-4.")))
    end
end

function gmpMood(s::AbstractString)
    s in keys(moodcodes) ? GMPMood(moodcodes[s]) : DomainError(string(s, " is not a valid value for mood.")) 
end

function gmpMood(code::Int64)
    GMPMood(code)
end

function code(mood::GMPMood)
    mood.code
end

function label(mood::GMPMood)
   moodlabels[mood.code]
end

"""Dict mapping codes to labels for mood.

$(SIGNATURES)
"""
const moodlabels = Dict(
    1 => "indicative",
    2 => "subjunctive",
    3 => "optative",
    4 => "imperative"
)

"""Dict mapping labels to codes for mood.

$(SIGNATURES)
"""
const moodcodes = Dict(
    "indicative" => 1,
    "subjunctive" => 2,
    "optative" => 3,
    "imperative" => 4
)