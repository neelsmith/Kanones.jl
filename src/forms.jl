# Model:
# PosPNTMVGCDCat

const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3

function formscex()
    unanalyzed = "urn:cite2:kanones:morphforms.v1:0000000000|unanalyzed form"
    
    allentries = [
        unanalyzed,
        uninflectedcex()
    ]
    join(allentries, "\n") # |> Iterators.flatten |> collect
end
 
function valuedict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[1] => pr[2])
    end
    dict
end

function labeldict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[2] => pr[1])
    end
    dict
end



const pospairs = [
    (UNANALYZED, "unanalyzed"),
    (UNINFLECTED, "uninflected"),
    (NOUN, "noun"),
    (FINITEVERB, "verb-finite")
]


const uninflectedpairs = [
    (1, "conjunction"),
    (2, "preposition"),
    (3, "particle"),
    (4, "numeral"),
    (5, "interjection")
]

function uninflectedcex()
    baseurn = "urn:cite2:kanones:morphforms.v1:"
    dict = valuedict(uninflectedpairs)
    lines = []
    sortedkeys = keys(dict)  |> collect |> sort 
    for k in sortedkeys
        s = string(baseurn, UNINFLECTED, "00000000", k, "|", "uninflected form: ", dict[k])
        push!(lines, s)
    end
    join(lines, "\n")
end

function uninflectedurn(data)
    s = replace(data, r"[<>]" => "")
    dict = labeldict(uninflectedpairs)
    string("morphforms.", UNINFLECTED, "00000000", dict[s])
end