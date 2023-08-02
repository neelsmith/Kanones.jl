"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct StringParser <: KanonesParser
    entries
end

"""Write entries to file.
$(SIGNATURES)
"""
function tofile(p::StringParser, f; delimiter = nothing )
    src = "Token,Lexeme,Form,Stem,Rule\n" * join(p.entries,"\n") * "\n"
    txt = isnothing(delimiter) ? src : replace(src, "|" => delimiter)
    open(f, "w") do io
        write(f, txt)
    end
end

"""Parse a single token using `parser`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, parser::StringParser; data = nothing)
    #strlist = resolvestring(s)
    ptrn = knormal(s) * "|"
    @debug("Match pattern", ptrn)
    matches = filter(ln -> startswith(ln, ptrn), parser.entries)
    map(ln -> fromline(ln), matches)
end

"""Instantiate a `StringParser` for `td`.
$(SIGNATURES)
"""
function stringParser(kd::Kanones.FilesDataset; delimiter = "|", interval = 50)
    analyses = []
    rules = rulesarray(kd)
    stems = stemsarray(kd) 
    for (i, stem) in enumerate(stems)
        if i % interval == 0
            @info("stem $(i)… $(stem)")
        end
        append!(analyses, buildparseable(stem, rules, delimiter = delimiter))
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
function analysis_lines(td::Kanones.FilesDataset)
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
function buildparseable(stem::T,  rules::Vector{Rule}; delimiter = "|") where {T <: KanonesStem }
    @debug("BUILD PARSES FOR STEM", stem)
    generated = AbstractString[]        
    classrules = filter(r -> inflectionclass(r) == inflectionclass(stem), rules)
    if stem isa NounStem 
        filter!(r -> gmpGender(r) == gmpGender(stem), classrules)
    end
    @debug("$(length(classrules)) rules for $(inflectionclass(stem)))")
    for rule in classrules
        @debug("Apply rule to stem", rule, stem)
        token = generate(stem, rule)
        @debug("Generated/rule", token, rule)
        @debug(syllabify(knormal(token), literaryGreek()))
        raw = ""
        if buildfromrule(rule)
            raw = join([knormal(token), lexeme(stem), Kanones.formurn(rule), urn(stem), urn(rule)], delimiter)
        else
            raw = join([knormal(token), lexeme(stem), Kanones.formurn(stem), urn(stem), urn(rule)], delimiter)
        end
        push!(generated, knormal(raw))
    end
    generated
end


"""Find unique lexemes recognized by a `StringParser`.
$(SIGNATURES)
"""
function lexemes(sp::StringParser)
    map(sp.entries) do ln
        split(ln, "|")[2]
    end |> unique
end

