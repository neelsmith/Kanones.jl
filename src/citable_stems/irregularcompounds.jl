"""Compose a vector of `VerbStem`s for `compound` by adding `compound`'s prefix
to each `Stem` in `stemlist`.
$(SIGNATURES)
"""
function irregularstems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    
    results = Stem[]
    simplexstems = filter(s -> lexeme(s) == simplex(compound),  stemlist)
    @info("Compounding/stem count", compound, length(simplexstems))
    irrverbs = filter(s -> s isa IrregularVerbStem, simplexstems)
    finiteresults = irregularverbstems(compound, irrverbs, ortho)

    irrinfins = filter(s -> s isa IrregularInfinitiveStem, simplexstems)
    infinitiveresults = irregularinfinitivestems(compound, irrinfins, ortho)
    # Add:
    # Participle
    # Verbal adjective
    results = vcat(finiteresults, infinitiveresults)
end

function irregularverbstems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @info("Now make finite verb forms")
    Stem[]
end


function irregularinfinitivestems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @info("Now make infinitive verb forms")

    Stem[]
end