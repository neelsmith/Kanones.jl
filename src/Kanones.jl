module Kanones
using CitableObject
using Unicode

# Abstract types subclassed (in morphology module?)
export Stem, Rule, Analysis

include("dataset.jl")
include("types.jl")
include("parse.jl")


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
    include("builder/localfst.jl")

    # Specific analytical types ("parts of speech")
    include("builder/uninflected.jl")
end

end # module