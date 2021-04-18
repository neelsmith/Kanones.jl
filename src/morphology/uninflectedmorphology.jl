
"""Uninflected forms have a single property: the "part of speech"."""
struct UninflectedForm <: MorphologicalForm
    pos::Int64
    poslabel::AbstractString    
end


"""Create `UninflectedForm` from a URN.

$(SIGNATURES)
"""
function uninflectedform(urn::Cite2Urn)
    c = objectcomponent(urn)[end]
    pos = parse(Int64, c)
    dict = valuedict(uninflectedpairs)
    poslabel = dict[pos]
    UninflectedForm(pos, poslabel)
end

"""Compose URN for an `UninflectedForm`.

$(SIGNATURES)
"""
function urn(uform::UninflectedForm)
    urnstring = string(BASE_MORPHOLOGY_URN, UNINFLECTED, "00000000", uform.pos)
    Cite2Urn(urnstring)
end

function abbrurn(rule::UninflectedRule)
    posdict = labeldict(uninflectedpairs)
    # PosPNTMVGCDCat
    FormUrn(string("morphforms.", UNINFLECTED,"00000000",posdict[rule.infltype]))

end

"""Compose URN for an `UninflectedForm`.

$(SIGNATURES)
"""
function cex(uform::UninflectedForm)
    urnval = urn(uform).urn
    string(urnval,"|uninflected form: ", uform.poslabel)
end

"""Compose Abbreviated URN for uninflected form from FST representation of analytical data.

$(SIGNATURES)
"""
function uninflectedabbrurn(fstdata)
    #s = replace(fstdata, r"[<>]" => "")
    uninflrulere = r"<([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(uninflrulere, fstdata))
    #@warn("UNINFL MATHCED " * matchedup)

    if isempty(matchedup)
        @warn("uninflectedurn: unable to parse FST analysis \"" * fstdata * "\"")
        nothing
    else
        # 1="h_hs", 2="noun", 3="feminine", 4="accusative", 5="singular")

        (uninflclass, ruleid) = matchedup[1].captures
        
        dict = labeldict(uninflectedpairs)
        FormUrn(string("morphforms.", UNINFLECTED, "00000000", dict[uninflclass]))
    end
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

