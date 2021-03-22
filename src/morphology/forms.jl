abstract type MorphologicalForm end

const BASE_MORPHOLOGY_URN = "urn:cite2:kanones:morphforms.v1:"


"""Compose CEX representation of CITE colletion of all recognized forms.

Currently, includes only:
- unanalyzed forms
- uninflected forms
- noun forms
"""
function formscex()
    unanalyzed = "urn:cite2:kanones:morphforms.v1:0000000000|unanalyzed form"
    
    allentries = [
        unanalyzed,
        uninflectedcex(),
        nounscex()
    ]
    join(allentries, "\n") # |> Iterators.flatten |> collect
end
 

"""Convert a `MorphologicalForm` to a Cite2Urn.

All subclasses of `MorphologicalForm` should implement this specifically
for their subclass.
"""
function urn(MorphologicalForm)
    @warn("urn: unrecognized type of MorphologicalForm.")
    nothing
end



"""Convert a `MorphologicalForm` form to a delimited-text string. 

All subclasses of `MorphologicalForm` should implement this specifically
for their subclass.
"""
function cex(MorphologicalForm)
    @warn("cex: unrecognized type of MorphologicalForm.")
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
    elseif poskey == NOUN
        nounform(urn)
    else
        @warn("morphform: unrecognized part of speech value in urn ", urn.urn)
        nothing
    end
    # NOUN
    # FINITEVERB
    # ktl...
end