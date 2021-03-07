
"Implementations of this type can read delimited and write fst."
abstract type KanonesIO end

"Dictionary mapping directory names to KanonesIO implementation."
kanonesIOdict = Dict(
    [
    "uninflected" => uninflectedstemparser()
    ]
)