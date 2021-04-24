"A record for a single irregular noun stem."
struct IrregularNounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    gender
    gcase
    gnumber
    inflectionclass
end



"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularNounParser, delimited::AbstractString, delimiter = "|")
    parts = split(delimited, delimiter)

    # Example:
    #irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun
    # 1. irregnoun.irregn23069a|
    # 2. ls.n23069|
    # 3. γυνή|
    # 4. feminine
    # 5. nominative
    # 6. singular
    # 7. irregularnoun
    if length(parts) < 7
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = Kanones.StemUrn(parts[1])
    lexid = Kanones.LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    g = parts[4]
    c = parts[5]
    n = parts[6]
    inflclass = parts[7]

    IrregularNounStem(stemid,lexid,stem,g,c,n,inflclass)
end


function fst
end