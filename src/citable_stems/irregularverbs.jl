"A record for a single irregular verb stem."
struct IrregularVerbStem <: Stem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    vperson
    vnumber
    vtense
    vmood
    vvoice
end
#irregverb.irregverbnn26447a|lsj.n26447|δίδωσι|
#third|singular|present|indicative|active|irregularverb

function readstemrow(usp::Kanones.IrregularVerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    # Example:
    #irregverb.irregverbnn26447b|lsj.n26447|διδόασι|third|plural|present|indicative|active|irregularverb

   
    # 1. irregverb.irregverbnn26447b|
    # 2. lsj.n26447|
    # 3. διδόασι|
    # 4. third
    # 5. plural
    # 6. present
    # 7. indicative
    # 8. active
    # 9. irregularverb
    if length(parts) < 9
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    p = parts[4]
    n = parts[5]
    t = parts[6]
    m = parts[7]
    v = parts[8]

    IrregularVerbStem(stemid,lexid,stem,p,n,t,m,v)

end