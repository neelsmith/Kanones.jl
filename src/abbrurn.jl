
struct AbbreviatedUrn
    collection::AbstractString
    objectid::AbstractString
    AbbreviatedUrn(s) = begin
        parts = split(s,".")
        if length(parts) == 2
            new(parts[1], parts[2])
        else
            throw(ArgumentError("AbbrevitedUrn: invalid syntax: $(s)"))
        end
    end
end

function fstsafe(au::AbbreviatedUrn)
    string("<u>", au.collection, raw"\.", au.objectid, "</u>")
end