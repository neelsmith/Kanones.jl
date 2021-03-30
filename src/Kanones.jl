module Kanones

using CitableObject, CitableParserBuilder
using PolytonicGreek
using Unicode, Glob
using Documenter, DocStringExtensions

export parsetoken, parsewordlist
export Stem, Rule 
export UninflectedForm, UninflectedStem, UninflectedRule
export NounForm, NounStem, NounRule


include("parse.jl")

include("datasets/dataset.jl")
include("datasets/kanonesio.jl")
include("datasets/uninflecteddata.jl")
include("datasets/nounsdata.jl")

include("analyzer/analysis.jl")

include("generator/generate.jl")

# Conversion Form objects <-> URN values
include("morphology/forms.jl")
include("morphology/formvalues.jl")
include("morphology/uninflectedmorphology.jl")
include("morphology/nounmorphology.jl")
include("morphology/finiteverbmorphology.jl")

"Submodule to read a Kanones Dataset and build SFST parser."
module FstBuilder
    import ..Kanones
    using Glob, Unicode
    using CitableParserBuilder
    using Documenter, DocStringExtensions
    
    export buildparser

    include("builder/unicodefst.jl")
    include("builder/config.jl")
    include("builder/compiler.jl")
    include("builder/fstcomposer.jl")
    include("builder/acceptorsquashers.jl")
    
    # Specific analytical types ("parts of speech")
    include("builder/uninflectedfst.jl")
    include("builder/nounsfst.jl")
end

end # module