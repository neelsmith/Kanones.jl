"Implementations of this type can read delimited and write fst."
abstract type KanonesIO end

"KanonesIO type for reading and writing stem data for uninflected stems."
struct UninflectedParser <: KanonesIO
    label::AbstractString
end

"KanonesIO type for reading and writing stem data for noun stems."
struct NounParser <: KanonesIO
    label::AbstractString
end