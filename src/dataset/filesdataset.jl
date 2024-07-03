
"""
A Kanones dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets, that is, a root directory with a subdirectory organization must follow Kanones' specifications.
- `orthography` is an implementation of the `GreekOrthography` interface
"""
struct FilesDataset <: Kanones.Dataset
    dirs
    orthography::GreekOrthography
    function FilesDataset(dirlist; ortho::T = literaryGreek()) where {T <: GreekOrthography}
        # It is permitted for these to be empty, but worth warning about anyway.
        if isempty(rulesarray(dirlist))
            @warn("No inflectional rules found for $(dirlist).")

        elseif isempty(stemsarray(dirlist))
            @warn("No lexicon of stems found for $(dirlist).")
        
        end   
        new(dirlist, ortho)
    end
end

"""Create a `Kanones.FilesDataset` from a single data source.

$(SIGNATURES)

# Arguments

- `dir` Full path to a directory with Kanones data.
- `ortho` An instance of a `GreekOrthography`; defaults to `LiteraryGreekOrthography`.
"""
function dataset(dir::AbstractString; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    Kanones.FilesDataset([dir]; ortho = ortho)
end

"""Create a `Kanones.FilesDataset` from one or more data sources.

$(SIGNATURES)

# Arguments

- `srclist` List of full paths to directories with Kanones data.
- `ortho` An instance of a `GreekOrthography`; defaults to `LiteraryGreekOrthography`.
"""
function dataset(srclist::Vector; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    Kanones.FilesDataset(srclist; ortho =  ortho)
end


"""Recursively read all rules data from a list of directories into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(kd::Kanones.FilesDataset; delimiter = "|")
    rulesarray(kd.dirs, delimiter = delimiter)
end

"""Recursively read all rules data from a `Kanones.FilesDataset` into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(dirlist; delimiter = "|")
    rulesarr = Rule[]
    pattern  = r".cex$"
    for datasrc in dirlist
        for dirname in RULES_DIRECTORIES 
            #delimitedreader = (RULES_IO_DICT[dirname])
            dir = joinpath(datasrc, "rules-tables", dirname)
            @debug("Read from dirname/reader", dir, delimitedreader)
            if isdir(dir)
                for (root, dirs, files) in walkdir(dir)
                    @debug("r/d/f", root, dirs, files)
                    for f in files
                        if occursin(pattern, f) 
                            @debug("READ f", joinpath(root,f))
                            raw = readlines(joinpath(root,f))
                            lines = filter(s -> ! isempty(s), raw)
                            datalines = lines[2:end]
                            for ln in datalines
                                try 
                                    rule = fromcex(ln, RULES_TYPES_DICT[dirname])
                                    @debug("Instantiated rule $(rule)")
                                    push!(rulesarr,rule)
                                catch e
                                    @warn("Failed to parse rule from line\n\"$(ln)\" \nin file ($(f)")
                                    @warn("Error: $(e)")
                                end
                            end
                        end
                    end    
                end
            end
        end
    end

    unique(rulesarr)
end


"""Read all records for composing compound verb stems from `kd`.
$(SIGNATURES)
"""
function compoundsarray(kd::Kanones.FilesDataset; delimiter = "|")
    compoundsarray(kd.dirs, delimiter = delimiter)
end

"""Recursively read all records for composing compound verb stems from a list of directories.
$(SIGNATURES)
"""
function compoundsarray(dirlist; delimiter = "|")
    compoundarray = CompoundVerbStem[]

    pattern  = r".cex$"
    for datasrc in dirlist
        dir = joinpath(datasrc, "stems-tables", "verbs-compound")
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
                                record = compoundstem(ln)
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




"""Read all stem data from a list of directories into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(kd::Kanones.FilesDataset)
    stemsarray(kd.dirs)
end

"""Recursively read stem data from the `stems-tables` directory
of each data set.
$(SIGNATURES)
"""
function regularstems(dirlist; delimiter = "|")
    stemsarr = Stem[]
    pattern  = r".cex$"
    for datasrc in dirlist     
        for dirname in STEMS_DIRECTORIES 
            #delimitedreader = (STEMS_IO_DICT[dirname])
            dir = joinpath(datasrc, "stems-tables", dirname)
            @debug("Read from dirname/reader", dir, delimitedreader)
            if isdir(dir)
                for (root, dirs, files) in walkdir(dir)
                    @debug("r/d/f", root, dirs, files)
                    for f in files
                        if occursin(pattern, f) 
                            @debug("==>Reading file", joinpath(root,f))
                            raw = readlines(joinpath(root, f))
                            # Trim lines first:
                            lines = filter(s -> ! isempty(s), raw)
                            datalines = lines[2:end]
                            @debug("Read datalines", length(datalines))
                            for ln in datalines
                                try
                                    #stem = readstemrow(delimitedreader, ln; delimiter = delimiter)
                                    #...
                                    # find type to read

                                    stem = fromcex(ln, STEMS_TYPES_DICT[dirname])
                                    #@debug("==>READ STEM", stem)
                                    push!(stemsarr,stem)
                                catch e
                                    @warn("Failed to parse stem data from line $(ln) in file $(f)")
                                    @warn("Error: $(e)")
                                end
                                
                            end
                        end
                    end
                end
            end
        end
    end
    stemsarr
end


"""Recursively read stem data from the `irregular-stems` directory
of each data set.
$(SIGNATURES)
"""
function irregularstems(dirlist; delimiter = "|")
    stemsarr = Stem[]
    pattern  = r".cex$"

    for datasrc in dirlist
        for dirname in IRREGULAR_STEM_DIRECTORIES
            #delimitedreader = (IRREGULAR_IO_DICT[dirname])
            dir = joinpath(datasrc, "irregular-stems", dirname)
            @debug("Read from dirname/reader", dir, delimitedreader)
            if isdir(dir)
                for (root, dirs, files) in walkdir(dir)
                    @debug("r/d/f", root, dirs, files)
                    for f in files
                        if occursin(pattern, f) 
                            raw = readlines(joinpath(root,f))
                            lines = filter(s -> ! isempty(s), raw)
                            datalines = lines[2:end]
                            for ln in datalines
                                try
                                    #stem = readstemrow(delimitedreader, ln; delimiter = delimiter)
                                    stem = fromcex(ln,                 IRREGULAR_TYPES_DICT[dirname])
                                    push!(stemsarr,stem)
                                catch
                                    @warn("Irregular stems data: error reading line $(ln) in file $(joinpath(dir,f))")
                                end

                                
                            end
                        end
                    end
                end
            end
        end
    end
    stemsarr
end

"""For each compound verb entry found in `dirlist`, apply the prefix
to appropriate entries in `verbstems`.
$(SIGNATURES)
"""
function regularcompounds(dirlist, verbstems; ortho = literaryGreek())
    compoundstemsarr = Stem[]
    # Add compound verbs.
    for s in compoundsarray(dirlist)
        compounded = stems(s, verbstems, ortho)
        @debug("created $(length(compounded)) stems for ", s)
        for c in compounded
            push!(compoundstemsarr, c)
        end
    end
    compoundstemsarr
end




"""Read all stem data from a `Kanones.FilesDataset` into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(dirlist; ortho = literaryGreek(),  delimiter = "|")
    @info("Getting regular stems for $dirlist")
    regstemsarr = regularstems(dirlist)

    @info("Don't forget to find regular compound stems for $dirlist")
    #verbalstems = filter(s -> s isa VerbStem || s isa IrregularVerbStem, regstemsarr)
    @debug("Selected $(length(verbalstems)) simplex verbal stems")
    #compoundstemsarr = regularcompounds(dirlist, verbalstems, ortho = ortho)

    @info("Getting irregular stems for $dirlist")
    irregstemsarr = irregularstems(dirlist)
    @info("Also need irregular compounds")
    #irregcompoundstemarr = irregularcompounds(dirlist, irregstemsarr, ortho = ortho)


    # Add irregular compound verbs to this:
    #vcat(regstemsarr, irregstemsarr, compoundstemsarr, irregcompoundstemarr)
    
end


"""Read all records of registered URNs from a `Kanones.FilesDataset` into a dictionary of abbreviations to full `Cite2Urn` values.

$(SIGNATURES)
"""
function registry(kd::Kanones.FilesDataset)
    registry(kd.dirs)
end

"""Read all records of registered URNs from a `Kanones.FilesDataset` into a dictionary of abbreviations to full `Cite2Urn` values.

$(SIGNATURES)
"""
function registry(dirlist; delimiter = "|")
    @debug("Getting regular stems for $dirlist")
    registrydict = Dict{AbstractString, AbstractString}()
    for datasrc in dirlist
        @debug("Source directory for Kanones dataset: $(datasrc)")
        for dirname in REGISTRY_DIRECTORIES 
            dir = joinpath(datasrc, "urnregistry", dirname)
            @debug("dir = ", dir)
            cexfiles = glob("*.cex", dir)
            
            for f in cexfiles
                @debug("Reading stems from ", f)
                raw = readlines(f)
                # Trim lines first:
                lines = filter(s -> ! isempty(s), raw)
                datalines = lines[2:end]
                for i in datalines
                    cols = split(ln, "|")
                    key = cols[1]
                    urn = cols[2]
                    @debug("COLS", cols)
                    if length(cols) < 3
                        @warn("Failed to parse stem data from line $(ln) in file $(f)")
                    else
                        registrydict[key] = urn
                    end
                end
                
            end
        end
    end
    registrydict
end

"""The orthographic system of `kd`.
$(SIGNATURES)
"""
function orthography(kd::Kanones.FilesDataset)
    kd.orthography
end


"""Sort in place all delimited files for stem records in `kds`.
$(SIGNATURES)
"""
function sortregularstems!(kds::Kanones.FilesDataset)
    for datasrc in kds.dirs
        @info("Source directory for Kanones dataset: $(datasrc)")
        for dirname in STEMS_DIRECTORIES 
            if dirname != "pronouns"
                dir = joinpath(datasrc, "stems-tables", dirname)
                @debug("dir = ", dir)
                cexfiles = glob("*.cex", dir)
                for f in cexfiles
                    @info("sorting $(f)")
                    sortbylsj!(f)
                end
            end
        end
    end
end
