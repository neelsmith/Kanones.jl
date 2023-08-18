
"""Overwrite a stem file with contents sorted by LSJ number.

$(SIGNATURES)

`f` is the file to sort.
"""
function sortstemfile(f; lsjcolumn = 2)
    dataset = readdlm(f,'|')
    sortable = []
    for i = 2:size(dataset,1)
        ln = dataset[i,:]
        if startswith(ln[lsjcolumn], "lsj.n")
            trimtrailingalpha = replace(ln[lsjcolumn], r"[a-z]$" => "")
            intkey = parse(Int64, replace(trimtrailingalpha, "lsj.n" => ""))
            @debug("Key/ln",intkey,ln)
            push!(sortable, (intkey, ln))
        else
            push!(sortable, (40000,ln))
        end
    end
    sorted = map(pr -> join(pr[lsjcolumn], "|"),  sort(sortable))
    contents = string(join(dataset[1,:],"|"), "\n\n", join(sorted, "\n"))
    open(f,"w") do io
       write(io,contents)
    end
end