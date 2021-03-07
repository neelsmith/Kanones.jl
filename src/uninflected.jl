

struct UninflectedStem <: StemType
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    stemclass
end

"KanonesIO type for reading and writing stem data for uninflected stems."
struct UninflectedStemParser <: KanonesIO
    label::AbstractString
end

function uninflectedstemparser()
    UninflectedStemParser("KanonesIO type for reading and writing stem data for uninflected stems.")
end

function readrow(usp::UninflectedStemParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 4
        msg = "Invalid syntax for uninflected stem: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        stemid = AbbreviatedUrn(parts[1])
        lexid = AbbreviatedUrn(parts[2])
        form = parts[3]
        stemclass = parts[4]
        UninflectedStem(stemid, lexid, form, stemclass)
    end
end


function fst(stem::UninflectedStem)
    string(
        fstsafe(stem.stemid),
        fstsafe(stem.lexid),
        stem.form,
        "<uninflected>",
        "<", stem.stemclass, ">"
    )
end
