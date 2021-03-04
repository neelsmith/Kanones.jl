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
            if ! ispath(f)
                push!(errors,"Error in data layout of $(dir): missing required file " * f)
            end
        end
        if isempty(errors)
            true, ""
        else 
            false, join(errors, ".  ")
        end
    end
end

