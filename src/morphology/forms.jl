"""Abstract type of a morphological form in Kanones."""
abstract type GreekMorphologicalForm end

"""Generic function to convert form information in a `GreekMorphologicalForm`
to a `FormUrn`.

$(SIGNATURES)
"""
function formurn(form::T) where {T <: FormUrn}
    @warn "Function formurn not implemented for type $typeof(form)."
    nothing
end

"""Generic function to convert form information in a `Rule` to a `RuleUrn`.

$(SIGNATURES)
"""
function ruleurn(rule::T) where {T <: RuleUrn}
    @warn "Function ruleurn not implemented for type $typeof(rule)."
    nothing
end

const BASE_MORPHOLOGY_URN = "urn:cite2:kanones:morphforms.v1:"


"""Compose CEX representation of CITE colletion of all recognized forms.

$(SIGNATURES)

Currently, includes only:
- unanalyzed forms
- uninflected forms
- noun forms
- inflected verb forms
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
 

"""Convert a `GreekMorphologicalForm` to a Cite2Urn.

$(SIGNATURES)

All subclasses of `GreekMorphologicalForm` should implement this specifically
for their subclass.
"""
function urn(mf::T) where {T <: GreekMorphologicalForm}
    @warn("urn: unrecognized type of GreekMorphologicalForm.")
    nothing
end


"""Label for a form.

$(SIGNATURES)

All subclasses of `GreekMorphologicalForm` should implement this specifically for their subclass.
"""
function label(mf::T) where {T <: GreekMorphologicalForm}
    @warn("urn: unrecognized type of GreekMorphologicalForm.")
    nothing
end

"""Convert a `GreekMorphologicalForm` form to a delimited-text string. 

$(SIGNATURES)

All subclasses of `GreekMorphologicalForm` should implement this specifically
for their subclass.
"""
function cex(mf::T; delimiter = "|") where {T <: GreekMorphologicalForm}
    #@warn("cex: unrecognized type of GreekMorphologicalForm.")
    #nothing
    join([urn(mf), label(mf)], delimiter)
end
