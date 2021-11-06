"""Lexemes are citable objects."""
struct Lexeme <: Citable
    lexid
end

function label(lex::Lexeme)
    lex.lexid
end


