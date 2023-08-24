"""Index lexemes in a dataset to their inflection class.
$(SIGNATURES)
"""
function inflclassindex(ds::T) where  {T <: Dataset}
    stems = stemsarray(ds)
    map(stems) do s
        (lexemeid = string(lexeme(s)), inflclass = string(inflectionclass(s))) 
    end |> unique
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function inflclassindex(src::AbstractString, freader::Type{FileReader}; delimiter = "|")
    data = read(src) |> String 
    inflclassindex(data; delimiter = delimiter)
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function inflclassindex(src::AbstractString, freader::Type{UrlReader}; delimiter = "|")
    f = Downloads.download(src)
    data = read(f) |> String
    rm(f)
    inflclassindex(data; delimiter = delimiter)
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function inflclassindex(src::AbstractString, freader::Type{StringReader}; delimiter = "|")
    inflclassindex(src; delimiter = delimiter)
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
            push!(pairs, (lexemeid = pair[1], inflclass =pair[2]) )
        end
    end
    pairs
end



"""Format index of lexemes to inflection classes as delimited text.
$(SIGNATURES)
"""
function inflclassindex_delimited(ds::T; delimiter = "|") where {T <: Dataset}
    idx = inflclassindex(ds)
    map(idx) do pr
        string(pr[1],delimiter,pr[2])
    end
end

function class_in_rules(inflclass::AbstractString, ds::T) where {T <: Dataset}
    inflclass in classes_in_rules(ds)
end

function classes_in_rules(rules::Vector{Rule})
    map(r -> inflectionclass(r), rules)  |> unique
end

function classes_in_rules(ds::T) where {T <: Dataset}
    classes_in_rules(rulesarray(ds))
end

"""Find all inflection classes in stems that do
have at least one corresponding rule.
$(SIGNATURES)
"""
function rulesmissing(ds::T) where {T <: Dataset}
    filter(classes_in_stems(ds)) do inflclass
        ! class_in_rules(inflclass, ds)
    end
end



function classes_in_stems(stems::Vector{Stem})
    map(stem -> inflectionclass(stem), stems)  |> unique
end

function classes_in_stems(ds::T) where {T <: Dataset}
    classes_in_stems(stemsarray(ds))
end