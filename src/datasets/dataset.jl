
"""
A Kanones dataset in a local file system.  

# Member

`root` is the full path to the dataset's root directory.  Its subdirectory
organization must follow Kanones' specifications.
"""
struct Dataset
    root::AbstractString
    function Dataset(s)
        ok, msg = validsource(s)
        if ok
            new(s)
        else
            throw(ArgumentError(msg))
        end
        new(s)
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
    for dirname in rulesdirs 
        dir = kd.root * "/rules-tables/" * dirname * "/"
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
    for dirname in stemdirs 
        dir = kd.root * "/stems-tables/" * dirname * "/"
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
    stemsarr
end


"""
True if `dir` satisfies all requirements for a `Kanones.Dataset`.

$(SIGNATURES)    
"""
function validsource(dir::AbstractString)
    if ! ispath(dir)
        false, "Error: $(dir) is not a valid path."
    else
        requiredfiles = [
            "orthography/alphabet.fst"
        ]

        errors = []
        for f in requiredfiles
            fullpath = dir * f
            if ! ispath(fullpath)
                push!(errors,"Error in data layout: missing required file " * fullpath * "\n") 
            end
        end
        if isempty(errors)
            true, ""
        else 
            false, join(errors, ".  ")
        end
    end
end

