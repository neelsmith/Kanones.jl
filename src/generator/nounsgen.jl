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
    rules = rulesarray(kd)
    stemmatches = filter(s -> s.lexid == analysis.lexeme, stems)
    for stem in stemmatches
        # Find corresponding rules.
        # Must have some morph form as analysis.
        # Must belong to same stem class as stem.
        # rule.inflectionclass ==   stem.inflectionclass
        rulematches = filter(r -> r.inflectionclass == stem.inflectionclass, rules)
        println("THESE RULES: " * rulematches)
    end
    #rulematches = filter(r -> s.lexid == analysis.lexeme, stems)
    #map(stem -> stem.form,  matches)
end