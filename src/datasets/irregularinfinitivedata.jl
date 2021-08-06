"A record for a single irregular verb stem."
struct IrregularInfinitiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    tense
    voice
end


function readstemrow(usp::Kanones.IrregularInfinitiveParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)


    if length(parts) < 5
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    t = parts[4]
    v = parts[5]

    IrregularInfinitiveStem(stemid,lexid,stem,t,v)

end