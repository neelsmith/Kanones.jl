
"""Read all records for composing compound  stems of irregular verbs from `kd`.
$(SIGNATURES)
"""
function irregularcompoundsarray(kd::Kanones.FilesDataset; delimiter = "|")
    irregularcompoundsarray(kd.dirs, delimiter = delimiter)
end

"""Recursively read all records for composing compound  stems of irregular verbs from a list of directories.
$(SIGNATURES)
"""
function irregularcompoundsarray(dirlist; delimiter = "|")
    compoundarray = CompoundVerbStem[]
    
    pattern  = r".cex$"
    for datasrc in dirlist
        @debug("Reading irreg. compounds from ", datasrc)
        dir = joinpath(datasrc, "irregular-stems", "verbs-compound")
        if isdir(dir)
            for (root, dirs, files) in walkdir(dir)
                for f in files
                    if occursin(pattern, f) 
                        @debug("READ f", joinpath(root,f))
                        raw = readlines(joinpath(root,f))
                        lines = filter(s -> ! isempty(s), raw)
                        datalines = lines[2:end]
                        for ln in datalines
                            try 
                                #record = compoundstem(ln)
                                record = fromcex(ln, CompoundVerbStem)
                                push!(compoundarray,record)
                            catch e
                                @warn("Failed to parse compound verb entry from line\n\"$(ln)\" \nin file ($(f)")
                                @warn("Error: $(e)")
                            end
                        end
                    end
                end
            end
        end
    end
    unique(compoundarray)
end



"""For each compound verb entry  for irregular verbs found in `dirlist`, apply the prefix
to appropriate entries in `verbstems`.
$(SIGNATURES)
"""
function irregularcompounds(dirlist, verbstems; ortho = literaryGreek())
    compoundstemsarr = Stem[]
    # Add compound verbs.
    for s in irregularcompoundsarray(dirlist)
        compounded = irregularstems(s, verbstems, ortho)
        @debug("created $(length(compounded)) stems for ", s)
        for c in compounded
            push!(compoundstemsarr, c)
        end
    end
    compoundstemsarr
end