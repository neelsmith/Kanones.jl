module Kanones
using CitableObject
using Unicode

export Stem, Rule, Analysis

abstract type Stem end
abstract type StemType end
abstract type Rule end
abstract type RuleType end
abstract type Analysis end
abstract type AnalysisType end

include("dataset.jl")
include("types.jl")


"Module to read a Kanones Dataset and build SFST parser."
module FstBuilder
    import ..Kanones
    using Glob, Unicode
    
    export buildparser
    include("builder/abbrurn.jl")
    include("builder/unicode.jl")
    include("builder/config.jl")
    include("builder/compiler.jl")
    include("builder/fstcomposer.jl")
    include("builder/acceptorsquashers.jl")

    # Specific analytical types ("parts of speech")
    include("builder/uninflected.jl")
end

end # module


