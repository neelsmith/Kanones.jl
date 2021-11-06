
"A record for a single uninflected stem."
struct UninflectedStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    stemcategory::AbstractString
end

"""Identify identifier URN for an `UninflectedStem`.

$(SIGNATURES)
"""
function id(uninfl::UninflectedStem)
    uninfl.stemid
end

"""Identify lexeme URN for an `UninflectedStem`.

$(SIGNATURES)
"""
function lexeme(uninfl::UninflectedStem)
    uninfl.lexid
end


"""Implementation of reading one row of a stems table for uninflected tokens.


$(SIGNATURES)
"""
function readstemrow(usp::UninflectedParser, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 4
        msg = "Invalid syntax for uninflected stem: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        form = parts[3] # fstgreek(parts[3])
        stemclass = parts[4]
        UninflectedStem(stemid, lexid, form, stemclass)
    end
end
