"A record for a single irregular noun stem."
struct IrregularAdjectiveStem <: KanonesIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    adjgender::GMPGender
    adjcase::GMPCase
    adjnumber::GMPNumber
    adjdegree::GMPDegree
end

"""Irregular adjective stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularAdjectiveStem}) = CitableByCite2Urn()


"""Human-readlable label for an `IrregularAdjectiveStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(astem::IrregularAdjectiveStem)
    string("Irregular adjective form ", astem.form, " (", label(astem.adjgender), " ", label(astem.adjcase), " ", label(astem.adjnumber)," ", label(astem.adjdegree), ")")
end

"""Identifying URN for an `IrregularAdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
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

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::IrregularAdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([adj.stemid, label(adj) ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        join([c2urn, label(adj)], delimiter)
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
    g = gmpGender(parts[4])
    c = gmpCase(parts[5])
    n = gmpNumber(parts[6])
    d = gmpDegree(parts[7])
    inflclass = parts[8]

    IrregularAdjectiveStem(stemid,lexid,stem,g,c,n,d)
end