LAST_SORT = 40000

"""Sort lines of a delimited-text file by LSJ number located in column `col`.  
$(SIGNATURES)
"""
function sortbylsj(f; col = 2)
    dataset = readdlm(f,'|')
    sortable = []
    for i = 2:size(dataset,1)
        ln = dataset[i,:]
        @debug("LOOK AT", ln[col])
        if startswith(ln[col], "lsj.n")
            trimtrailingalpha = replace(ln[col], r"[a-z]$" => "")
            intkey = parse(Int64, replace(trimtrailingalpha, "lsj.n" => ""))
            @debug("INTKEY", intkey)
            push!(sortable, (intkey, ln))
        else
            push!(sortable, (LAST_SORT,ln))
        end
    end
    @debug("SORTABLE",sortable)

    sorted = map(pr -> pr[2], sort(sortable))
    lines = map(v -> join(v,"|"), sorted)
    contents = string(join(dataset[1,:],"|"), "\n\n", join(lines, "\n"))
    contents
end


"""Overwrite file `f` with contents sorted by LSJ number located in column `col`.
$(SIGNATURES)
"""
function sortbylsj!(f; col = 2)
    contents = sortbylsj(f, col = col)
    open(f,"w") do io
       write(io,contents)
    end
end