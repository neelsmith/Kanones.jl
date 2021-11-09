"A record for a single irregular noun stem."
struct IrregularNounStem <: KanonesStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    noungender::GMPGender
    nouncase::GMPCase
    nounnumber::GMPNumber
end

"""Irregular noun stems are citable by Cite2Urn"""
CitableTrait(::Type{IrregularNounStem}) = CitableByCite2Urn()

"""Human-readlable label for an `IrregularNounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::IrregularNounStem)
    string("Irregular noun form ", ns.form, " (", label(ns.noungender)," ", label(ns.nouncase), " ", label(ns.nounnumber), ")")
end


"""Identifying URN for an `IrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::IrregularNounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end


"""Compose CEX text for an `IrregularNounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::IrregularNounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ns.stemid, label(ns) ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        join([c2urn, label(ns)], delimiter)
    end
end

#=
"""Compose FormUrn for an irregular noun stem.

$(SIGNATURES)

For irregulars, all form information is in the stem entry, so we need 
a function to create form urns directory from this.
"""
function abbrformurn(irregstem::IrregularNounStem)

    casedict = labeldict(casepairs)
    # PosPNTMVGCDCat
    FormUrn(string("morphforms.", NOUN,"0", code(irregstem.gnumber),"000",code(irregstem.gender),code(irregstem.gcase),"00"))
end
=#

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularNounIO, delimited::AbstractString; delimiter = "|")
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
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    g = gmpGender(parts[4])
    c = gmpCase(parts[5])
    n = gmpNumber(parts[6])
    inflclass = parts[7]

    IrregularNounStem(stemid,lexid,stem,g,c,n)
end

