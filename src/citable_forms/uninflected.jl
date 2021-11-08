#<u>uninflectedstems.n21618</u><u>lsj.n21618</u>γαρ<uninflected><particle><div><particle><uninflected><u>litgreek.indeclinable1</u>

"""Uninflected forms have a single property: the "part of speech"."""
struct UninflectedForm <: GreekMorphologicalForm
    pos::GMPUninflectedType  
end


"""Uninflected forms are citable by Cite2Urn"""
CitableTrait(::Type{UninflectedForm}) = CitableByCite2Urn()

"""Compose URN for an `UninflectedForm`.

$(SIGNATURES)
Required by `CitableTrait`.
"""
function urn(uform::UninflectedForm)
    urnstring = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", code(uform.pos))
    Cite2Urn(urnstring)
end



"""Compose a human-readable label for an `UninflectedForm`.

$(SIGNATURES)
Required by `CitableTrait`.
"""
function label(uform::UninflectedForm)
    label(uform.pos)
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
    pos = gmpUninflectedType(parse(Int64, codeString))
    uninflectedform(pos)
end

"""Create `UninflectedForm` from a Char.

$(SIGNATURES)
"""
function uninflectedform(ch::Char)
    pos = gmpUninflectedType(parse(Int64, ch))
    uninflectedform(pos)
end

"""Create `UninflectedForm` from an Int.

$(SIGNATURES)
"""
function uninflectedform(code::Int64)
    UninflectedForm(code)
end

"""Create `UninflectedForm` from an Analysis.

$(SIGNATURES)
"""
function uninflectedform(a::Analysis)
    uninflectedform(a.form)
end




"""Compose Abbreviated URN for uninflected form from value for part of speech.

$(SIGNATURES)
"""
function uninflectedfromfst(uninflclass)
    UninflectedForm(uninflclass) #, uninflclass)            
end

"""Compose a `FormUrn` for an `UninflectedForm`.

$(SIGNATURES)
"""
function formurn(uninflected::UninflectedForm)
    FormUrn(string("morphforms.", UNINFLECTED, "00000000", code(uninflected.pos)))
end


"""Compose CEX representation of URNs and labels for uninflected forms.

$(SIGNATURES)
"""
function uninflectedcex()
    lines = []
    sortedkeys = keys(uninflectedlabels)  |> collect |> sort 
    for k in sortedkeys
        s = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", k, "|", "uninflected form: ", sortedkeys[k])
        push!(lines, s)
    end
    join(lines, "\n")
end

