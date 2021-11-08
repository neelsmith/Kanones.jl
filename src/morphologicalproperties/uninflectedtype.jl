struct GMPUninflectedType <: GreekMorphologicalProperty
    code::Int64
    function GMPUninflectedType(code)
        code in 1:3 ? new(code) : throw(DomainError(string(code, " is not in range 1-3.")))
    end
end

function gmpUninflectedType(s::AbstractString)
    s in keys(uninflectedcodes) ? GMPUninflectedType(uninflectedcodes[s]) : DomainError(string(s, " is not a valid value for uninflected type.")) 
end

function gmpUninflectedType(code::Int64)
    GMPUninflectedType(code)
end

function code(utype::GMPUninflectedType)
    utype.code
end

function label(utype::GMPUninflectedType)
    uninflectedlabels[utype.code]
end


"""Dict mapping codes to labels for uninflected part of speech.

$(SIGNATURES)
"""
const uninflectedlabels = Dict(
    1 => "conjunction",
    2 => "preposition",
    3 => "particle",
    4 => "adverb",
    5 => "numeral",
    6 =>"interjection"
)

"""Dict mapping labels to codes for uninflected part of speech.

$(SIGNATURES)
"""
const uninflectedcodes = Dict(
    "conjunction" => 1,
    "preposition" => 2,
    "particle" => 3,
    "adverb" => 4,
    "numeral" => 5,
    "interjection"  => 6
)