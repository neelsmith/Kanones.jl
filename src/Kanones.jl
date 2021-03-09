module Kanones

using CitableObject
using Unicode

export AbbreviatedUrn
export StemUrn, RuleUrn, LexemeUrn, Analysis
export parsetoken

include("abbrurn.jl")
include("dataset.jl")
include("parse.jl")
include("analysis.jl")
include("forms.jl")

"Submodule to read a Kanones Dataset and build SFST parser."
module FstBuilder
    import ..Kanones
    using Glob, Unicode
    
    export buildparser
    export Stem, Rule

    include("builder/unicode.jl")
    include("builder/config.jl")
    include("builder/kanonesio.jl")
    include("builder/compiler.jl")
    include("builder/fstcomposer.jl")
    include("builder/acceptorsquashers.jl")
    
    include("builder/types.jl")
    # Specific analytical types ("parts of speech")
    include("builder/uninflected.jl")
end

end # module