# Generate noun forms by:
# combine stem.from  and rule.ending.
# determine accent pattern from stem.accentpersistence
# addaccent to resulting word.
#

"""Generate vector of possible strings for correctly accented form of a noun form identified by lexeme.

$(SIGNATURES)
"""
function generatenoun(form::FormUrn,lex::LexemeUrn,  kd::Kanones.Dataset)
    stems = stemsarray(kd)
    nounstems = filter(s -> typeof(s) == NounStem, stems)
    stemmatches = filter(s -> s.lexid == lex, nounstems)
    #@info string("generatenoun: matching stems: ", length(stemmatches))
    rules = rulesarray(kd)
    nounrules = filter(r -> typeof(r) == NounRule, rules)

    msgs = []
    for stem in stemmatches
        # Find rules corresponding to analysis for this stem.

        # 1. Must belong to same stem class as stem.
        # rule.inflectionclass ==   stem.inflectionclass
        sameclass = filter(r -> r.inflectionclass == stem.inflectionclass, nounrules)
        #@info "generatenoun: found $(length(sameclass)) noun rules of class $(stem.inflectionclass)"
        
        # 2. Must have some morph form as analysis.
        abbrs = map(r -> abbrurn(r), sameclass)
        sameform = filter(r -> abbrurn(r) == form, sameclass)

        # 3. combine stem and ending strings
        raw = map(r -> stem.form * r.ending, sameform)
      
        # 4. determine accent pattern from stem.accentpersistence
        # and addaccent to resulting word.   
        for r in raw
            if countaccents(r, kd.orthography) == 1
                push!(msgs, stripmetachars(r))
            else
                if stem.accentpersistence == "recessive"
                    clean = stripmetachars(accentword(r, :RECESSIVE, kd.orthography))
                    push!(msgs, clean)

                elseif stem.accentpersistence == "stemaccented"
                    clean = stripmetachars( accentword(r, :PENULT, kd.orthography))
                    push!(msgs,clean)

                else 
                    casedict = valuedict(casepairs)
                    morphchars = split(form.objectid,"")
                    ncase = parse(Int64, morphchars[8])
                    if casedict[ncase] == "genitive" || casedict[ncase] == "dative"
                        clean = stripmetachars(accentultima(r, :CIRCUMFLEX, kd.orthography))
                        push!(msgs, clean)
                    else
                        clean = stripmetachars(accentultima(r, :ACUTE, kd.orthography))
                        push!(msgs,clean)
                    end
                end
            end
        end  
    end
    msgs

end

"""Generate vector of possible strings for correctly accented form of a noun form identified by `analysis`.

$(SIGNATURES)
"""
function generatenoun(analysis::Analysis, kd::Kanones.Dataset)
    generatenoun(analysis.lexeme, analysis.form, kd)
end