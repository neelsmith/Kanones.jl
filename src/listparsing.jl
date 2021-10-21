
function applyparser(vocablist, parser::KanonesParser) 
    f = tempname()
    write(f, join(vocablist,"\n") * "\n")
    fstinfl = fstinflpath()
    cmd = `$fstinfl $(parser.sfstpath) $f`
    @info("List size ", length(vocablist))
    err = Pipe()
    rslt = pipeline(cmd, stderr = err)  |> read |> String
    close(err.in)
    rslt
end

"""Parse a string of FST output for multiple tokens
to a list of `Analysis` objects.

$(SIGNATURES)
"""
function parsefst_multi(fst::AbstractString)
    lines = split(fst,"\n")
    popped = []
    current = []
    term = ""
    for ln in lines
        if startswith(ln, ">")
            if isempty(current)
                term = replace(ln, "> " => "")
            else
                if ! isempty(current)
                    fstparse = Kanones.parsefst(join(current, "\n"))
                    isempty(fstparse) ? push!(popped, (term, Analysis[])) : push!(popped, (term, fstparse))
                    # Reset:
                    current = []
                    term = replace(ln, "> " => "")
                end
            end   
        end
        push!(current, ln)
    end
    # Catch final entry:
    fstparse = Kanones.parsefst(join(current, "\n"))
    isempty(fstparse) ? push!(popped, (term, Analysis[])) : push!(popped, (term, fstparse))

    popped |> Dict
end



"""Override implementation in `CitableParser`.

$(SIGNATURES)
Returns a Dict mapping strings to a (possibly empty) vector of `Analysis` objects.
"""
function parsewordlist(vocablist, parser::KanonesParser; data = nothing, countinterval = 100) 
    stripped = FstBuilder.fstgreek.(vocablist) 
    applyparser(stripped, parser) |> parsefst_multi
end



"""Override implementation in `CitableParserBuilder`.

$(SIGNATURES)

Should return a list of `AnalyzedToken`s.
"""
function parsedocument(doc::CitableDocument, p::KanonesParser; data = nothing, countinterval = 100) 
    @info("Document size ", length(doc.passages) )
    words = map(psg -> psg.text, doc.passages) |> unique
    parsedict = parsewordlist(words, p, countinterval = countinterval)

    keylist = keys(parsedict)
    results = AnalyzedToken[]
    for psg in doc.passages
        if psg.text in keylist
            at = AnalyzedToken(psg, parsedict[psg.text])
            push!(results, at)
        else
            at = AnalyzedToken(psg, AnalyzedToken[])
            push!(results, at)
        end
    end
    results
end




"""Override implementation in `CitableParserBuilder`.

$(SIGNATURES)

Should return a list of `AnalyzedToken`s.
"""
function parsecorpus(c::CitableTextCorpus, p::KanonesParser; data = nothing, countinterval = 100) 
    @info("Corpus size ", length(c.passages) )
    words = map(psg -> psg.text, c.passages) |> unique
    parsedict = parsewordlist(words, p, countinterval = countinterval)

    keylist = keys(parsedict)
    results = AnalyzedToken[]
    for psg in c.passages
        if psg.text in keylist
            at = AnalyzedToken(psg, parsedict[psg.text])
            push!(results, at)
        else
            at = AnalyzedToken(psg, AnalyzedToken[])
            push!(results, at)
        end
    end
    results
end

