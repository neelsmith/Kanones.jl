
"""
A Kanones dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Kanones' specifications.
- `orthography` is an implementation of the `GreekOrthography` interface
"""
struct Dataset
    dirs
    orthography::GreekOrthography
    function Dataset(dirlist; ortho::T = literaryGreek()) where {T <: GreekOrthography}
        badnews = []
        for dir in dirlist
            @info "Checking $dir"
            ok, msg = validsource(dir)
            if !ok 
                push!(badnews, msg)
            end
        end
        
        if isempty(badnews)
            new(dirlist, ortho)
        else
            throw(ArgumentError(join(badnews, "\n")))
        end
    end
end

"""Read all rules data from a `Kanones.Dataset` into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(kd::Kanones.Dataset)
    iodict = Dict(
        [
        "uninflected" => UninflectedParser("uninflected"),
        "nouns" => NounParser("noun")
        ]
    )
    rulesdirs = [
        "uninflected",
        "nouns"
    ]
    rulesarr = Rule[]

    for datasrc in kd.dirs
        for dirname in rulesdirs 
            dir = datasrc * "/rules-tables/" * dirname * "/"
            cexfiles = glob("*.cex", dir)
            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    rule = readrulerow(delimitedreader, lines[i])
                    push!(rulesarr,rule)
                end
            end
        end
    end
    rulesarr
end

"""Read all stem data from a `Kanones.Dataset` into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(kd::Kanones.Dataset)
    iodict = Dict(
        [
        "uninflected" => UninflectedParser("uninflected"),
        "nouns" => NounParser("noun")
        ]
    )
    lexicon = Stem[]
    stemdirs = [
        "uninflected",
        "nouns"
    ]

    stemsarr = []
    for datasrc in kd.dirs
        for dirname in stemdirs 
            dir = datasrc * "/stems-tables/" * dirname * "/"
            cexfiles = glob("*.cex", dir)
            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i])
                    push!(stemsarr,stem)
                end
            end
        end
    end
    stemsarr
end


"""
True if `dir` satisfies all requirements for a `Kanones.Dataset`.

$(SIGNATURES)    
"""
function validsource(dir)
    @info "Validating $dir"
    if ! ispath(dir)
        false, "Error: $(dir) is not a valid path."
    else
        registry = dir * "urnregistry"
        if ! isdir(registry)
            throw(ArgumentError("No urnregistry found in directory $dir."))
        end
        @info "Registroy ok"
        options =  [
            "stems-tables",
            "rules-tables",
            "irregular-stems"
        ]
        found = []
        @info "Iterating $options"
        for f in options

            fullpath = dir * f
            @info "full path $fullpath"
            if  isdir(fullpath)
                push!(found, true) 
            end
        end
        if isempty(found)
            (false, "No data directories found in directory $dir.")
        else
            (true, "OK")
        end
    end
end

