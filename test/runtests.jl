using Kanones
using Kanones.FstBuilder
using CitableObject, CitableParserBuilder
using PolytonicGreek, Orthography
using Test


include("test_morphologyids.jl")
include("test_morphologycex.jl")
include("test_morphforms.jl")

include("irregulars/test_irregrules.jl")

include("uninflected/test_uninflectedfst.jl")
include("uninflected/test_uninflecteddata.jl")
include("uninflected/test_uninflectedanalysis.jl")
include("uninflected/test_uninflectedgenerate.jl")

include("nouns/test_nounsfst.jl") 
include("nouns/test_nounsdata.jl")
include("nouns/test_nounsanalysis.jl")

include("nouns/test_nounsgenerate.jl")


include("infinitives/test_infinitivefst.jl") 
include("infinitives/test_infinitivesdata.jl") 
include("infinitives/test_infinitivesanalysis.jl") 

include("participles/test_participlesdata.jl") 
include("participles/test_participlesfst.jl") 
include("participles/test_participlesanalysis.jl") 

include("verbaladjectives/test_verbaladjectivesdata.jl")
include("verbaladjectives/test_verbaladjectivesfst.jl")
include("verbaladjectives/test_verbaladjectivesanalysis.jl")

include("test_parse.jl")
include("test_compile.jl")

include("finiteverb/test_verbsanalysis.jl")


#=
 =#