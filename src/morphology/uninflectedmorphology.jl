
"""Uninflected forms have a single property: the "part of speech"."""
struct UninflectedForm <: MorphologicalForm
    pos::Int64
    poslabel::AbstractString    
end


"""Create `UninflectedForm` from a URN."""
function uninflectedform(urn::Cite2Urn)
    c = objectcomponent(urn)[end]
    pos = parse(Int64, c)
    dict = valuedict(uninflectedpairs)
    poslabel = dict[pos]
    UninflectedForm(pos, poslabel)
end

"""Compose URN for an `UninflectedForm`."""
function urn(uform::UninflectedForm)
    urnstring = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", uform.pos)
    Cite2Urn(urnstring)
end


"""Compose URN for an `UninflectedForm`."""
function cex(uform::UninflectedForm)
    urnval = urn(uform).urn
    string(urnval,"|uninflected form: ", uform.poslabel)
end

"""Compose URN for uninflected form from FST representation of analytical data."""
function uninflectedurn(fstdata)
    s = replace(fstdata, r"[<>]" => "")
    dict = labeldict(uninflectedpairs)
    string("morphforms.", UNINFLECTED, "00000000", dict[s])
end

"""Compose CEX representation of URNs and labels for uninflected forms."""
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

