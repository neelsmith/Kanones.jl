
abstract type AbbreviatedUrn end

"Short form of a Cite2Urn containing only collection and object ID."
struct StemUrn <: AbbreviatedUrn
    collection::AbstractString
    objectid::AbstractString
    StemUrn(s) = begin
        parts = split(s,".")
        if length(parts) == 2
            new(parts[1], parts[2])
        else
            throw(ArgumentError("AbbreviatedUrn: invalid syntax: $(s)"))
        end
    end
end


struct RuleUrn <: AbbreviatedUrn
    collection::AbstractString
    objectid::AbstractString
    RuleUrn(s) = begin
        parts = split(s,".")
        if length(parts) == 2
            new(parts[1], parts[2])
        else
            throw(ArgumentError("AbbreviatedUrn: invalid syntax: $(s)"))
        end
    end
end



struct LexemeUrn <: AbbreviatedUrn
    collection::AbstractString
    objectid::AbstractString
    LexemeUrn(s) = begin
        parts = split(s,".")
        if length(parts) == 2
            new(parts[1], parts[2])
        else
            throw(ArgumentError("AbbreviatedUrn: invalid syntax: $(s)"))
        end
    end
end


"""Compose SFST representation of an `AbbreviatedUrn`.
"""
function fstsafe(au::AbbreviatedUrn)
    string("<u>", au.collection, raw"\.", au.objectid, "</u>")
end