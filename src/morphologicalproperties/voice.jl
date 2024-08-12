struct GMPVoice <: GreekMorphologicalProperty
    code::Int64
    function GMPVoice(code)
        code in keys(voicelabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end


"""Override Base.show for a voice property.
$(SIGNATURES)
"""
function show(io::IO, prop::GMPVoice)
    print(io, label(prop))
end


"""Construct a voice property from a string value.
$(SIGNATURES)
"""
function gmpVoice(s::AbstractString)
    s in keys(voicecodedict) ? GMPVoice(voicecodedict[s]) : DomainError(string(s, " is not a valid value for voice.")) 
end

"""Construct a voice property from an integer code.
$(SIGNATURES)
"""
function gmpVoice(code::Int64)
   GMPVoice(code)
end


"""Integer code for a voice property.
$(SIGNATURES)
"""
function code(voice::GMPVoice)
    voice.code
end

"""Readable label for a voice property.
$(SIGNATURES)
"""
function label(voice::GMPVoice)
    voicelabeldict[voice.code]
end

"""Dict mapping codes to labels for voice.

$(SIGNATURES)
"""
const voicelabeldict = Dict(
    1 => "active",
    2 => "middle",
    3 => "passive"
)

"""Dict mapping labels to codes for voice.

$(SIGNATURES)
"""
const voicecodedict = Dict(
   "active" => 1,
    "middle" => 2,
    "passive" => 3
)