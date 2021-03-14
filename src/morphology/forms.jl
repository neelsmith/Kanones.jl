
abstract type MorphologicalForm end

const BASE_MORPHOLOGY_URN = "urn:cite2:kanones:morphforms.v1:"

# Model for URN values:
# PosPNTMVGCDCat
const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3

"""Constants for analytical types ("parts of speech")."""
const pospairs = [
    (UNANALYZED, "unanalyzed"),
    (UNINFLECTED, "uninflected"),
    (NOUN, "noun"),
    (FINITEVERB, "verb-finite")
]

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
 
"""Create a dictionary keyed by the value of a label-value pair."""
function valuedict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[1] => pr[2])
    end
    dict
end

"""Create a dictionary keyed by the label of a label-value pair."""
function labeldict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[2] => pr[1])
    end
    dict
end

"""Convert a `MorphologicalForm` to a URN.

All subclasses of `MorphologicalForm` should implement this specifically
for their subclass.
"""
function urn(MorphologicalForm)
    @warn("Unrecognized type of MorphologicalForm.")
    nothing
end


"""Create a `MorphologicalForm` from a URN value."""
function morphform(urn::Cite2Urn)
    c = objectcomponent(urn)[1]
    poskey = parse(Int64, c)

    if poskey == UNANALYZED
        nothing
    elseif poskey == UNINFLECTED
        uninflectedform(urn)
    else
        @warn("Unrecognized part of speech value in urn ", urn.urn)
        nothing
    end
    #urn:cite2:kanones:morphforms.v1:1000000001
    #warn("Unrecognized form in urn ", urn.urn)
    #nothing

#=
const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3
    =#
end