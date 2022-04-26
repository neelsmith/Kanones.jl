"""Uninflected forms have a single property: the "part of speech"."""
struct GMFUninflected <: GreekMorphologicalForm
    pos::GMPUninflectedType  
end

"""Uninflected forms are citable by Cite2Urn"""
CitableTrait(::Type{GMFUninflected}) = CitableByCite2Urn()


"""Extract "part of speech" type from `uform`.
$(SIGNATURES)
"""
function gmpUninflectedType(uform::GMFUninflected)
    uform.pos
end

"""Compose digital code for `uform`.
$(SIGNATURES)
"""
function code(uform::GMFUninflected)
    string(UNINFLECTED, "00000000", code(uform.pos))
end

"""Compose URN for an `GMFUninflected`.

$(SIGNATURES)
Required by `CitableTrait`.
"""
function urn(uform::GMFUninflected)
    Cite2Urn(BASE_MORPHOLOGY_URN * code(uform) )
end

"""Compose a human-readable label for an `GMFUninflected`.

$(SIGNATURES)
Required by `CitableTrait`.
"""
function label(uform::GMFUninflected)
    "uninflected form: " * label(uform.pos)
end

"""Create `GMFUninflected` from a Cite2Urn.

$(SIGNATURES)
"""
function gmfUninflected(urn::Cite2Urn)
    c = objectcomponent(urn)[end]
    pos = parse(Int64, c)
    GMFUninflected(gmpUninflectedType(pos))
end

"""Create `GMFUninflected` from a FormUrn.

$(SIGNATURES)
"""
function gmfUninflected(u::FormUrn)
    c = u.objectid[end]
    GMFUninflected(gmpUninflectedType(parse(Int64,c)))
end

"""Create `GMFUninflected` from a string value.

$(SIGNATURES)
"""
function gmfUninflected(codeString::AbstractString)
    morphchars = split(codeString, "")    
    pos = parse(Int64, morphchars[10])
    GMPUninflectedType(pos) |> GMFUninflected
end

"""Create `GMFUninflected` from a Char.

$(SIGNATURES)
"""
function gmfUninflected(ch::Char)
    pos = gmpUninflectedType(parse(Int64, ch))
    gmfUninflected(pos)
end

"""Create `GMFUninflected` from an Int.

$(SIGNATURES)
"""
function gmfUninflected(code::Int64)
    GMFUninflected(code)


end

"""Create `GMFUninflected` from an Analysis.

$(SIGNATURES)
"""
function gmfUninflected(a::Analysis)
    gmfUninflected(a.form)
end




"""Compose Abbreviated URN for uninflected form from value for part of speech.

$(SIGNATURES)
"""
function uninflectedfromfst(uninflclass)
    GMFUninflected(gmpUninflectedType(uninflclass)         )
end

"""Compose a `FormUrn` for an `GMFUninflected`.

$(SIGNATURES)
"""
function formurn(uninflected::GMFUninflected)
    FormUrn(string("$(COLLECTION_ID).", UNINFLECTED, "00000000", code(uninflected.pos)))
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

