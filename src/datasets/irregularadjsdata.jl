"A record for a single irregular noun stem."
struct IrregularAdjectiveStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    adjgender
    adjcase
    adjnumber
    adjdegree
    #inflectionclass
end


"""
Read one row of a stems table for irregular adjective tokens and create an `AdjectiveStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularAdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)

    # Example:
    # "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    # 1. irregadj.n79904a
    # 2. lsj.n79904
    # 3. πᾶς
    # 4. masculine
    # 5. nominative
    # 6. singular
    # 7. positive
    # 8. irregularadjective
    if length(parts) < 8
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    g = parts[4]
    c = parts[5]
    n = parts[6]
    d = parts[7]
    inflclass = parts[8]

    IrregularAdjectiveStem(stemid,lexid,stem,g,c,n,d )#,inflclass)
end