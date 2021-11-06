"""Lexemes are citable objects."""
struct Lexeme :< Citable 
    id
end

function label(lex::Lexeme)
    id
end


