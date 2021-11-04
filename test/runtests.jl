using Kanones
using Kanones.FstBuilder
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using PolytonicGreek, Orthography
using Test

#=
include("test_morphologyids.jl")
include("test_morphologycex.jl")
include("test_morphforms.jl")
include("test_formurnparsing.jl")

include("irregulars/test_irregrules.jl")

include("uninflected/test_uninflectedfst.jl")
include("uninflected/test_uninflecteddata.jl")
include("uninflected/test_uninflectedanalysis.jl")
include("uninflected/test_uninflectedgenerate.jl")


include("pronouns/test_pronounsdata.jl")
include("pronouns/test_pronounsfst.jl")
include("pronouns/test_pronounsanalysis.jl")

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









include("nouns/test_nounsgenerate.jl")





include("nouns/test_nounsdata.jl")
include("adjectives/test_adjectivesdata.jl")

include("nouns/test_nounsfst.jl") 
include("adjectives/test_adjectivesfst.jl")
include("nouns/test_nounsformatting.jl")
include("adjectives/test_adjsformatting.jl")



include("parsing_output/test_nounsparsing.jl")
include("parsing_output/test_adjsparsing.jl")

=#



include("nouns/test_nounstems.jl")
include("nouns/test_nounrules.jl")