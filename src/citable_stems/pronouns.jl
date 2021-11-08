"A record for a single noun stem."
struct PronounStem <: Stem
    stemid::Kanones.AbbreviatedUrn
    lexid::Kanones.AbbreviatedUrn
    form::AbstractString
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
    pronountype
end
#pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article

"""
Read one row of a stems table for noun tokens and create a `PronounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::PronounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    gndr = gmpGender(parts[4])
    cs = gmpCase(parts[5])
    nmbr = gmpNumber(parts[6])
    inflclass = parts[7]
 
    PronounStem(stemid, lexid, stem,gndr, cs, nmbr,inflclass)
end



"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{PronounStem}) = CitableByCite2Urn()

"""Human-readlable label for a `PronounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pns::PronounStem)
    
    formlist = join([label(pns.pgender), label(pns.pcase), label(pns.pnumber)], ", ")
    string("Stem ", pns.form, " (", pns.pronountype, ": ", formlist, ")")
end



"""Identifying URN for a `PronounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(pns::PronounStem; registry = nothing)
    if isnothing(registry)
        pns.stemid
    else
        expand(pns.stemid, registry)
    end
end


"""Compose CEX text for a `PronounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(pns::PronounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([pns.stemid, label(pns) ], delimiter)
    else
        c2urn = expand(pns.stemid, registry)
        join([c2urn, label(pns)], delimiter)
    end
end