# Generate noun forms by:
# combine stem.from  and rule.ending.
# determine accent pattern from stem.accentpersistence
# addaccent to resulting word.
#


"""Generate vector of possible strings for correctly accented form of a noun form identified by `analysis`.

$(SIGNATURES)

Nouns are hard to generate because of the varied behavior
of accents depending on the inherent persistence of the lexeme
and morphology.
"""
function generatenoun(analysis::Analysis, kd::Kanones.Dataset; ortho::T = literaryGreek()) where { T <: GreekOrthography}
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)
    stemmatches = filter(s -> s.lexid == analysis.lexeme, nounstems)

    rules = rulesarray(kd)
    nounrules = filter(r -> typeof(r) == NounRule, rules)

    # Use this while still debugging...
    msgs = []
    for stem in stemmatches
        # Find rules corresponding to analysis for this stem.

        # 1. Must belong to same stem class as stem.
        # rule.inflectionclass ==   stem.inflectionclass
        sameclass = filter(r -> r.inflectionclass == stem.inflectionclass, nounrules)
        
        # 2. Must have some morph form as analysis.
        # analysis.form == Kanones.abbrurn(rule)
        sameform = filter(r -> abbrurn(r) == analysis.form, sameclass)
        
        # 3. combine stem and ending strings
        raw = map(r -> stem.form * r.ending, sameform)
        push!(msgs, raw)

        # 4. determine accent pattern from stem.accentpersistence
        # and addaccent to resulting word.
        
    end
    msgs
end