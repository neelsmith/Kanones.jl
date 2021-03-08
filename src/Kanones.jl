module Kanones
using CitableObject
using Glob, Unicode

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
include("unicode.jl")
include("types.jl")
include("compiler.jl")
include("fstcomposer.jl")
include("acceptorsquashers.jl")

# Specific analytical types ("parts of speech")
include("uninflected.jl")

end # module
