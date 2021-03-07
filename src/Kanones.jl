module Kanones
using CitableObject
using Glob

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


    



include("config.jl")
include("dataset.jl")
include("abbrurn.jl")
include("types.jl")
include("compiler.jl")
include("fstcomposer.jl")
include("acceptorsquashers.jl")

include("uninflected.jl")

end # module
