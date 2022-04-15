
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
function selectregularnoun(form, stem, rules, ortho::GreekOrthography)::Vector{AbstractString}
    # 1. Find rules belonging to same inflection class as stem.
    # rule.inflectionclass ==   stem.inflectionclass
    classrules = filter(r -> r.inflectionclass == stem.inflectionclass, rules)
    @debug("Stems of class $(stem.inflectionclass) : ", length(classrules))
    
    # 2. Must have some morph form as analysis.
    #
    # NEED TO GET A GMF from a Rule (here a noun rule)
    #abbrs = map(r -> formurn(r), classrules)
    sameform = filter(r -> formurn(r) == form, classrules)

    # 3. combine stem and ending strings
    if isempty(sameform)
        @warn("No rules found for form $(form) and inflection class $(stem.inflectionclass)")
        nothing
    end
    raw = map(r -> stem.form * r.ending, sameform)
    
    # 4. determine accent pattern from stem.accentpersistence
    # and addaccent to resulting word.   
    msgs = []
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
            #=
                casedict = valuedict(casepairs)
                morphchars = split(form.objectid,"")
                ncase = parse(Int64, morphchars[8])
                if casedict[ncase] == "genitive" || casedict[ncase] == "dative"
                    push!(msgs,  stripmetachars(accentultima(r, :CIRCUMFLEX, ortho)))
                    
                else
                    push!(msgs, stripmetachars(accentultima(r, :ACUTE, ortho)))
                    
                end
                =#
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
function generatenoun(form::FormUrn,lex::LexemeUrn,  kd::Kanones.Dataset)::Vector{AbstractString}
    
    # See if inflectionclass == "irregularnoun"
    # then find one matching form
    #
    stems = stemsarray(kd)
    irregnounstems = filter(s -> typeof(s) == IrregularNounStem, stems)
    irregnounmatches = filter(s -> s.lexid == lex, irregnounstems)
    if isempty(irregnounmatches)
        nounstems = filter(s -> typeof(s) == NounStem, stems)
        stemmatches = filter(s -> s.lexid == lex, nounstems)
        if isempty(stemmatches)
            @warn("No stems matched lexeme $(lex)")
            nothing
        else
            rules = rulesarray(kd)
            nounrules = filter(r -> typeof(r) == NounRule, rules)

            regulars = []
            for stem in stemmatches
                push!(regulars, selectregularnoun(form, stem, nounrules, kd.orthography))
            end
            regulars  |> Iterators.flatten |> collect
            #@info string("generatenoun: matching stems: ", length(stemmatches))
        end
    else
        #
        selectirregnoun(irregnounmatches, form)
    end
end

"""Generate vector of possible strings for correctly accented form of a noun form identified by `analysis`.

$(SIGNATURES)
"""
function generatenoun(analysis::Analysis, kd::Kanones.Dataset)::Vector{AbstractString}
    generatenoun(analysis.form, analysis.lexeme,  kd)
end