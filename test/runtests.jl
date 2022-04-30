using Kanones
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using PolytonicGreek, Orthography
using Test

include("properties/test_properties.jl")

include("forms/test_formparsing.jl")
include("forms/test_adjectives.jl")
include("forms/test_adverbs.jl")
include("forms/test_finiteverbs.jl")
include("forms/test_infinitives.jl")
include("forms/test_nouns.jl")
include("forms/test_participles.jl")
include("forms/test_pronouns.jl")
include("forms/test_uninflected.jl")
include("forms/test_verbaladjs.jl")

include("rules/test_adjrules.jl")
include("rules/test_nounrules.jl")
include("rules/test_finiteverbrules.jl")
include("rules/test_verbaladjrules.jl")
include("rules/test_infinitiverules.jl")
include("rules/test_ptcplrules.jl")
include("rules/test_pronounrules.jl")


include("stems/test_nounstems.jl")
include("stems/test_adjstems.jl")
include("stems/test_verbstems.jl")
include("stems/test_pronstems.jl")


include("test_datasets.jl")


include("generate/test_generate.jl")
include("principalparts/test_principalparts.jl")


include("parser/test_formsinventory.jl")
include("parser/test_parse.jl")

#=
include("test_morphologyids.jl")
include("test_morphologycex.jl")
include("test_morphforms.jl")
include("test_formurnparsing.jl")
include("test_lexeme.jl")

include("test_parse.jl")
include("test_compile.jl")

include("parsing_output/test_adjsparsing.jl")
include("parsing_output/test_nounsparsing.jl")
include("parsing_output/test_infinitivesparsing.jl")
include("parsing_output/test_verbaladjectivesparsing.jl")
include("parsing_output/test_participlesparsing.jl") 
include("parsing_output/test_pronounsparsing.jl")
include("parsing_output/test_uninflectedparsing.jl")
include("parsing_output/test_finiteverbparsing.jl")

include("generate/test_nounsgenerate.jl")
include("generate/test_uninflectedgenerate.jl")

include("irregulars/test_irregrules.jl")
include("test_morphproperties.jl")

include("finiteverbs/test_1.verbsdata.jl")
include("finiteverbs/test_2.verbsfst.jl") 
include("finiteverbs/test_3.verbforms.jl")
include("finiteverbs/test_4.verbstems.jl")
include("finiteverbs/test_5.finiteverbrules.jl")

include("nouns/test_1.nounsdata.jl")
include("nouns/test_2.nounsfst.jl") 
include("nouns/test_3.nounforms.jl")
include("nouns/test_4.nounstems.jl")
include("nouns/test_5.nounrules.jl")

include("pronouns/test_1.pronounsdata.jl")
include("pronouns/test_2.pronounsfst.jl")
include("pronouns/test_3.pronounforms.jl")
include("pronouns/test_4.pronounstems.jl")
include("pronouns/test_5.pronounrules.jl")

include("infinitives/test_1.infinitivesdata.jl") 
include("infinitives/test_2.infinitivesfst.jl") 
include("infinitives/test_3.infinitiveforms.jl")
include("infinitives/test_4.infinitivestems.jl")
include("infinitives/test_5.infinitiverules.jl")

include("verbaladjectives/test_1.verbaladjectivesdata.jl")
include("verbaladjectives/test_2.verbaladjectivesfst.jl")
include("verbaladjectives/test_3.verbaldjectiveforms.jl")
include("verbaladjectives/test_5.verbaladjectiverules.jl")

include("participles/test_1.participlesdata.jl") 
include("participles/test_2.participlesfst.jl") 
include("participles/test_3.participleforms.jl")
include("participles/test_5.participlerules.jl")

include("adjectives/test_1.adjectivesdata.jl")
include("adjectives/test_2.adjectivesfst.jl")
include("adjectives/test_3.adjectiveforms.jl")
include("adjectives/test_4.adjectivestems.jl")
include("adjectives/test_5.adjectiverules.jl")

include("uninflected/test_1.uninflecteddata.jl")
include("uninflected/test_2.uninflectedfst.jl")
include("uninflected/test_3.uninflectedforms.jl")
include("uninflected/test_4.uninflectedstems.jl")
include("uninflected/test_5.uninflectedrules.jl")

include("accessors/test_nounaccessors.jl")
include("accessors/test_pronounaccessors.jl")
include("accessors/test_adjaccessors.jl")
include("accessors/test_verbaccessors.jl")
include("accessors/test_infinitiveaccessors.jl")
include("accessors/test_ptcplaccessors.jl")
include("accessors/test_vadjaccessors.jl")
include("accessors/test_uninflectedaccessors.jl")
=#