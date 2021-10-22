
"""Uses the external `fst-infl` command to apply `parser` to a list of vocabulary, and returns the string output of `fst-infl`.

$(SIGNATURES)
"""
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
Returns a Dict mapping strings to a (possibly empty) vector of `Analysis` objects.
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

    failed = filter(pr -> isempty(pr[2]), popped)
    @info("Failed on ", length(failed))

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


"""Parses a list of `CitablePassage`s to `AnalyzedToken`s,
using the given parser and orthographic system.
"""
function parsepassagelist(psgs, p, ortho = literaryGreek())
    words = map(psg -> psg.text, psgs) |> unique
    # Map accented to unaccented form:
    wordsmap = []
    for w in words
        push!(wordsmap, (w, rmaccents(w, ortho)))
    end
    wordsdict = wordsmap |> Dict
    # Parse stripped form of word, then...
    parsedict = parsewordlist(values(wordsdict), p)
    # Use wordsdict to map analyses onto fully accented
    # passage text:
    keylist = keys(parsedict)
    results = AnalyzedToken[]
    for psg in psgs
        stripped = rmaccents(psg.text, ortho)
        if stripped in keylist
            at = AnalyzedToken(psg, parsedict[stripped])
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
function parsedocument(doc::CitableDocument, p::KanonesParser; data = literaryGreek(), countinterval = 100) 
    @info("Document size ", length(doc.passages) )
    parsepassagelist(doc.passages, p, data)
end


"""Override implementation in `CitableParserBuilder`.

$(SIGNATURES)

Should return a list of `AnalyzedToken`s.
"""
function parsecorpus(c::CitableTextCorpus, p::KanonesParser; data = literaryGreek(), countinterval = 100) 
    @info("Corpus size ", length(c.passages) )
    parsepassagelist(c.passages, p, data)
end

