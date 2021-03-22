"Implementations of this type can read delimited and write fst."
abstract type KanonesIO end

"KanonesIO type for reading and writing stem for uninflected forms."
struct UninflectedParser <: KanonesIO
    label::AbstractString
end

"KanonesIO type for reading and writing data for noun forms."
struct NounParser <: KanonesIO
    label::AbstractString
end


"KanonesIO type for reading and writing data for finite verb form."
struct VerbParser <: KanonesIO
    label::AbstractString
end