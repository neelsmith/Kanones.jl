"A record for a single noun stem."
struct NounStem <: Stem
    stemid
    lexid
    form::AbstractString
    gender::GMPGender
    inflectionclass
    accentpersistence
end

"""
Read one row of a stems table for noun tokens and create a `NounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    @warn("Looking at stem row ", delimited)
    parts = split(delimited, delimiter)
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = nfkc(parts[3])
    gender = gmpGender(parts[4])
    @warn("Reading reg.nouns stem row with gender ", gender, " from ", parts[4])
    inflclass = parts[5]
    accent = parts[6]
    NounStem(stemid,lexid,stem,gender,inflclass,accent)
end

"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{NounStem}) = CitableByCite2Urn()

"""Human-readlable label for a `NounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::NounStem)
    string("Noun stem ", ns.form, "- (", label(ns.gender), ")")
end


"""Identifying URN for a `NounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::NounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end



"""Compose CEX text for a `NounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::NounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ns.stemid, label(ns) ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        join([c2urn, label(ns)], delimiter)
    end
end

"""Identifier for a `NounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::NounStem)
    n.stemid
end

"""Lexeme for a `NounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(n::NounStem)
    n.lexid
end