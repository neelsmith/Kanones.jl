module Kanones
using CitableObject

export AbbreviatedUrn
export buildparser

export Stem
export Rule
export Analysis



abstract type Stem end
abstract type StemType end
abstract type Rule end
abstract type RuleType end
abstract type Analysis end
abstract type AnalysisType end
"Implementations of this type can read delimited and write fst."
abstract type KanonesIO end


include("config.jl")
include("dataset.jl")
include("compiler.jl")
include("fstcomposer.jl")
include("abbrurn.jl")
include("types.jl")


include("uninflected.jl")

include("datainstallers.jl")
include("rulesinstallers.jl")
include("makefilecomposer.jl")



end # module
