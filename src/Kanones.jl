module Kanones

using CitableObject, CitableParserBuilder
using Unicode

export AbbreviatedUrn
export StemUrn, RuleUrn, LexemeUrn, FormUrn, Analysis
export parsetoken

export UninflectedForm, NounForm

include("dataset.jl")
include("parse.jl")
include("analysis.jl")

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
    include("builder/nouns.jl")
end

end # module