#
#
# Work with information about inflection classes in a Kanones dataset.
#

"""Index lexemes in a dataset to their inflection class.
$(SIGNATURES)
"""
function lexemeclassindex(ds::T) where  {T <: Dataset}
    lexemeclassindex(stemsarray(ds))
end

"""Index lexemes in a list of `Stem`s to their inflection class.
$(SIGNATURES)
"""
function lexemeclassindex(stems::Vector{Stem})
    map(stems) do s
        (lexemeid = string(lexeme(s)), inflclass = string(inflectionclass(s))) 
    end |> unique
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function lexemeclassindex(src::AbstractString, freader::Type{FileReader}; delimiter = "|")
    data = read(src) |> String 
    lexemeclassindex(data; delimiter = delimiter)
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function lexemeclassindex(src::AbstractString, freader::Type{UrlReader}; delimiter = "|")
    f = Downloads.download(src)
    data = read(f) |> String
    rm(f)
    lexemeclassindex(data; delimiter = delimiter)
end

"""Instantiate an index of lexemes to their inflection class from a delimited-text source read from a file.
$(SIGNATURES)
"""
function lexemeclassindex(src::AbstractString, freader::Type{StringReader}; delimiter = "|")
    lexemeclassindex(src; delimiter = delimiter)
end


"""Instantiate an index of lexemes to their inflection class from a delimited-text source.
$(SIGNATURES)
"""
function lexemeclassindex(src; delimiter = "|")
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
function lexemeclassindex_delimited(ds::T; delimiter = "|") where {T <: Dataset}
    idx = lexemeclassindex(ds)
    map(idx) do pr
        string(pr[1],delimiter,pr[2])
    end
end

"""Create a dictionary of inflectional classes to lexeme ids
in a dataset.
$(SIGNATURES)
"""
function classtolexemedict(ds::T) where {T <: Kanones.Dataset}
    classtolexemedict(stemsarray(ds))
end

"""Compile a dictionary of inflection classes to lexemes in an
array of `Stem`s.
$(SIGNATURES)
"""
function classtolexemedict(stems::Vector{Stem})
    dict = Dict()
    for stem in stems
        iclass = inflectionclass(stem)
        lex = lexeme(stem)
        if haskey(dict, iclass)
            prevlist = dict[iclass]
            dict[iclass] = push!(prevlist, string(lex))
        else
            dict[iclass] = [string(lex)]
        end
    end
    dict
end


"""Compile a dictionary of lexemes to inflectional classes in a dataset.
$(SIGNATURES)
"""
function lexemetoclassdict(ds::T) where {T <: Dataset}
    lexemetoclassdict(stemsarray(ds))
end

"""Compile a dictionary of lexemes to inflectional classes in a vector of `Stem`s.
$(SIGNATURES)
"""
function lexemetoclassdict(stems::Vector{Stem})
    dict = Dict()
   for s in  stems
        dict[string(lexeme(s))] =  string(inflectionclass(s))
   end
   dict
end




"""Find all inflection classes in a Vector of `Rule`s that 
have at least one corresponding rule.
$(SIGNATURES)
"""
function classes_in_rules(rules::Vector{Rule})
    map(r -> inflectionclass(r), rules)  |> unique
end

"""Find all inflection classes in a dataset that 
have at least one corresponding rule.
$(SIGNATURES)
"""
function classes_in_rules(ds::T) where {T <: Dataset}
    classes_in_rules(rulesarray(ds))
end


"""True if inflection class `inflclass` is represented in the dataset's rules.
$(SIGNATURES)
"""
function class_in_rules(inflclass::AbstractString, ds::T) where {T <: Dataset}
    inflclass in classes_in_rules(ds)
end


"""Find all inflection classes in stems that 
have at least one corresponding stem.
$(SIGNATURES)
"""
function classes_in_stems(stems::Vector{Stem})
    map(stem -> inflectionclass(stem), stems)  |> unique
end


"""Find all inflection classes in stems that 
have at least one corresponding stem.
$(SIGNATURES)
"""
function classes_in_stems(ds::T) where {T <: Dataset}
    classes_in_stems(stemsarray(ds))
end

"""True if inflection class `inflclass` is represented in the dataset's stems.
$(SIGNATURES)
"""
function class_in_stems(inflclass::AbstractString, ds::T) where {T <: Dataset}
    inflclass in classes_in_stems(ds)
end



"""Find all inflection classes in stems that do not
have at least one corresponding rule.
$(SIGNATURES)
"""
function rulesmissing(ds::T) where {T <: Dataset}
    filter(classes_in_stems(ds)) do inflclass
        ! class_in_rules(inflclass, ds)
    end
end

