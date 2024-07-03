"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct KanonesStringParser <: KanonesParser
    entries
    ortho::GreekOrthography
    delimiter::AbstractString

    KanonesStringParser(
        entries, #::Vector{AbstractString}, 
        ortho::GreekOrthography = literaryGreek(), delim::AbstractString = "|") = new(entries, ortho, delim)
end

"""Instantiate a generic `StringParser` (from the `CitableParserBuilder` package) from a `KanonesStringParser`.
$(SIGNATURES)
"""
function stringParser(p::KanonesStringParser)
    StringParser(p.entries, p.ortho, p.delimiter)
end

"""Get data source for parser.
$(SIGNATURES)
"""
function datasource(p::KanonesStringParser)
    p.entries
end


"""Get delimiter used in parser.
$(SIGNATURES)
"""
function delimiter(p::KanonesStringParser)
    p.delimiter
end


"""Get orthography for parser.
$(SIGNATURES)
"""
function orthography(p::KanonesStringParser)
    p.ortho
end



"""Write entries of a KanonesStringParser to file.
$(SIGNATURES)
"""
function tofile(p::KanonesStringParser, f)
    open(f, "w") do io
        write(f, cex(p))
    end
end


"""Instantiate a `KanonesStringParser` for `td`.
$(SIGNATURES)
"""
function kanonesStringParser(kd::Kanones.FilesDataset; delimiter = "|", interval = 50)
    analyses = []
    rules = rulesarray(kd)
    stems = stemsarray(kd) 
    for (i, stem) in enumerate(stems)
        if i % interval == 0
            @info("stem $(i)… $(stem)")
        end
        append!(analyses, buildparseable(stem, rules, delimiter = delimiter))
    end
    analyses |> KanonesStringParser
end

"""Instantiate a `KanonesStringParser` from a set of analyses read from a local file.
$(SIGNATURES)
"""
function kanonesStringParser(f, freader::Type{FileReader})
    KanonesStringParser(readlines(f))
end

"""Instantiate a `KanonesStringParser` from a set of analyses read from a URL.
$(SIGNATURES)
"""
function kanonesStringParser(u, ureader::Type{UrlReader})
    tmpfile = Downloads.download(u) 
    sp = readlines(tmpfile) |> KanonesStringParser
    rm(tmpfile)
    sp
end


"""Parse a single token using `parser`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, parser::KanonesStringParser; data = nothing)
    #strlist = resolvestring(s)
    ptrn = knormal(s) * "|"
    @debug("Match pattern", ptrn)
    matches = filter(ln -> startswith(ln, ptrn), datasource(parser))
    map(ln ->  fromcex(ln, Analysis), matches)
end




function generate(lex::LexemeUrn, form::FormUrn, sp::KanonesStringParser; delimiter = "|")
    matchinglines = filter(sp.entries) do ln
        lstring =  string(delimiter, string(lex), delimiter)
        fstring = string(delimiter, string(form), delimiter)
        occursin(lstring, ln) && occursin(fstring, ln)
        
    end
    re = delimiter == "|" ? r"\|.+" : Regex("$delimiter.+")
    map(matchinglines) do ln
        replace(ln, re => "")
    end
end


#=
"""Write a string parser to a delimited-text file.
$(SIGNATURES)
"""
function tofile(p::KanonesStringParser, f; delimiter = nothing )
    src = "Token,Lexeme,Form,Stem,Rule\n" * join(p.entries,"\n") * "\n"
    txt = isnothing(delimiter) ? src : replace(src, "|" => delimiter)
    open(f, "w") do io
        write(f, txt)
    end
end


=#

#=
"""Instantiate a `KanonesStringParser` from a set of analyses read from a local file.
$(SIGNATURES)
"""
function KanonesStringParser(f, freader::Type{FileReader})
    KanonesStringParser(readlines(f))
end

"""Instantiate a `KanonesStringParser` from a set of analyses read from a URL.
$(SIGNATURES)
"""
function KanonesStringParser(u, ureader::Type{UrlReader})
    Downloads.download(u) |> readlines |> KanonesStringParser
end

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
=#

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
        mtoken = token
        @debug("Generated/rule", token, rule)
        @debug(syllabify(knormal(token), literaryGreek()))
        raw = ""
        if buildfromrule(rule)
            raw = join([knormal(token), lexeme(stem), Kanones.formurn(rule), urn(stem), urn(rule), mtoken], delimiter)
        else
            raw = join([knormal(token), lexeme(stem), Kanones.formurn(stem), urn(stem), urn(rule), mtoken], delimiter)
        end
        push!(generated, knormal(raw))
    end
    generated
end

#=
"""Find unique lexemes recognized by a `KanonesStringParser`.
$(SIGNATURES)
"""
function lexemes(sp::KanonesStringParser)
    map(sp.entries) do ln
        split(ln, "|")[2]
    end |> unique
end
=#

"""Build a new `KanonesStringParser` by adding a further dataset
to an existing parser. 

- `sp` is an existing `KanonesStringParser`.
- `rulesds` is the dataset used to build `sp`
- `newdata` is an additional dataset with any new content (rules or vocab)
"""
function concat_ds(sp::KanonesStringParser, rulesds::FilesDataset, newdata::FilesDataset; interval = 100)
    @info("First, get all existing rules from sp!")
    rules_all = vcat(rulesarray(rulesds), rulesarray(newdata))
    stems_new = stemsarray(newdata)
 
    analyses = sp.entries
    for (i, stem) in enumerate(stems_new)
        if i % interval == 0
            @info("stem $(i)… $(stem)")
        end
        append!(analyses, buildparseable(stem, rules, delimiter = delimiter))
    end
    analyses |> KanonesStringParser
end







"""Value for CexTrait on KanonesStringParser."""
struct KanonesStringParserCex <: CexTrait end
"""Identify CEX trait for KanonesStringParser type.
$(SIGNATURES)
"""
function cextrait(::Type{KanonesStringParser})
    KanonesStringParserCex()
end


"""Instantiate a parser from delimited-text format.
Optionally identify orthographic system for parser in
parameter `configuration`.
$(SIGNATURES)
"""
function fromcex(trait::KanonesStringParserCex, cexsrc::AbstractString, T; 
    delimiter = "|", configuration = nothing, strict = true)
    ortho = isnothing(configuration) ? literaryGreek() : configuration
    entries = split(cexsrc, "\n")
    KanonesStringParser(entries, ortho, delimiter)
end