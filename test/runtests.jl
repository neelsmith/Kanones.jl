using Kanones
using CitableBase, CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using PolytonicGreek, Orthography
using Unicode
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
include("rules/test_uninflectedrules.jl")
include("rules/test_irregularrules.jl")


include("stems/test_nounstems.jl")
include("stems/test_adjstems.jl")
include("stems/test_verbstems.jl")
include("stems/test_pronstems.jl")
include("stems/test_irregularnounstems.jl")
include("stems/test_irregularadjstems.jl")
include("stems/test_irregularinfinitivestems.jl")
include("stems/test_irregularfiniteverbstems.jl")


include("test_datasets.jl")


include("generate/test_generate.jl")
include("principalparts/test_principalparts.jl")

include("test_verbspipeline.jl")


include("parser/test_formsinventory.jl")
include("parser/test_parse.jl")
