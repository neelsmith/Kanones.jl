"""Abstract type of a morphological form in Kanones."""
abstract type GreekMorphologicalForm end

const COLLECTION_ID = "forms"
const BASE_MORPHOLOGY_URN = "urn:cite2:kanones:$(COLLECTION_ID).v1:"

"""Greek morphological forms are citable by Cite2Urn"""
CitableTrait(::T) where {T <: GreekMorphologicalForm} = CitableByCite2Urn()

"""Convert a `GreekMorphologicalForm` to a Cite2Urn.

$(SIGNATURES)

All subclasses of `GreekMorphologicalForm` should implement this specifically for their subclass.
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
"""
function cex(mf::T; delimiter = "|") where {T <: GreekMorphologicalForm}
    join([urn(mf), label(mf)], delimiter)
end

"""Return Kanones code for analytical type
encoded in first digit of `codestring`.
$(SIGNATURES)
"""
function poscode(codestring::AbstractString)
    parse(Int32, codestring[1])
end

# TEST THIS OUT!!
function greekForm(codestr::AbstractString)
    if poscode(codestr) == ADJECTIVE
        gmfAdjective(codestr)
    elseif poscode(codestr) == NOUN
        gmfNoun(codestr)
    end
end

"""Create a `GreekMorphologicalForm` from a `FormUrn`.
$(SIGNATURES)
"""
function greekForm(u::CitableParserBuilder.FormUrn)
    greekForm(CitableParserBuilder.objectid(u))
end

#=
"""Create a `GreekMorphologicalForm` from a `FormUrn`.
$(SIGNATURES)
"""
function greekForm(u::CitableParserBuilder.FormUrn)
    if poslabel(u) == "noun"
        gmfNoun(u)
    elseif poslabel(u)== "pronoun"
        gmfPronoun(u)
    elseif poslabel(u) == "adjective"
        gmfAdjective(u)
    
    elseif poslabel(u)== "verb-finite"
        gmfFiniteVerb(u)
    elseif poslabel(u)== "infinitive"
        gmfInfinitive(u)
    elseif poslabel(u)== "participle"
        gmfParticiple(u)
    elseif poslabel(u)== "verbal-adjective"
        gmfVerbalAdjective(u)

    elseif poslabel(u)== "adverb"
        throw(DomainError("Unrecognized PoS $(poslabel(u)) from $(u)"))
 
    elseif poslabel(u) == "uninflected"
        gmfUninflected(u)
        
    else
        throw(DomainError("Unrecognized PoS $(poslabel(u)) from $(u)"))
    end
end

"""Create a `GreekMorphologicalForm` from a `u`, a `Cite2Urn` identifying a form.
$(SIGNATURES)
"""
function greekForm(u::Cite2Urn)
    greekForm(abbreviate(u))
end


"""Create a `GreekMorphologicalForm` from the string value of a `FormUrn`.
$(SIGNATURES)
"""
function greekForm(s::AbstractString)
    greekForm(CitableParserBuilder.FormUrn(s))
end

"""Create a `GreekMorphologicalForm` from the `FormUrn` in `a`.
$(SIGNATURES)
"""
function greekForm(a::Analysis)
    greekForm(a.form)
end

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
=#