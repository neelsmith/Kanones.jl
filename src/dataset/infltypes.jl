
"""Index lexemes to their inflection class.
$(SIGNATURES)
"""
function inflclassindex(ds::T) where  {T <: Dataset}
    stems = stemsarray(ds)
    map(stems) do s
        (string(lexeme(s)), string(inflectionclass(s))) 
    end
end