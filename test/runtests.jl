using Kanones
using Kanones.FstBuilder
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using PolytonicGreek, Orthography
using Test

# =
include("test_morphologyids.jl")
include("test_morphologycex.jl")
include("test_morphforms.jl")
include("test_formurnparsing.jl")
# =#

# =
include("test_parse.jl")
include("test_compile.jl")
# =#

include("test_lexeme.jl")


# =
include("parsing_output/test_nounsparsing.jl")
include("parsing_output/test_adjsparsing.jl")
include("parsing_output/test_infinitivesparsing.jl")
include("parsing_output/test_finiteverbparsing.jl")
include("parsing_output/test_verbaladjectivesparsing.jl")
include("parsing_output/test_participlesparsing.jl") 
include("parsing_output/test_pronounsparsing.jl")
# =#

# =
include("nouns/test_nounsgenerate.jl")
# =#



# =
include("irregulars/test_irregrules.jl")

include("uninflected/test_uninflectedfst.jl")
include("uninflected/test_uninflecteddata.jl")
include("uninflected/test_uninflectedanalysis.jl")
include("uninflected/test_uninflectedgenerate.jl")




# =#

# =

include("adjectives/test_1.adjectivesdata.jl")
include("adjectives/test_2.adjectivesfst.jl")
include("adjectives/test_3.adjectiveforms.jl")
include("adjectives/test_4.adjectivestems.jl")
include("adjectives/test_5.adjectiverules.jl")


include("infinitives/test_1.infinitivesdata.jl") 
include("infinitives/test_2.infinitivesfst.jl") 
include("infinitives/test_3.infinitiveforms.jl")
include("infinitives/test_4.infinitivestems.jl")
include("infinitives/test_5.infinitiverules.jl")


include("verbaladjectives/test_1.verbaladjectivesdata.jl")
include("participles/test_1.participlesdata.jl") 

include("verbaladjectives/test_2.verbaladjectivesfst.jl")
include("participles/test_2.participlesfst.jl") 

include("verbaladjectives/test_3.verbaldjectiveforms.jl")
include("participles/test_3.participleforms.jl")

include("verbaladjectives/test_5.verbaladjectiverules.jl")
include("participles/test_5.participlerules.jl")




include("nouns/test_4.nounstems.jl")
include("nouns/test_5.nounrules.jl")


include("nouns/test_1.nounsdata.jl")
include("pronouns/test_1.pronounsdata.jl")

include("nouns/test_2.nounsfst.jl") 
include("pronouns/test_2.pronounsfst.jl")
# =#


include("nouns/test_3.nounforms.jl")
include("pronouns/test_3.pronounforms.jl")