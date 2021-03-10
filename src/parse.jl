
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

function parseuinflectedfst(data)
    "UNINFLECTED WITH CAT " * data
end

function functionfollowsform()
    Dict(
        "uninflected" => Kanones.parseuinflectedfst
    )
end

function parsefst(fststring::AbstractString)
    lines = split(fststring,"\n")
    if  length(lines) < 2
        msg = string("parsefst: bad FST string ", fststring, " with ", length(lines), " lines." )
        throw(ArgumentError(msg))
    end
    (stem, rule) = split(lines[2], "<div>")

    stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
    stemmatch = collect(eachmatch(stemre, stem))
    (stemidval, lexidval, tkn, analysiscat, stemdata) = stemmatch[1].captures
    
    rulere = r"(.+)<([^>]+)><u>(.+)</u>"
    rulematch = collect(eachmatch(rulere, rule))
    (ruledata, rulecat, ruleidval) = rulematch[1].captures
    fnctndict = functionfollowsform()
    fnct = fnctndict[analysiscat]
    formid =  ruledata |> fnct
    Analysis(tkn, LexemeUrn(lexidval), formid, RuleUrn(ruleidval), StemUrn(stemidval))
end


function parsetoken(parser, tkn::AbstractString)
  applyparser(parser, tkn) |> parsefst
end

"""Apply a parser to a token using fst-infl.
"""
function applyparser(parser, tkn::AbstractString)
    fstinfl = fstinflpath()
    echo = echopath()
    cmd = pipeline(`$echo $tkn`, `$fstinfl $parser`)
    rslt = read(cmd, String)
end