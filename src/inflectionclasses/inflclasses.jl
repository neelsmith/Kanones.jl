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
    data = filter(ln -> ! isempty(ln), readlines(f))
    # Skip `ctsblock` label and header line:
    map(ln  -> icfromdelimited(ln), data[3:end])
end


function label(ic::InflectionCategory)
    string(ic.description, ", like ", ic.paradigmword)
end

"""Compute a frequency of inflection categories clustered by their super category.
Returns a vector of pairs with label for the category and total count for the category,
sorted by count.

## Parameters
- `v` is a vector with metadata about each `InflectionCategory`
- `counts` is a dictionary of occurence counts keyed by the string ID for the inflection class
$(SIGNATURES)
"""
function superclasshistogram(v::Vector{InflectionCategory}, counts::OrderedDict{String, Int64})
    # Dictionary for clustered results:
    d = Dict{String,Int}()
    for ic in v
        if haskey(counts, ic.inflectionclass)
            if haskey(d, ic.superclass)
                d[ic.superclass] = d[ic.superclass] + counts[ic.inflectionclass]
            else
                d[ic.superclass] =  counts[ic.inflectionclass]
            end
        else
            @warn("Key $(ic.inflectionclass) not found in histogram")
        end
    end
    prs = []
    for (k,v) in d
        push!(prs, (k,v))
    end
    sort(prs, by=pr -> pr[2], rev=true)
end