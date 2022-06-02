
"""Generate a form for a given stem and rule.
$(SIGNATURES)
"""
function generate(stem::S, rule::R; ortho::GreekOrthography = literaryGreek()) where {S <: KanonesStem, R <: KanonesRule}
    @warn("generate function not implemented for type $(typeof(rule))")
    nothing
end

function generate(
    lex::LexemeUrn, 
    form::FormUrn, 
    ruleset::Vector{Rule}, 
    stemset::Vector{Stem},
    orthography::GreekOrthography) 

    @debug("Use data arrays to generate form for lex", form, lex)
    # find stems:
    stems = filter(s -> lexeme(s) == lex,  stemset)
    ("STEMS:", stems)
    generated = []
    for s in stems
        rules = filter(ruleset) do r
            if r isa IrregularRule
                @debug("LOOK AT inflclass of irreg rule", inflectionClass(r) )
                @debug("Compare to inflcass of stem", inflectionClass(s))
                @debug("ANd look at formurn for this stem", s)
                inflectionClass(r) == inflectionClass(s) && formurn(s) == form
            else
                @debug("LOok at inflection classes",  inflectionClass(r), inflectionClass(s))
                #@info("LOok at forms", formurn(r), form)
                inflectionClass(r) == inflectionClass(s) && formurn(r) == form
            end
        end
        @debug("Rules for stem", rules)
        @debug("Stem", s)
        for r in rules
            @debug("Generating s/r", s,r)
            push!(generated, generate(s,r, ortho = orthography))
        end
    end

    generated
end

"""Generate a form for a given lexeme and form within a given dataset.
$(SIGNATURES)
"""
function generate(
    lex::LexemeUrn, 
    form::FormUrn, 
    kds::Kanones.FilesDataset) 
    generate(lex, form, rulesarray(kds), stemsarray(kds), kds.orthography)
end


"""Generate a delimited-text version of a full analysis for the combination of `stem` and `rule`.
$(SIGNATURES)
"""
function analysis_string(stem::S, rule::R; ortho = literaryGreek(), delimiter = "|") where {S <: KanonesStem, R <: KanonesRule}
    token = generate(stem, rule, ortho = ortho) |> knormal
    join([token, formurn(rule), lexeme(stem), urn(stem), urn(rule)], delimiter)
end



"""Remove metadata characters from `s`.

$(SIGNATURES)
"""
function stripmetachars(s)
    replace(s, r"[#_^]" => "")
end


"""Compile list of all possible form codes.
$(SIGNATURES)
"""
function allformcodes()
    vcat(
        nounformcodes(), 
        adjectiveformcodes(),
        verbformcodes(),
        verbaladjectiveformcodes(),
        infinitiveformcodes(),
        participleformcodes(),
        pronounformcodes(),
        uninflectedformcodes()
    )
end

"""Generate list of all possible form objects.
$(SIGNATURES)
"""
function allforms()
    allformcodes() .|> greekForm
end
