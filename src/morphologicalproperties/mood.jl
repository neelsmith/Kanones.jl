struct GMPMood <: GreekMorphologicalProperty
    code::Int64
    function GMPMood(code)
        code in keys(moodlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end


"""Override Base.show for a mood property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPMood)
    print(io, label(prop))
end


"""Construct mood property from a string value.
$(SIGNATURES)
"""
function gmpMood(s::AbstractString)
    s in keys(moodcodedict) ? GMPMood(moodcodedict[s]) : DomainError(string(s, " is not a valid value for mood.")) 
end



"""Construct mood property from an integer code.
$(SIGNATURES)
"""
function gmpMood(code::Int64)
    GMPMood(code)
end


"""Integer code for a mood property.
$(SIGNATURES)
"""
function code(mood::GMPMood)
    mood.code
end


"""Readable label for a mood property.
$(SIGNATURES)
"""
function label(mood::GMPMood)
   moodlabeldict[mood.code]
end

"""Dict mapping codes to labels for mood.

$(SIGNATURES)
"""
const moodlabeldict = Dict(
    1 => "indicative",
    2 => "subjunctive",
    3 => "optative",
    4 => "imperative"
)

"""Dict mapping labels to codes for mood.

$(SIGNATURES)
"""
const moodcodedict = Dict(
    "indicative" => 1,
    "subjunctive" => 2,
    "optative" => 3,
    "imperative" => 4
)
