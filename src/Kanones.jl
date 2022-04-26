module Kanones


using CitableParserBuilder
import CitableParserBuilder: parsetoken
import CitableParserBuilder: parsewordlist
import CitableParserBuilder: parsecorpus
import CitableParserBuilder: parsedocument
import CitableParserBuilder: CanParseCitable

export KanonesParser
export parsetoken, parsewordlist, parsecorpus, parsedocument

using CitableCorpus
using CitableObject
using Orthography, PolytonicGreek, AtticGreek
using Unicode, Glob, DelimitedFiles
using CSV
using Documenter, DocStringExtensions

using CitableBase: Citable
import CitableBase: CitableTrait
import CitableBase: urn
import CitableBase: label
import CitableBase: cex

export urn, label, cex

export dataset
export rulesarray, stemsarray

export GreekMorphologicalProperty
export GMPVoice, gmpVoice
export GMPMood, gmpMood
export GMPTense, gmpTense
export GMPPerson, gmpPerson
export GMPNumber, gmpNumber
export GMPGender, gmpGender
export GMPCase, gmpCase
export GMPDegree, gmpDegree
export GMPUninflectedType, gmpUninflectedType
export code

export GreekMorphologicalForm
export greekForm
export KanonesRule, inflectionClass, ending
export KanonesStem, lexeme, stemstring
export GMFFiniteVerb, gmfFiniteVerb, VerbStem, FiniteVerbRule
export GMFInfinitive, gmfInfinitive, InfinitiveRule
export GMFVerbalAdjective, gmfVerbalAdjective, VerbalAdjectiveRule
export GMFParticiple, gmfParticiple, ParticipleRule

export GMFNoun, gmfNoun, NounStem, NounRule
export GMFPronoun, gmfPronoun, PronounStem, PronounRule
export GMFAdjective, gmfAdjective, AdjectiveStem, AdjectiveRule
export GMFAdverb, gmfAdverb

export GMFUninflected, gmfUninflected, UninflectedStem, UninflectedRule

export IrregularRule
export IrregularNounStem
export IrregularVerbStem
export IrregularInfinitiveStem

export GreekLexeme

export generate, analysis_string
export decline, mddeclension

export urn, formurn
export ruleurn # ??

#=
include("parse.jl")
include("listparsing.jl")
include("utils.jl")

include("dataset.jl")
=#
include("kanonesio.jl")

# include("analyzer/analysis.jl")

#=
include("lexemes/lexeme.jl")
include("lexemes/lexica.jl")
=#

include("citable_forms/forms.jl")
include("citable_stems/stems.jl")
include("citable_rules/rules.jl")

include("morphologicalproperties/properties.jl")
include("morphologicalproperties/tense.jl")
include("morphologicalproperties/mood.jl")
include("morphologicalproperties/voice.jl")
include("morphologicalproperties/person.jl")
include("morphologicalproperties/number.jl")
include("morphologicalproperties/gender.jl")
include("morphologicalproperties/case.jl")
include("morphologicalproperties/degree.jl")
include("morphologicalproperties/uninflectedtype.jl")


include("citable_forms/formvalues.jl")
#include("morphology/forapps.jl")
#include("citable_forms/kanonesformurns.jl")
#include("citable_forms/irregularmorphology.jl")

#include("citable_rules/irregulars.jl")

include("citable_forms/finiteverbs.jl")
#include("citable_stems/verbs.jl")
#include("citable_stems/irregularverbs.jl")
#include("citable_rules/finiteverbs.jl")

# regular stems are drawn from finite verb stems
include("citable_forms/infinitives.jl")
#include("citable_stems/irregularinfinitives.jl")
#include("citable_rules/infinitives.jl")

include("citable_forms/participles.jl")
#include("citable_rules/participles.jl")

include("citable_forms/verbaladjectives.jl")
#include("citable_rules/verbaladjectives.jl")

include("citable_forms/nouns.jl")
include("citable_rules/nounrules.jl")
include("citable_stems/regularnouns.jl")
#include("citable_stems/irregularnouns.jl")


include("citable_forms/adjectives.jl")
include("citable_rules/adjectiverules.jl")
#include("citable_stems/regularadjectives.jl")
#include("citable_stems/irregularadjectives.jl")

include("citable_forms/adverbs.jl")


include("citable_forms/pronouns.jl")
#include("citable_stems/pronouns.jl")
#include("citable_rules/pronouns.jl")


include("citable_forms/uninflected.jl")
#include("citable_stems/uninflected.jl")
#include("citable_rules/uninflected.jl")


include("generate/generate.jl")
#include("generator/uninflectedgen.jl")
include("generate/generatenoun.jl")


end # module