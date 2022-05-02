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
    ptrn = PolytonicGreek.nfkc(s) * "|"
    @debug("Match pattern", ptrn)
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


"""True if form IDs are build from the `Rule` of a
stem-rule pair.
$(SIGNATURES)
"""
function buildfromrule(r::T) where {T <: KanonesRule}
    isa(r, PronounRule) == false  &&
    isa(r, UninflectedRule)  ==  false &&    
    (r isa IrregularRule) == false
end

"""Generate all forms possible for `stem`.
$(SIGNATURES)
"""
function buildparseable(stem::T,  rules::Vector{Rule}) where {T <: KanonesStem }
    generated = []        
    classrules = filter(r -> inflectionClass(r) == inflectionClass(stem), rules)
    if stem isa NounStem 
        filter!(r -> gmpGender(r) == gmpGender(stem), classrules)
    end
    
    for rule in classrules
        token = generate(stem, rule)
        raw = ""
        if buildfromrule(rule)
            raw = string(token, "|", lexeme(stem), "|", Kanones.formurn(rule), "|", urn(stem), "|", urn(rule))
        else
            raw = string(token, "|", lexeme(stem), "|", Kanones.formurn(stem), "|", urn(stem), "|", urn(rule))
        end
        push!(generated, PolytonicGreek.nfkc(raw))
    end



    generated
end