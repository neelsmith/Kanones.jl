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


function validsource(dir)
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

