#=

In addition to these methods, parsers can be used to generate tokens from a 
lexeme and form.  Those methods are defined in files where StringParser and DataFrameParser
are defined.

=#
"""Generate a form for a given stem and rule.
$(SIGNATURES)
"""
function generate(stem::S, rule::R; ortho::GreekOrthography = literaryGreek()) where {S <: KanonesStem, R <: KanonesRule}
    @warn("generate function not implemented for type $(typeof(rule))")
    nothing
end

"""Generate the correct string for `lex` in the form `form`.
$(SIGNATURES)
"""
function generate(
    lex::LexemeUrn, 
    form::FormUrn, 
    ruleset::Vector{Rule}, 
    stemset::Vector{Stem},
    orthography::GreekOrthography) 

    
    @debug("Use data arrays to generate form for lex", form, lex)
    # find stems:
    stems = filter(s -> lexeme(s) == lex,  stemset)
    @debug("STEMS:", stems)
    generated = []
    for s in stems
        @debug("Inflection class of stem is $(inflectionclass(s))")
        rules = filter(ruleset) do r
            if r isa IrregularRule
                @debug("LOOK AT inflclass of irreg rule", inflectionclass(r) )
                @debug("Compare to inflcass of stem", inflectionclass(s))
                @debug("ANd look at formurn for this stem", s)
                inflectionclass(r) == inflectionclass(s) && formurn(s) == form
            else
                @debug("LOok at inflection classes",  inflectionclass(r), inflectionclass(s))
               inflectionclass(r) == inflectionclass(s) && formurn(r) == form
            end
        end
        if ! isempty(rules)
            @debug("For stem $(s), found rules", rules)
            # Add check here for existence of pre-augmented
        end
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
    @debug("generate(lex,form,kds): generating $(form) for $(lex)...")
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
