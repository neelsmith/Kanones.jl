#<u>uninflectedstems.n21618</u><u>lsj.n21618</u>γαρ<uninflected><particle><div><particle><uninflected><u>litgreek.indeclinable1</u>
"""Uninflected forms have a single property: the "part of speech"."""
struct UninflectedForm <: MorphologicalForm
    pos::Int64
    #poslabel::AbstractString    
end


"""Create `UninflectedForm` from a Cite2Urn.

$(SIGNATURES)
"""
function uninflectedform(urn::Cite2Urn)
    c = objectcomponent(urn)[end]
    uninflectedform(c)
end

"""Create `UninflectedForm` from a FormUrn.

$(SIGNATURES)
"""
function uninflectedform(u::FormUrn)
    c = u.objectid[end]
    uninflectedform(c)
end

"""Create `UninflectedForm` from a string value.

$(SIGNATURES)
"""
function uninflectedform(codeString::AbstractString)
    pos = parse(Int64, codeString)
    uninflectedform(pos)
end

"""Create `UninflectedForm` from a Char.

$(SIGNATURES)
"""
function uninflectedform(ch::Char)
    pos = parse(Int64, ch)
    uninflectedform(pos)
end

"""Create `UninflectedForm` from an Int.

$(SIGNATURES)
"""
function uninflectedform(code::Int64)
    #dict = valuedict(uninflectedpairs)
    #poslabel = dict[code]
    UninflectedForm(code) #, poslabel)
end

"""Create `UninflectedForm` from an Analysis.

$(SIGNATURES)
"""
function uninflectedform(a::Analysis)
    uninflectedform(a.form)
end


"""Compose URN for an `UninflectedForm`.

$(SIGNATURES)
"""
function urn(uform::UninflectedForm)
    urnstring = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", uform.pos)
    Cite2Urn(urnstring)
end


#=
"""Compose URN for an `UninflectedForm`.

$(SIGNATURES)
"""
function cex(uform::UninflectedForm; delim="|")
    urnval = urn(uform).urn


    uninfldict = valuedict(uninflectedpairs)
    #string(urnval,"|uninflected form: ", uninfldict[])
    # 
    # NEED generic retrieval functions for Morphology string sequence.
    nothing
end
=#

"""Compose Abbreviated URN for uninflected form from value for part of speech.

$(SIGNATURES)
"""
function uninflectedfromfst(uninflclass)
    dict = labeldict(uninflectedpairs)
    code = dict[uninflclass]
    UninflectedForm(code) #, uninflclass)            
end

"""Compose a `FormUrn` for an `UninflectedForm`.

$(SIGNATURES)
"""
function formurn(uninflected::UninflectedForm)
    FormUrn(string("morphforms.", UNINFLECTED, "00000000", uninflected.pos))
end


"""Compose CEX representation of URNs and labels for uninflected forms.

$(SIGNATURES)
"""
function uninflectedcex()
    dict = valuedict(uninflectedpairs)
    lines = []
    sortedkeys = keys(dict)  |> collect |> sort 
    for k in sortedkeys
        s = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", k, "|", "uninflected form: ", dict[k])
        push!(lines, s)
    end
    join(lines, "\n")
end

