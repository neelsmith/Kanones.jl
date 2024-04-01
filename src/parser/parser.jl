"""Abstract type of a morphological parser."""
abstract type KanonesParser <: CitableParser end

"""Parse a single token `s` using parser `p`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, p::T) where {T <: KanonesParser}
    @warn("Function parsetoken is not implemented for type $(typeof(p))")::Vector{Analysis}
    []
end


"""Parse a list of tokens using parser `parser`.

$(SIGNATURES)
Returns a Dict mapping strings to a (possibly empty) vector of `Analysis` objects.
"""
function parsewordlist(vocablist, parser::KanonesParser; data = nothing, countinterval = 100) 
    @info("Parsing list of $(length(vocablist)) tokens.")
    parses = []
    for (i,s) in enumerate(vocablist)




        push!(parses, parsetoken(s, parser))
        if i % countinterval == 0
            @info("$(i) ($(s))...")
        end
    end
    parses
end


function lexemes(p::T) where {T <: KanonesParser}
    @warn("Function lexemes is not implemented for type $(typeof(p))")
    []
end


"""For a surface string `s`, compose one or more strings normalized
for anlaysis by a Kanones parsers using the given orthography.
$(SIGNATURES)    
"""
function resolvestring(s, ortho = literaryGreek())
    v = crasis(s, ortho)
    
    map(str -> knormal(str, ortho), v)
    
end



function formlabels(v; wordlist = [])
    labels = [parse .|> greekForm .|> label  for parse in v]
    labelstrings = map(v -> join(v, "; "), labels)
    if isempty(wordlist)
        labelstrings
    else
        prs = zip(wordlist, labelstrings) |> collect
        map(prs) do pr
            string(pr[1],": ", pr[2])
        end  
    end
end

function formlabels(wordlist, p::KanonesParser)
    parses = parsewordlist(wordlist, p)
    labels = [parse .|> greekForm .|> label  for parse in parses]
    labelstrings = map(v -> join(v, "; "), labels)
    if isempty(wordlist)
        labelstrings
    else
        prs = zip(wordlist, labelstrings) |> collect
        map(prs) do pr
            string(pr[1],": ", pr[2])
        end  
    end
end
