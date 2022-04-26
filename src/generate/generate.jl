

"""Generate a form for a given stem and rule.
$(SIGNATURES)
"""
function generate(stem::S, rule::R; ortho::GreekOrthography = literaryGreek()) where {S <: KanonesStem, R <: KanonesRule}
    @warn("generate function not implemented for type $(typeof(rule))")
    nothing
end





"""Generate a delimited-text version of a full analysis for the combination of `stem` and `rule`.
$(SIGNATURES)
"""
function analysis_string(stem::S, rule::R; delimiter = "|") where {S <: KanonesStem, R <: KanonesRule}
    token = generate(stem, rule)
    join([token, formurn(rule), lexeme(stem), urn(stem), urn(rule)], delimiter)
end



"""Remove metadata characters from `s`.

$(SIGNATURES)
"""
function stripmetachars(s)
    replace(s, r"[#_^]" => "")
end