
"""
A Kanones dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Kanones' specifications.
- `orthography` is an implementation of the `GreekOrthography` interface
"""
struct FilesDataset <: Kanones.Dataset
    dirs
    orthography::GreekOrthography
    function FilesDataset(dirlist; ortho::T = literaryGreek()) where {T <: GreekOrthography}
        if isempty(rulesarray(dirlist))
            #throw(ArgumentError("No inflectional rules found."))
            @warn("No inflectional rules found for $(dirlist).")

        elseif isempty(stemsarray(dirlist))
            #throw(ArgumentError("No lexicon of stems found."))
            @warn("No lexicon of stems found for $(dirlist).")
        # elseif ## if no urn registry ...
        # need to enforce referential integrity of data
        # with registry
            
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

- `srclist` List of full paths to a directory with Kanones data.
- `ortho` An instance of a `GreekOrthography`; defaults to `LiteraryGreekOrthography`.
"""
function dataset(srclist::Vector; ortho::T = literaryGreek()) where {T <: GreekOrthography}
    Kanones.FilesDataset(srclist; ortho =  ortho)
end


"""Read all rules data from a list of directories into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(kd::Kanones.FilesDataset; delimiter = "|")
    rulesarray(kd.dirs, delimiter = delimiter)
end

"""Read all rules data from a `Kanones.FilesDataset` into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(dirlist; delimiter = "|")
    rulesarr = Rule[]
    for datasrc in dirlist
        for dirname in RULES_DIRECTORIES 
            dir = joinpath(datasrc, "rules-tables", dirname)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (RULES_IO_DICT[dirname])
            for f in cexfiles
                @debug("Reading rules from ", f)
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    try 
                        rule = readrulerow(delimitedreader, lines[i], delimiter = delimiter)
                        push!(rulesarr,rule)
                    catch e
                        @warn("Failed to parse rule from line\n\"$(lines[i])\" \nin file ($(f)")
                        @warn("Error: $(e)")
                    end
                end
            end
        end
    end

    unique(rulesarr)
end

"""Read all stem data from a list of directories into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(kd::Kanones.FilesDataset)
    stemsarray(kd.dirs)
end


"""Read all stem data from a `Kanones.FilesDataset` into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(dirlist; delimiter = "|")
    #@info("Getting regular stems for $dirlist")
    stemsarr = Stem[]
    for datasrc in dirlist
        @info("Source directory for Kanones dataset: $(datasrc)")
        for dirname in STEMS_DIRECTORIES 
            dir = joinpath(datasrc, "stems-tables", dirname)
            @debug("dir = ", dir)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (STEMS_IO_DICT[dirname])
            for f in cexfiles
                @debug("Reading stems from ", f)
                raw = readlines(f)
                
                # Trim lines first:
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    try
                        stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                        push!(stemsarr,stem)
                    catch e
                        @warn("Failed to parse stem data from line $(lines[i]) in file $(f)")
                        @warn("Error: $(e)")
                    end
                end
            end
        end
    end
  
    @debug("Getting irregular stems for $dirlist")
    for datasrc in dirlist
        for dirname in IRREGULAR_STEM_DIRECTORIES
            dir = joinpath(datasrc, "irregular-stems", dirname)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (IRREGULAR_IO_DICT[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    push!(stemsarr,stem)
                end
            end
        end
    end

    unique(stemsarr)
end



function registry(kd::Kanones.FilesDataset)
    registry(kd.dirs)
end



"""Read all stem data from a `Kanones.FilesDataset` into an array of `Stem`s.

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
                for i in 2:length(lines)
                    cols = split(lines[i], "|")
                    key = cols[1]
                    urn = cols[2]
                    @debug("COLS", cols)
                    if length(cols) < 3
                        @warn("Failed to parse stem data from line $(lines[i]) in file $(f)")
                    else
                        registrydict[key] = urn
                    end
                end
                
            end
        end
    end
    registrydict
end

function orthography(kd::Kanones.FilesDataset)
    kd.orthography
end

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