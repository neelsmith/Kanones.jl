#  pos|inflectionclass|description|paradigmword|superclass


"""Metadata about an inflectional category."""
struct InflectionCategory
    pos
    inflectionclass
    description
    paradigmword
    superclass
end

function icfromdelimited(row)
    cols = split(row, "|")
    if length(cols) < 5
        @warn("Too few columns in row $(row)")
        nothing
    else
        InflectionCategory(
            cols[1], cols[2], cols[3], cols[4], cols[5]
        )
    end
end
function icfromfile(f)
    map(ln  -> icfromdelimited(ln), readlines(f)[3:end])
end

