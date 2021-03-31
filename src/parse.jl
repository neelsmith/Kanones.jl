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
function functionfollowsform()
    Dict(
        "uninflected" => Kanones.uninflectedabbrurn,
        "noun" => Kanones.nounabbrurn
    )
end

"""Parse a string of FST output for a single token
to a list of `Analysis` objects.


$(SIGNATURES)
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
        
        rulere = r"(<[^>]+><[^>]+>)([^<]*)(.*)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (typeinfo, ending, ruledata, ruleidval) = rulematch[1].captures
        #=
        @warn("ENDING " * ending)
        @warn("RULEDATA " * ruledata)
        @warn("RULEID " * ruleidval)
        =#

        fnctndict = functionfollowsform()
        fnct = fnctndict[analysiscat]
        formurn =  string(typeinfo, ending, ruledata) |> fnct
        
        Analysis(string(tkn,ending), LexemeUrn(lexidval), formurn, RuleUrn(ruleidval), StemUrn(stemidval))
    end
end

"""Apply a parser to a token using `fst-infl`.

$(SIGNATURES)
"""
function applyparser(parser, tkn::AbstractString)
    fstinfl = fstinflpath()
    echo = echopath()
    cmd = pipeline(`$echo $tkn`, `$fstinfl $parser`)
    rslt = read(cmd, String)
end

"""Parse a single token to an array of `Analysis` or `nothing`.

$(SIGNATURES)
"""
function parsetoken(parser, tkn::AbstractString)
    stripped = FstBuilder.fstgreek(tkn) 
    applyparser(parser, stripped) |> parsefst
end


"""Parse a list of words.

$(SIGNATURES)

NOT YET IMPLEMENTED.
"""
function parsewordlist(parser, tokens)
    nothing
end