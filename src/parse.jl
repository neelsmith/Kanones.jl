

function fstinflpath()
    rawout = read(`which fst-infl`, String)
    replace(rawout, "\n" => "")
end

function echopath()
    rawout = read(`which echo`, String)
    replace(rawout, "\n" => "")
end

function parseuninflectedrule(rule, s)
    ruleid = RuleUrn(rule)
    UninflectedRule(ruleid, s)
end

function parseuninflectedstem(stem, lex, s)
    stemid = StemUrn(stem)
    lexid = LexemeUrn(lex)
    UninflectedStem(stemid, lexid, "FORM OF " * s)
end

"""Maps label for analytical type to function for
parsing FST rule expression for that type.
"""
function rulesfunctions()
    Dict(
        "uninflected" => Kanones.parseuninflectedrule
    )
end


function stemsfunctions()
    Dict(
        "uninflected" => Kanones.parseuninflectedstem
    )
end

function parsestem(s::AbstractString)
    println(s)
    
    stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
    pieces = collect(eachmatch(stemre, s))
    if length(pieces) != 1
        throw(ArgumentError( string("Invalid FST stem expression ", s)))
    else
        (stemid, lexid, tkn, datatype, data) = pieces[1].captures
    end
    fnctdict = stemsfunctions()
    stemfnct = fnctdict[datatype]
    stemfnct(stemid, lexid, data)
end

function parsefst(fststring::AbstractString)
    lines = split(fststring,"\n")
    if ! (length(lines) == 2)
        throw(ArgumentError("parsefst: bad FST string " * fststring))
    end

    (stem, rule) = split(lines[2], "<div>")

    (parsestem(stem), rule) #parserule(rule))
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