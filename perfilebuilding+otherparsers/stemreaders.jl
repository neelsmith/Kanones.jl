"""Use `delimitedreader` to read a Vector of 
`Stem`s from `f`.
$(SIGNATURES)
"""
function regularstemfile(f, delimitedreader)
    stemsarr = Stem[]
    raw = readlines(f)
    # Trim lines first:
    lines = filter(s -> ! isempty(s), raw)
    datalines = lines[2:end]
    @debug("Read datalines", length(datalines))
    for ln in datalines
        try
            stem = readstemrow(delimitedreader, ln; delimiter = "|")
            #@debug("==>READ STEM", stem)
            push!(stemsarr,stem)
        catch e
            @warn("Failed to parse stem data from line $(ln) in file $(f)")
            @warn("Error: $(e)")
        end 
    end
    stemsarr
end