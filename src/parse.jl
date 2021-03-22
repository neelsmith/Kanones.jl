"""Find full path to `fst-infl`on your system.
"""
function fstinflpath()
    rawout = read(`which fst-infl`, String)
    replace(rawout, "\n" => "")
end

"""Find full path to `echo`on your system.
"""
function echopath()
    rawout = read(`which echo`, String)
    replace(rawout, "\n" => "")
end

"""Dict of functions to use with each analytical type
to determine FormUrn from FST description of form.
"""
function functionfollowsform()
    Dict(
        "uninflected" => Kanones.uninflectedabbrurn,
        "noun" => Kanones.nounabbrurn
    )
end

"""Parses a string of FST output for a single token
to an `Analysis`.
"""
function parsefst(fststring::AbstractString)
    lines = split(fststring,"\n")
    if  length(lines) < 2
        msg = string("parsefst: bad FST string ", fststring, " with ", length(lines), " lines." )
        throw(ArgumentError(msg))
    elseif startswith(lines[2], "no result")
        nothing
    else
        (stem, rule) = split(lines[2], "<div>")
        stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
        stemmatch = collect(eachmatch(stemre, FstBuilder.greekfromfst(stem)))
        (stemidval, lexidval, tkn, analysiscat, stemdata) = stemmatch[1].captures
        
        rulere = r"(.+)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (ruledata, ruleidval) = rulematch[1].captures
        #@warn("PARSING RULE " * rule)
        #@warn("Rule parts data " * ruledata * ",  id " * ruleidval)
        fnctndict = functionfollowsform()
        fnct = fnctndict[analysiscat]
        formurn =  ruledata |> fnct
        Analysis(tkn, LexemeUrn(lexidval), formurn, RuleUrn(ruleidval), StemUrn(stemidval))
    end
end

"""Applies a parser to a token using fst-infl.
"""
function applyparser(parser, tkn::AbstractString)
    fstinfl = fstinflpath()
    echo = echopath()
    cmd = pipeline(`$echo $tkn`, `$fstinfl $parser`)
    rslt = read(cmd, String)
end

"""Parses a single token to an `Analysis` or `nothing`.
"""
function parsetoken(parser, tkn::AbstractString)
    stripped = FstBuilder.fstgreek(tkn) 
    applyparser(parser, stripped) |> parsefst
end

function parsewordlsit(parser, tokens)
    nothing
end