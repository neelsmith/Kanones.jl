using Kanones
using Kanones.FstBuilder
using CitableObject, CitableParserBuilder
using PolytonicGreek
using Test


#==#
include("test_morphologyids.jl")
include("test_morphologycex.jl")

include("uninflected/test_uninflectedfst.jl")
include("uninflected/test_uninflecteddata.jl")
include("uninflected/test_uninflectedanalysis.jl")
include("uninflected/test_uninflectedgenerate.jl")

include("nouns/test_nounsfst.jl") 
include("nouns/test_nounsdata.jl")
include("nouns/test_nounsanalysis.jl")

include("nouns/test_nounsgenerate.jl")

include("test_parse.jl")
include("test_compile.jl")

#=
 =#