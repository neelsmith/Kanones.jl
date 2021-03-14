# Model:
# PosPNTMVGCDCat

const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3


"""Compose CEX representation of CITE colletion of all recognized forms.

Currently, includes unanlyzed and uninfleted forms only.
"""
function formscex()
    unanalyzed = "urn:cite2:kanones:morphforms.v1:0000000000|unanalyzed form"
    
    allentries = [
        unanalyzed,
        uninflectedcex()
    ]
    join(allentries, "\n") # |> Iterators.flatten |> collect
end
 

"""Compose CEX representation of URNs and lables for uninflected forms."""
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