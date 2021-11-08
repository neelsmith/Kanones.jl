struct GMPVoice <: GreekMorphologicalProperty
    code::Int64
    function GMPVoice(code::Int64)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpVoice(s::AbstractString)
    s in keys(voicecodes) ? GMPVoice(voicecodes[s]) : DomainError(string(s, " is not a valid value for voice."))
    
end


"""Dict mapping codes to labels for voice.

$(SIGNATURES)
"""
const voicelabels = Dict(
    1 => "active",
    2 => "middle",
    3 => "passive"
)



"""Dict mapping labels to codes for voice.

$(SIGNATURES)
"""
const voicecodes = Dict(
   "active" => 1,
    "middle" => 2,
    "passive" => 3
)