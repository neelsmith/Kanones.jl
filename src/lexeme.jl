"""Lexemes are citable objects."""
struct GreekLexeme <: Citable
    lexid
end

function label(lex::GreekLexeme; )
    lex.lexid
end


