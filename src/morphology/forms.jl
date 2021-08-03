"""Abstract type of a morphological form."""
abstract type MorphologicalForm end

"""Generic function to convert form information in a `Rule`
to a `RuleUrn`.

$(SIGNATURES)
"""
function abbrurn(rule::T) where {T <: RuleUrn}
    @warn "Function abbrurn not implemented for type $typeof(rule)."
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
 

"""Convert a `MorphologicalForm` to a Cite2Urn.

$(SIGNATURES)

All subclasses of `MorphologicalForm` should implement this specifically
for their subclass.
"""
function urn(MorphologicalForm)
    @warn("urn: unrecognized type of MorphologicalForm.")
    nothing
end



"""Convert a `MorphologicalForm` form to a delimited-text string. 

$(SIGNATURES)

All subclasses of `MorphologicalForm` should implement this specifically
for their subclass.
"""
function cex(MorphologicalForm)
    @warn("cex: unrecognized type of MorphologicalForm.")
    nothing
end


"""Create a `MorphologicalForm` from a Cite2Urn value.

$(SIGNATURES)
"""
function morphform(urn::Cite2Urn)
    morphform(objectcomponent(urn))
end


"""Create a `MorphologicalForm` from a FormUrn.

$(SIGNATURES)
"""
function morphform(u::FormUrn)
    morphform(u.form)

end


"""Create a `MorphologicalForm` from an Analysis.

$(SIGNATURES)
"""
function morphform(a::Analysis)
    morphform(a.form)
end


"""Create a `MorphologicalForm` from an string value.

$(SIGNATURES)
"""
function morphform(code::AbstractString)
    c = code[1]
    if poskey == UNANALYZED
        nothing
    elseif poskey == UNINFLECTED
        uninflectedform(u)
    elseif poskey == NOUN
        nounform(u)
    elseif poskey == FINITEVERB
        finiteverbform(u)
    else
        @warn("morphform: unrecognized part of speech value in urn ", urn.urn)
        nothing
    end
end




"""Compose a human-readable lable for a morphological form identifier.

$(SIGNATURES)
"""
function labelform(s::AbstractString)
    #PosPNTMVGCDCat
    formcolumns = split(s,"")
    ivals = map(i -> parse(Int64,i), formcolumns)

    pos = parse(Int64, formcolumns[1])
 
    if pos == NOUN
        casedict = valuedict(casepairs)
        genderdict = valuedict(genderpairs)
        numberdict =  valuedict(numberpairs)
        "noun:  $(genderdict[ivals[7]]) $(casedict[ivals[8]]) $(numberdict[ivals[3]])"
        
    elseif pos == UNINFLECTED
        uninfldict = valuedict(uninflectedpairs)
        "uninflected $(uninfldict[ivals[10]])"

    elseif pos == FINITEVERB
        persondict = valuedict(personpairs)
        numberdict = valuedict(numberpairs)
        tensedict = valuedict(tensepairs)
        mooddict = valuedict(moodpairs)
        voicedict = valuedict(voicepairs)
        "inflected verb: $(persondict[ivals[2]]) $(numberdict[ivals[3]]) $(tensedict[ivals[4]]) $(mooddict[ivals[5]]) $(voicedict[ivals[6]])"

    else
        "UNRECOGNIZED analytical form: $pos"
    end
end

"""Compose a human-readable label for a `FormUrn`.

$(SIGNATURES)
"""
function labelform(furn::FormUrn)
    labelform(furn.objectid)
end


"""Compose a human-readable label for a `FormUrn`.

$(SIGNATURES)
"""
function labelform(furn::Cite2Urn)
    labelform(objectcomponent(furn))
end

