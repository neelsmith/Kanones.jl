"""A record for generating stems for a single compound verb.

$(SIGNATURES)
"""
struct CompoundVerbStem <: KanonesStem
    stemid::StemUrn
    lexid::LexemeUrn
    prefix::AbstractString
    simplex::LexemeUrn
    notes::AbstractString
end

#=
Stem|LexicalEntity|Prefix|Simplex|Note
compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω
=#

"""Construct a `CompoundVerbStem` from a delimited text string.
$(SIGNATURES)
"""
function compoundstem(s::AbstractString)
    cols = split(s, "|")
    if length(cols) < 5
        throw(DomainException("Cannot form compound verb stem: too few columns in $(s)"))
    end
    CompoundVerbStem(
        StemUrn(cols[1]),
        LexemeUrn(cols[2]),
        knormal(cols[3]),
        LexemeUrn(cols[4]),
        knormal(cols[5])
    )
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
            inflectionClass(s)
        )
        push!(compounded, newstem)
    end
    compounded
end

