"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct StringParser <: KanonesParser
    entries
end

"""Write entries to file.
$(SIGNATURES)
"""
function tofile(p::StringParser, f)
    open(f, "w") do io
        write(f, join(p.entries,"\n"))
    end
end

"""Parse a single token using `parser`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, parser::StringParser; data = nothing)
    ptrn = s * "|"
    matches = filter(ln -> startswith(ln, ptrn), parser.entries)
    map(ln -> fromline(ln), matches)
end

"""Instantiate a `StringParser` for `td`.
$(SIGNATURES)
"""
function stringParser(kd::Kanones.Dataset)
    #analysis_lines(td) |> StringParser

    analyses = []
    rules = rulesarray(kd)
    for stem in stemsarray(kd)
        append!(analyses, buildparseable(stem, rules))
    end
    analyses |> StringParser
end

#=
"""Instantiate a `StringParser` from a set of analyses read from a local file.
$(SIGNATURES)
"""
function stringParser(f, freader::Type{FileReader})
    StringParser(readlines(f))
end

"""Instantiate a `StringParser` from a set of analyses read from a URL.
$(SIGNATURES)
"""
function stringParser(u, ureader::Type{UrlReader})
    Downloads.download(u) |> readlines |> StringParser
end
=#
"""Serialize a single analysis to delimited text.
$(SIGNATURES)
"""
function analysis_line(a::Analysis; delimiter = "|")
    pieces = [
        a.token,
        string(a.lexeme),
        string(a.form),
        string(a.stem),
        string(a.rule)
    ]
    join(pieces, delimiter)
end

"""Map `Analysis` objects to string values.
$(SIGNATURES)
"""
function analysis_lines(v::Vector{Analysis})
    map(a -> analysis_line(a), v)
end

"""Map all analyses in `td` to string values.
$(SIGNATURES)
"""
function analysis_lines(td::Kanones.Dataset)
    analyses(td) |> analysis_lines
end


"""Create an `Analysis` from line of delimited text.
$(SIGNATURES)
"""
function fromline(s::AbstractString; delimiter = "|")
    pieces = split(s,delimiter)
    Analysis(
        pieces[1], 
        LexemeUrn(pieces[2]),
        FormUrn(pieces[3]),
        StemUrn(pieces[4]),
        RuleUrn(pieces[5])
    )
end



"""Generate all forms possible for `stem`.
$(SIGNATURES)
"""
function buildparseable(stem::Stem,  rules::Vector{Rule}) where {T <: GreekMorphologicalForm}
    generated = []        
    classrules = filter(r -> inflectionClass(r) == inflectionClass(stem), rules)
    
    for rule in classrules
        token = generate(stem, rule)
        push!(generated, string(token, "|", lexeme(stem), "|", Kanones.formurn(rule), "|", urn(stem), "|", urn(rule)))
    end
    generated
end