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

include("test_nouns.jl")

include("test_parse.jl")
include("test_compile.jl")


#= =#