
"""From a list of irregular forms matching a particular lexeme, select the irregular form with the same morphological identification.

$(SIGNATURES)

# Arguments

- `irreglist` A list of 1 or more `IrregularNounStem`s for a given noun lexeme.
- `gmfNoun` The gender, case, number identification to select.
"""
function selectirregnoun(irreglist, gmfNoun::FormUrn)
    matched = filter(irreg -> abbrformurn(irreg) == gmfNoun,  irreglist)
    if isempty(matched)
        @warn "Dataset has no match for irregular noun form $gmfNoun"
        nothing
    elseif length(matched) > 1
        @warn "Dataset has multiple matches for irregular noun form $gmfNoun"
        nothing
    else
        matched[1].form
    end 
end

"""From lists for stems and rules for regular nouns, 

$(SIGNATURES)

# Arguments

- `form` Gender, case, number identifier to match
- `stems` Stem entries for a single noun lexeme.
- `rules` Noun rules for this dataset.
- `ortho` Orthography
"""
function selectregularnoun(form, stems, rules, ortho::GreekOrthography)
    msgs = []
    for stem in stems
        # Find rules corresponding to analysis for this stem.

        # 1. Must belong to same stem class as stem.
        # rule.inflectionclass ==   stem.inflectionclass
        sameclass = filter(r -> r.inflectionclass == stem.inflectionclass, rules)
        #@info "generatenoun: found $(length(sameclass)) noun rules of class $(stem.inflectionclass)"
        
        # 2. Must have some morph form as analysis.
        abbrs = map(r -> ruleurn(r), sameclass)
        sameform = filter(r -> ruleurn(r) == form, sameclass)

        # 3. combine stem and ending strings
        raw = map(r -> stem.form * r.ending, sameform)
      
        # 4. determine accent pattern from stem.accentpersistence
        # and addaccent to resulting word.   
        for r in raw
            if countaccents(r, ortho) == 1
                push!(msgs, stripmetachars(r))
            else
                if stem.accentpersistence == "recessive"
                    clean = stripmetachars(accentword(r, :RECESSIVE, ortho))
                    push!(msgs, clean)

                elseif stem.accentpersistence == "stemaccented"
                    clean = stripmetachars( accentword(r, :PENULT, ortho))
                    push!(msgs,clean)

                else 
                    casedict = valuedict(casepairs)
                    morphchars = split(form.objectid,"")
                    ncase = parse(Int64, morphchars[8])
                    if casedict[ncase] == "genitive" || casedict[ncase] == "dative"
                        clean = stripmetachars(accentultima(r, :CIRCUMFLEX, ortho))
                        push!(msgs, clean)
                    else
                        clean = stripmetachars(accentultima(r, :ACUTE, ortho))
                        push!(msgs,clean)
                    end
                end
            end
        end  
    end
    msgs
end

# Generate noun forms by:
# combine stem.from  and rule.ending.
# determine accent pattern from stem.accentpersistence
# addaccent to resulting word.
#

"""Generate vector of possible strings for correctly accented form of a noun form identified by lexeme.

$(SIGNATURES)
"""
function generatenoun(form::FormUrn,lex::LexemeUrn,  kd::Kanones.Dataset)
    # See if inflectionclass == "irregularnoun"
    # then find one matching form
    #
    stems = stemsarray(kd)
    irregnounstems = filter(s -> typeof(s) == IrregularNounStem, stems)
    irregnounmatches = filter(s -> s.lexid == lex, irregnounstems)
    if isempty(irregnounmatches)
        nounstems = filter(s -> typeof(s) == NounStem, stems)
        stemmatches = filter(s -> s.lexid == lex, nounstems)
        rules = rulesarray(kd)
        nounrules = filter(r -> typeof(r) == NounRule, rules)
        selectregularnoun(form, nounstems, nounrules, kd.orthography)
        
        #@info string("generatenoun: matching stems: ", length(stemmatches))
        
    else
        selectirregnoun(irregnounmatches, form)
    end

    
    

end

"""Generate vector of possible strings for correctly accented form of a noun form identified by `analysis`.

$(SIGNATURES)
"""
function generatenoun(analysis::Analysis, kd::Kanones.Dataset)
    generatenoun(analysis.form, analysis.lexeme,  kd)
end