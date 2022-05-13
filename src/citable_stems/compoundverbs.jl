"""A record for a single uninflected stem.

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


function compoundstem(s::AbstractString)
    cols = split(s, "|")
    if length(cols) < 5
        throw(DomainException("Cannot form compound verb stem: too few columns in $(s)"))
    end
    CompoundVerbStem(
        StemUrn(cols[1]),
        LexemeUrn(cols[2]),
        nfkc(cols[3]),
        LexemeUrn(cols[4]),
        nfkc(cols[5])
    )
end

function stemid(compound::CompoundVerbStem)
    compound.stemid
end

function prefix(compound::CompoundVerbStem)
    compound.prefix
end


function lexeme(compound::CompoundVerbStem)
    compound.lexid
end


function simplex(compound::CompoundVerbStem)
    compound.simplex
end

function stems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @info("Make compounds for $(compound)...")
    compounded = []
    for s in filter(s -> lexeme(s) == simplex(compound),  stemlist)
        catted = string(prefix(compound), "#", stemstring(s))
        @info(catted)
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


function stems(compound::CompoundVerbStem, ds::Kanones.Dataset)
    stems(compound, stemsarray(ds))
end