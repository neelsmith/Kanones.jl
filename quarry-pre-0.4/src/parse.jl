
"""A parser"""
struct KanonesParser <: CitableParser
    label::AbstractString
    sfstpath::AbstractString
end


"""Find full path to `fst-infl`on your system.

$(SIGNATURES)
"""
function fstinflpath()
    rawout = read(`which fst-infl`, String)
    replace(rawout, "\n" => "")
end

"""Find full path to `echo`on your system.

$(SIGNATURES)
"""
function echopath()
    rawout = read(`which echo`, String)
    replace(rawout, "\n" => "")
end

"""Dictionary of functions to use with each analytical type
to determine a `FormUrn` from the FST description of form.

$(SIGNATURES)
"""
function functionforcategory()
    Dict(
        "irregular" => Kanones.irregularfromfst,
        "uninflected" => Kanones.uninflectedfromfst,
        "noun" => Kanones.nounfromfst,
        "pronoun" => Kanones.pronounfromfst,
        "finiteverb" =>  Kanones.verbfromfst,
        "infinitive" => Kanones.infinitivefromfst,
        "participle" => Kanones.participlefromfst,
        "verbaladjective" => Kanones.verbaladjectivefromfst,
        "adjective" => Kanones.adjectivefromfst
    )
end

"""Parse a single line of SFST output into an `Analysis`.

$(SIGNATURES)
"""
function analysisforline(fst::AbstractString)
        (stem, rule) = split(fst, "<div>")

        # Stem part of SFST has a regular structure:
        # always begins with stem ID, lexeme ID,
        # token, and analysis category, before
        # then appending category-specific data.
        stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
        stemdata = replace(FstBuilder.greekfromfst(stem), "<stem>" => "#")
        #@info("STEM DATA ", stemdata)
        stemmatch = collect(eachmatch(stemre, stemdata))
        
        (stemidval, lexidval, tkn, stemtype, stemdata) = stemmatch[1].captures
        #@info("STEM ANALYSIS ", (stemidval, lexidval, tkn, stemtype, stemdata) )
        # Rule part of SFST also has a regular structure:
        # 
        rulere = r"<([^>]+)><([^>]+)>([^<]*)(.*)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (inflclass, analysiscategory, ending, ruledata, ruleidval) = rulematch[1].captures
       # @info("RULE ANALYSIS ", (inflclass, analysiscategory, ending, ruledata, ruleidval) )
        fnctndict = functionforcategory()
        fnct = fnctndict[analysiscategory]
        #@info("Function is ", fnct)
        # Depends on what is regular, what is irregular!
        formcode = ""
        if analysiscategory == "irregular"
            formcode = fnct(stemdata) |> formurn
        elseif analysiscategory == "uninflected"
            formcode = fnct(inflclass) |> formurn
        elseif analysiscategory == "pronoun"
            formcode = fnct(stemdata) |> formurn
        else
            formcode =  string(ruledata) |> fnct |> formurn
        end
        
        Analysis(string(tkn,ending), LexemeUrn(lexidval), formcode, StemUrn(stemidval), RuleUrn(ruleidval))
end


"""Parse a string of FST output for a single token
to a list of `Analysis` objects.


$(SIGNATURES)
"""
function parsefst(fststring::AbstractString)
    analyses = Analysis[]
    lines = split(fststring,"\n")
    if  length(lines) < 2
        msg = string("parsefst: bad FST string ", fststring, " with ", length(lines), " lines." )
        throw(ArgumentError(msg))
    elseif startswith(lines[2], "no result")
        # let analyses stay empty
    else
        # skip header line and empty lines
        for ln in filter(l -> ! isempty(l), lines[2:end])
            push!(analyses, analysisforline(ln))
        end
    end
    analyses
end

"""Apply a parser to a token using `fst-infl`.
Suppress standard error since this generates show-stopping IO demands if routed to terminal.

$(SIGNATURES)
"""
function applyparser(tkn::AbstractString, parser::KanonesParser )
    fstinfl = fstinflpath()
    echo = echopath()
    cmd1 = `$echo $tkn` 
    cmd2 = `$fstinfl $(parser.sfstpath)`

    err = Pipe()
    rslt = pipeline(cmd1, stdout = cmd2, stderr = err)  |> read |> String
    close(err.in)
    rslt
end

"""Parse a single token to an array of `Analysis` or `nothing`.

$(SIGNATURES)
"""
function parsetoken(tkn::AbstractString, parser::KanonesParser; data = nothing)
    stripped = FstBuilder.fstgreek(tkn) |> lowercase
    applyparser(stripped, parser) |> parsefst
end