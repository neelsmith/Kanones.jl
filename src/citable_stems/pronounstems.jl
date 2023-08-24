"A record for a single noun stem."
struct PronounStem <: KanonesStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    pgender::GMPGender
    pcase::GMPCase
    pnumber::GMPNumber
    pronountype
end
#pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article


function pos(pron::PronounStem)
    :pronoun
end


"""Identify gender of `pr`.
$(SIGNATURES)
"""
function gmpGender(pr::PronounStem)
    pr.pgender
end


"""Identify case of `pr`.
$(SIGNATURES)
"""
function gmpCase(pr::PronounStem)
    pr.pcase
end


"""Identify number of `pr`.
$(SIGNATURES)
"""
function gmpNumber(pr::PronounStem)
    pr.pnumber
end

"""
Read one row of a stems table for noun tokens and create a `PronounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::PronounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    gndr = gmpGender(parts[4])
    cs = gmpCase(parts[5])
    nmbr = gmpNumber(parts[6])
    inflclass = parts[7]
 
    PronounStem(stemid, lexid, stem,gndr, cs, nmbr,inflclass)
end



"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{PronounStem}) = CitableByCite2Urn()


"""Identify value of stem string for `pr`.
$(SIGNATURES)
"""
function stemstring(pr::PronounStem)
    pr.form |> knormal
end

"""Identify lexeme for `pr`.
$(SIGNATURES)
"""
function lexeme(pr::PronounStem)
    pr.lexid
end

"""Identify inflection class for `pr`.
$(SIGNATURES)
"""
function inflectionclass(pr::PronounStem)
    pr.pronountype
end



"""Human-readlable label for a `PronounStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pns::PronounStem)
    
    formlist = join([label(pns.pgender), label(pns.pcase), label(pns.pnumber)], ", ")
    string("Stem ", pns.form, " (", pns.pronountype, ": ", formlist, ")")
end



"""Identifying URN for a `PronounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
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

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(pns::PronounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([pns.stemid, label(pns), stemstring(pns), lexeme(pns), inflectionclass(pns), label(pns.pgender), label(pns.pcase), label(pns.pnumber) ], delimiter)
    else
        c2urn = expand(pns.stemid, registry)
        join([c2urn, label(pns), stemstring(pns), lexeme(pns), inflectionclass(pns), label(pns.pgender), label(pns.pcase), label(pns.pnumber) ], delimiter)
    end
end


"""Compose a digital code string for the form identified in `pns`.
$(SIGNATURES)
"""
function code(pns::PronounStem)
      # PosPNTMVGCDCat
     string( PRONOUN,"0",code(pns.pnumber),"000",code(pns.pgender),code(pns.pcase),"00")
end


"""Compose an abbreviated URN for a rule from a `PronounStem`.

$(SIGNATURES)
"""
function formurn(pns::PronounStem)
    FormUrn("$(COLLECTION_ID)." * code(pns))
end



function greekForm(pronoun::PronounStem) 
    formurn(pronoun) |> greekForm
end