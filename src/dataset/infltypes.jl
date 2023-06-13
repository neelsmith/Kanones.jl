
"""Index lexemes in a dataset to their inflection class.
$(SIGNATURES)
"""
function inflclassindex(ds::T) where  {T <: Dataset}
    stems = stemsarray(ds)
    map(stems) do s
        (string(lexeme(s)), string(inflectionclass(s))) 
    end |> unique
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function inflclassindex(src::AbstractString, freader::Type{FileReader}; delimter = "|")
    read(src) |> String |> inflclassindex
end


"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function inflclassindex(src::AbstractString, freader::Type{UrlReader}; delimter = "|")
    f = Download(src)
    data = read(f) |> String
    rm(f)
    inflclassindex(data)
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source.
$(SIGNATURES)
"""
function inflclassindex(src; delimiter = "|")
    pairs = []
    # Omit header line:
    for ln in split(src, "\n")[2:end]
        pair = split(ln, delimiter)
        if length(pair) != 2
            @warn("Bad input for inflection class index: $(ln)")
        else
            push!(pairs, (pair[1], pair[2]) )
        end
    end
    pairs
end




function inflclassindex_delimited(ds::T; delimiter = "|") where {T <: Dataset}
    idx = inflclassindex(ds)
    map(idx) do pr
        string(pr[1],delimiter,pr[2])
    end
end