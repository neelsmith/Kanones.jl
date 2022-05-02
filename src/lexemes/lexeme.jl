"""Lexemes are citable objects."""
struct GreekLexeme <: Citable
    lexid::LexemeUrn
end

"""Human-readlable label for a `GreekLexeme`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(lex::GreekLexeme; registry = nothing, lexicon = nothing)
    id = isnothing(registry) ? lex.lexid  : expand(lex.lexid, registry)
    isnothing(lexicon) ? string("Lexeme ", id) : string("Lexeme ", attach_lemma(id, lexicon) )
end


"""Identifying URN for a `GreekLexeme`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(lex::GreekLexeme; registry = nothing, lexicon = nothing)
    u = isnothing(registry) ? lex.lexid : expand(lex.lexid, registry)
    isnothing(lexicon) ? u : attach_lemma(u, lexicon)
end



"""Compose CEX text for a `GreekLexeme`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(lex::GreekLexeme; delimiter = "|", registry = nothing, lexicon = nothing)
    u = isnothing(registry) ? lex.lexid :  expand(lex.lexid, registry)
    if isnothing(lexicon) 
        join([u,delimiter,label(lex; registry = registry)])
    else
       join([u,delimiter,label(lex; registry = registry, lexicon = lexicon)])
    end    
end