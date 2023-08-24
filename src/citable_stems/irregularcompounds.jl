"""Compose a vector of `VerbStem`s for `compound` by adding `compound`'s prefix
to each `Stem` in `stemlist`.
$(SIGNATURES)
"""
function irregularstems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    
    results = Stem[]
    simplexstems = filter(s -> lexeme(s) == simplex(compound),  stemlist)
    @debug("Compounding/stem count", compound, length(simplexstems))
    irrverbs = filter(s -> s isa IrregularVerbStem, simplexstems)
    finiteresults = irregularverbstems(compound, irrverbs, ortho)

    irrinfins = filter(s -> s isa IrregularInfinitiveStem, simplexstems)
    infinitiveresults = irregularinfinitivestems(compound, irrinfins, ortho)
    # Add:
    # Participle
    # Verbal adjective
    results = vcat(finiteresults, infinitiveresults)
end

function pos(cvs::CompoundVerbStem)
    :verb
end


function irregularverbstems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @debug("Now make finite verb forms")
    compounds = IrregularVerbStem[]
    for s in stemlist
        catted = string(prefix(compound), "#", stemstring(s))
        newstem = IrregularVerbStem(
            stemid(compound),
            lexeme(compound),
            catted,
            gmpPerson(s),
            gmpNumber(s),
            gmpTense(s),
            gmpMood(s),
            gmpVoice(s),
            "irregularfiniteverb"
        )
        push!(compounds, newstem)
    end
    compounds
end


function irregularinfinitivestems(compound::CompoundVerbStem, stemlist::Vector{Stem}, ortho = literaryGreek())
    @debug("Now make infinitive verb forms")
    compounds = IrregularInfinitiveStem[]
    for s in stemlist
        catted = string(prefix(compound), "#", stemstring(s))
        newstem = IrregularInfinitiveStem(
            stemid(compound),
            lexeme(compound),
            catted,
            gmpTense(s),
            gmpVoice(s),
            "irregularinfinitive"
        )
        push!(compounds, newstem)
    end
    compounds
end
