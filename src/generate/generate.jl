
"""Generate a form for a given stem and rule.
$(SIGNATURES)
"""
function generate(stem::S, rule::R; ortho::GreekOrthography = literaryGreek()) where {S <: KanonesStem, R <: KanonesRule}
    @warn("generate function not implemented for type $(typeof(rule))")
    nothing
end

"""Generate a form for a given lexeme and form within a given dataset.
$(SIGNATURES)
"""
function generate(
    lex::LexemeUrn, 
    form::FormUrn, 
    kds::Kanones.FilesDataset) 
    @info("Generate form for lex", form, lex)
    # find stems:
    stems = filter(s -> lexeme(s) == lex,  stemsarray(kds))
    @debug("STEMS:", stems)
    generated = []
    for s in stems
        rules = filter(rulesarray(kds)) do r
            if r isa IrregularRule
                @debug("LOOK AT inflclass of irreg rule", inflectionClass(r) )
                @debug("Compare to inflcass of stem", inflectionClass(s))
                @debug("ANd look at formurn for this stem", s)
                inflectionClass(r) == inflectionClass(s) && formurn(s) == form
            else
                inflectionClass(r) == inflectionClass(s) && formurn(r) == form
            end
        end
        @debug("Rules for stem", rules)
        @debug("Stem", s)
        for r in rules
            @info("Generating s/r", s,r)
            push!(generated, generate(s,r, ortho = orthography(kds)))
        end
    end

    generated
end


"""Generate a delimited-text version of a full analysis for the combination of `stem` and `rule`.
$(SIGNATURES)
"""
function analysis_string(stem::S, rule::R; ortho = literaryGreek(), delimiter = "|") where {S <: KanonesStem, R <: KanonesRule}
    token = generate(stem, rule, ortho = ortho) |> nfkc
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
