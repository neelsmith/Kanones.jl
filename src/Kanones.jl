module Kanones

using CitableObject, CitableParserBuilder
using Orthography, PolytonicGreek, AtticGreek
using Unicode, Glob, DelimitedFiles
using Documenter, DocStringExtensions

export parsetoken, parsewordlist
export dataset
export Stem, Rule 
export rulesarray, stemsarray
export UninflectedForm, UninflectedStem, UninflectedRule
export NounForm, NounStem, NounRule

export MorphologicalForm

export generate
export decline

include("parse.jl")
include("utils.jl")

include("datasets/dataset.jl")
include("datasets/kanonesio.jl")
include("datasets/uninflecteddata.jl")
include("datasets/nounsdata.jl")
include("datasets/finiteverbsdata.jl")

include("analyzer/analysis.jl")

include("generator/generate.jl")
include("generator/uninflectedgen.jl")
include("generator/nounsgen.jl")

# Conversion Form objects <-> URN values
include("morphology/forms.jl")
include("morphology/formvalues.jl")
include("morphology/forapps.jl")
include("morphology/uninflectedmorphology.jl")
include("morphology/nounmorphology.jl")
include("morphology/finiteverbmorphology.jl")

"Submodule to read a Kanones Dataset and build SFST parser."
module FstBuilder
    import ..Kanones
    using Glob, Unicode
    using CitableObject
    using CitableParserBuilder
    using Documenter, DocStringExtensions
    using Orthography, PolytonicGreek, AtticGreek
    
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