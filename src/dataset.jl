
"""
A Kanones dataset in a local file system.  
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


function rulesarray(kd::Kanones.Dataset)

end

function stemsarray(kd::Kanones.Dataset)

end


"""
    validsource(dir::AbstractString)

True if `dir` satisfies Kanones' requirements.
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

