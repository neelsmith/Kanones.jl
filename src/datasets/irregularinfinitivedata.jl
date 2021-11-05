"A record for a single irregular verb stem."
struct IrregularInfinitiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    tense
    voice
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