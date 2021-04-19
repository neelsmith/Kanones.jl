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
function generatenoun(analysis::Analysis, kd::Kanones.Dataset)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)
    stemmatches = filter(s -> s.lexid == analysis.lexeme, nounstems)
    @info string("Matching stems: ", length(stemmatches))
    rules = rulesarray(kd)
    nounrules = filter(r -> typeof(r) == NounRule, rules)

    # Use this while still debugging...
    msgs = []
    for stem in stemmatches
        # Find rules corresponding to analysis for this stem.

        # 1. Must belong to same stem class as stem.
        # rule.inflectionclass ==   stem.inflectionclass
        sameclass = filter(r -> r.inflectionclass == stem.inflectionclass, nounrules)
        @info "Found $(length(sameclass)) nouns of class $(stem.inflectionclass)"
        @info "Now filtering for form $(analysis.form)"
        # 2. Must have some morph form as analysis.
        # analysis.form == Kanones.abbrurn(rule)
        sameform = filter(r -> abbrurn(r) == analysis.form, sameclass)
        
        # 3. combine stem and ending strings
        raw = map(r -> stem.form * r.ending, sameform)
      

        # 4. determine accent pattern from stem.accentpersistence
        # and addaccent to resulting word.

        
        for r in raw
            if countaccents(r, kd.orthography) == 1
                push!(msgs, r)
            else
                if stem.accentpersistence == "recessive"
                    push!(msgs, accentword(r, :RECESSIVE))
                # :PENULT
                #
                # LOOK at case for ultima:
                # 
                # accentultima(WORD, :ACUTE or :CIRCUMFLEX)
                else 
                    push!(msgs, "Haven't yet figured out $(stem.accentpersistence)")
                end
            
            end
        end
        
    end
    msgs
end