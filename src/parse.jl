

function fstinflpath()
    rawout = read(`which fst-infl`, String)
    replace(rawout, "\n" => "")
end

function echopath()
    rawout = read(`which echo`, String)
    replace(rawout, "\n" => "")
end

function parseuninflectedrule(rule, s)
    "Wahoo it's uninflected " * s
    
    ruleid = RuleUrn(rule)
    UninflectedRule(ruleid, s)


end

"""Maps label for analytical type to function for
parsing FST rule expression for that type.
"""
function rulesfunctions()
    Dict(
        "uninflected" => Kanones.parseuninflectedrule
    )
end

function parserule(s::AbstractString)
    #println(s)
    rulesre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
    pieces = collect(eachmatch(rulesre, s))
    if length(pieces) != 1
        throw(ArgumentError("Invalid FST rule expression ", s))
    else
        (ruleid, lexid, tkn, datatype, data) = pieces[1].captures
    end
    fnctdict = rulesfunctions()
    rulefnct = fnctdict[datatype]
    rulefnct(ruleid,  data)
end

function parsefst(fststring::AbstractString)
    lines = split(fststring,"\n")
    (stem, rule) = split(lines[2], "<div>")
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