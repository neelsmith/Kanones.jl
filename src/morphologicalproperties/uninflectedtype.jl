struct GMPUninflectedType <: GreekMorphologicalProperty
    code::Int64
    function GMPUninflectedType(code)
        code in keys(uninflectedlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end



function gmpUninflectedType(s::AbstractString)
    @debug("Get uninfleted type for $(s)")
    s in keys(uninflectedcodedict) ? GMPUninflectedType(uninflectedcodedict[s]) : DomainError(string(s, " is not a valid value for uninflected type.")) 
end

function gmpUninflectedType(code::Int64)
    GMPUninflectedType(code)
end

function code(utype::GMPUninflectedType)
    utype.code
end

function label(utype::GMPUninflectedType)
    uninflectedlabeldict[utype.code]
end


"""Dict mapping codes to labels for uninflected part of speech.

$(SIGNATURES)
"""
const uninflectedlabeldict = Dict(
    1 => "conjunction",
    2 => "preposition",
    3 => "particle",
    4 => "adverb",
    5 => "numeral",
    6 =>"interjection",
    7 =>"adverb_comp",
    8 =>"adverb_superl"
)

"""Dict mapping labels to codes for uninflected part of speech.

$(SIGNATURES)
"""
const uninflectedcodedict = Dict(
    "conjunction" => 1,
    "preposition" => 2,
    "particle" => 3,
    "adverb" => 4,
    "numeral" => 5,
    "interjection"  => 6,
    "adverb_comp" => 7,
    "adverb_superl" => 8
)