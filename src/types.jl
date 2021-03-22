abstract type Stem end
abstract type Rule end


# These three functions must be implemented to return AbbreviatedUrns
# for a Stem or Rule.


function id(s::Stem)
    @warn("Unrecognized implementation of Stem")
    nothing
end

function lexeme(s::Stem)
    @warn("Unrecognized implementation of Stem")
    nothing
end


function id(r::Rule)
    @warn("Unrecognized implementation of Rule")
    nothing
end