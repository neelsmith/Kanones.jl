"A record for a single irregular noun stem."
struct IrregularAdjectiveStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
    inflectionclass
end


"""Identify gender of `adj`.
$(SIGNATURES)
"""
function gmpGender(adj::IrregularAdjectiveStem)
    adj.adjgender
end


"""Identify case of `adj`.
$(SIGNATURES)
"""
function gmpCase(adj::IrregularAdjectiveStem)
    adj.adjcase
end


"""Identify number of `adj`.
$(SIGNATURES)
"""
function gmpNumber(adj::IrregularAdjectiveStem)
    adj.adjnumber
end


"""Identify degree of `adj`.
$(SIGNATURES)
"""
function gmpDegree(adj::IrregularAdjectiveStem)
    adj.adjdegree
end


"""Irregular adjective stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularAdjectiveStem}) = CitableByCite2Urn()


"""Human-readlable label for an `IrregularAdjectiveStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(astem::IrregularAdjectiveStem)
    string("Irregular adjective form ", astem.form, " (", label(astem.adjgender), " ", label(astem.adjcase), " ", label(astem.adjnumber)," ", label(astem.adjdegree), ")")
end

"""Identifying URN for an `IrregularAdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::IrregularAdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end


"""Compose CEX text for an `IrregularAdjectiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::IrregularAdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.stemid, label(adj), stemstring(adj), lexeme(adj), inflectionclass(adj), label(adj.adjgender), label(adj.adjcase), label(adj.adjnumber), label(adj.adjdegree) ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        join([c2urn, label(adj), stemstring(adj), lexeme(adj), inflectionclass(adj), label(adj.adjgender), label(adj.adjcase), label(adj.adjnumber), label(adj.adjdegree)], delimiter)
    end
end

"""
Read one row of a stems table for irregular adjective tokens and create an `AdjectiveStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularAdjectiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)

    # Example:
    # "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"

    if length(parts) < 8
        msg = "Too few parts in $delimited."
        @warn msg
        throw(new(ArgumentError(msg)))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = knormal(parts[3])
    g = gmpGender(parts[4])
    c = gmpCase(parts[5])
    n = gmpNumber(parts[6])
    d = gmpDegree(parts[7])
    inflclass = parts[8]

    IrregularAdjectiveStem(stemid,lexid,stem,g,c,n,d,inflclass)
end




"""Identify value of stem string for `adj`.
$(SIGNATURES)
"""
function stemstring(adj::IrregularAdjectiveStem)
    adj.form |> knormal
end

"""Identify lexeme for `adj`.
$(SIGNATURES)
"""
function lexeme(adj::IrregularAdjectiveStem)
    adj.lexid
end

"""Identify inflection class for `adj`.
$(SIGNATURES)
"""
function inflectionclass(adj::IrregularAdjectiveStem)
    adj.inflectionclass
end




"""Compose a digital code string for the form identified in `adj`.
$(SIGNATURES)
"""
function code(adj::IrregularAdjectiveStem)
      # PosPNTMVGCDCat
     string( ADJECTIVE,"0",code(adj.adjnumber),"000",code(adj.adjgender),code(adj.adjcase), code(adj.adjdegree), "0")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(adj::IrregularAdjectiveStem)
    FormUrn("$(COLLECTION_ID)." * code(adj))
end

function greekForm(adj::IrregularAdjectiveStem) 
    formurn(adj) |> greekForm
end