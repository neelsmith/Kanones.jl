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
        stemmatch = collect(eachmatch(stemre, FstBuilder.greekfromfst(stem)))
        (stemidval, lexidval, tkn, stemtype, stemdata) = stemmatch[1].captures
        
        # Rule part of SFST also has a regular structure:
        # 
        rulere = r"<([^>]+)><([^>]+)>([^<]*)(.*)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (inflclass, analysiscategory, ending, ruledata, ruleidval) = rulematch[1].captures
  
        fnctndict = functionforcategory()
        fnct = fnctndict[analysiscategory]
        # Depends on what is regular, what is irregular!
        formcode = ""
        if analysiscategory == "irregular"
            formcode = fnct(stemdata) |> formurn
        elseif analysiscategory == "uninflected"
            formcode = fnct(inflclass) |> formurn
        else
            formcode =  string(ruledata) |> fnct |> formurn
        end
        
        Analysis(string(tkn,ending), LexemeUrn(lexidval), formcode, RuleUrn(ruleidval), StemUrn(stemidval))
end

"""Parse a string of FST output for a single token
to a list of `Analysis` objects.


$(SIGNATURES)
"""
function parsefst(fststring::AbstractString)
    analyses = []
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
        #=
        (stem, rule) = split(lines[2], "<div>")

        stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
        stemmatch = collect(eachmatch(stemre, FstBuilder.greekfromfst(stem)))
        (stemidval, lexidval, tkn, analysiscat, stemdata) = stemmatch[1].captures
        
        rulere = r"(<[^>]+><[^>]+>)([^<]*)(.*)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (typeinfo, ending, ruledata, ruleidval) = rulematch[1].captures
    
        #@warn("ENDING " * ending)
        #@warn("RULEDATA " * ruledata)
        #@warn("RULEID " * ruleidval)
        

        fnctndict = functionforcategory()
        fnct = fnctndict[analysiscat]
        formurn =  string(typeinfo, ending, ruledata) |> fnct
        
        Analysis(string(tkn,ending), LexemeUrn(lexidval), formurn, RuleUrn(ruleidval), StemUrn(stemidval))
        =#
    end
    analyses
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