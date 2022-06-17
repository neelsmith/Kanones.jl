"""Use `delimitedreader` to read a Vector of 
`Stem`s from `f`.
$(SIGNATURES)
"""
function regularstemfile(f, delimitedreader)
    stemsarr = Stem[]
    raw = readlines(f)
    # Trim lines first:
    lines = filter(s -> ! isempty(s), raw)
    @debug("Read datalines", length(lines))
    for i in 2:length(lines)
        try
            stem = readstemrow(delimitedreader, lines[i]; delimiter = "|")
            #@debug("==>READ STEM", stem)
            push!(stemsarr,stem)
        catch e
            @warn("Failed to parse stem data from line $(lines[i]) in file $(f)")
            @warn("Error: $(e)")
        end 
    end
    stemsarr
end