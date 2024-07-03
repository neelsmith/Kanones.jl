"""A record for generating stems for a single compound verb.

$(SIGNATURES)
"""
struct CompoundVerbStem <: KanonesStem
    stemid::StemUrn
    lexid::LexemeUrn
    prefix::AbstractString
    simplex::LexemeUrn
    notes::AbstractString
    augmented::Bool
end



function show(io::IO, verb::CompoundVerbStem)
    print(io, label(verb))
end

function ==(v1::CompoundVerbStem, v2::CompoundVerbStem)
    v1.stemid == v2.stemid &&
    v1.lexid == v2.lexid &&
    v1.prefix == v2.prefix &&
    v1.simplex == v2.simplex &&
    v1.notes == v2.notes && 
    v1.augmented == v2.augmented
end

"""Regular verb stems are citable by Cite2Urn"""
CitableTrait(::Type{CompoundVerbStem}) = CitableByCite2Urn()
function citabletrait(::Type{CompoundVerbStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `CompoundVerbStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vs::CompoundVerbStem)
    isempty(vs.notes) ? string("Compound verb (", vs.lexid,") formed by addding ", vs.prefix, " to simplex ", vs.simplex) : string("Compound verb (", vs.lexid,") formed by addding ", vs.prefix, " to simplex ", vs.simplex, " (", vs.notes, ")")
end

function urn(vs::CompoundVerbStem; registry = nothing)
    if isnothing(registry)
        vs.stemid
    else
        expand(vs.stemid, registry)
    end
end

struct  CompoundVerbStemCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{CompoundVerbStem})  
    CompoundVerbStemCex()
end


function cex(vs::CompoundVerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, lexeme(vs), vs.prefix,  vs.simplex, vs.notes, vs.augmented], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        lexurn = expand(ns.lexid, registry)
        join([c2urn, lexurn,  vs.prefix,  vs.simplex, vs.notes, vs.augmented], delimiter)
    end
end

function fromcex(traitvalue::CompoundVerbStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    cols = split(cexsrc, delimiter)
    if length(cols) < 6
        throw(ArgumentError("Cannot form compound verb stem: too few columns in $(s)"))
    end
    CompoundVerbStem(
        StemUrn(cols[1]),
        LexemeUrn(cols[2]),
        knormal(cols[3]),
        LexemeUrn(cols[4]),
        knormal(cols[5]),
        lowercase(cols[6]) == "true" || lowercase(cols[6]) == "t"
    )
end

function pos(cvs::CompoundVerbStem)
    :verb
end


"""Identify this `compound` stem record.
$(SIGNATURES)
"""
function stemid(compound::CompoundVerbStem)
    compound.stemid
end


"""The prefix to apply to simplex verb to form compound forms.
$(SIGNATURES)
"""
function prefix(compound::CompoundVerbStem)
    compound.prefix
end


"""Identify the lexeme of the compound verb.
$(SIGNATURES)
"""
function lexeme(compound::CompoundVerbStem)
    compound.lexid
end

"""Identify the lexeme of the simplex verb.
$(SIGNATURES)
"""
function simplex(compound::CompoundVerbStem)
    compound.simplex
end

"""Compose a vector of `VerbStem`s for `compound` by adding `compound`'s prefix
to each `Stem` in `stemlist` for `compound`'s simplex identifier.
$(SIGNATURES)
"""
function stems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @debug("Make compounds for $(compound)...")
    compounded = []
    for s in filter(s -> lexeme(s) == simplex(compound),  stemlist)
        catted = string(prefix(compound), "#", stemstring(s))
        @debug(catted)
        newstem = VerbStem(
            stemid(compound),
            lexeme(compound),
            catted,
            inflectionclass(s),
            compound.augmented
        )
        push!(compounded, newstem)
    end
    compounded
end

