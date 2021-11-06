"A record for a single irregular verb stem."
struct IrregularInfinitiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    tense
    voice
end


"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularInfinitiveStem}) = CitableByCite2Urn()
"""Human-readlable label for an `IrregularInfinitiveStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(inf::IrregularInfinitiveStem)
    string("Irregular infinitive form ", inf.form, " (", inf.tense," ", inf.voice, ")")
end

"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(inf::IrregularInfinitiveStem; registry = nothing)
    if isnothing(registry)
        inf.stemid
    else
        expand(inf.stemid, registry)
    end
end


"""Compose CEX text for an `IrregularInfinitiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(inf::IrregularInfinitiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([inf.stemid, label(inf) ], delimiter)
    else
        c2urn = expand(inf.stemid, registry)
        join([c2urn, label(inf)], delimiter)
    end
end



"""
Read one row of a stems table for irregular infinititve tokens and create an `IrregularInfinitiveStem`.

$(SIGNATURES)    
"""
function readstemrow(infinio::Kanones.IrregularInfinitiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)


    if length(parts) < 5
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    t = parts[4]
    v = parts[5]

    IrregularInfinitiveStem(stemid,lexid,stem,t,v)

end