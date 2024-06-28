module Kanones

import Base: show
import Base.==

using CSV
using HTTP, Downloads

# This is only for profiling, currently used in scripts in scripts 
# directory, but not in package:
#using OrderedCollections, StatsBase

using CitableParserBuilder
import CitableParserBuilder: parsetoken #, parsewordlist,  parselistfromfile, parselistfromurl
import CitableParserBuilder: tofile
import CitableParserBuilder: datasource
import CitableParserBuilder: orthography
import CitableParserBuilder: delimiter
import CitableParserBuilder: generate
import CitableParserBuilder: lexemeurn
import CitableParserBuilder: stringParser
import CitableParserBuilder: analyses

export KanonesParser, KanonesStringParser
export parsetoken, parsewordlist, parsecorpus, parsedocument
export formlabels

using CitableCorpus
using CitableObject
using Orthography, PolytonicGreek, AtticGreek
using Unicode, Glob, DelimitedFiles
using CSV
using Documenter, DocStringExtensions

using CitableBase
import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

using CitableCollection
using Tables


export label

export dataset
export rulesarray, stemsarray, registry, compoundsarray
export inflectionclass, lexemeclassindex
export sortbylsj, sortbylsj!, sortdirbylsj!, sortregularstems!

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
export greekForm, allforms
export KanonesRule, inflectionclass, ending
export KanonesStem, lexeme, stemstring
export GMFFiniteVerb, gmfFiniteVerb, VerbStem, FiniteVerbRule
export GMFInfinitive, gmfInfinitive, InfinitiveRule
export GMFVerbalAdjective, gmfVerbalAdjective, VerbalAdjectiveRule
export GMFParticiple, gmfParticiple, ParticipleRule

export CompoundVerbStem, compoundstem
export simplex, prefix

export GMFNoun, gmfNoun, NounStem, NounRule
export GMFPronoun, gmfPronoun, PronounStem, PronounRule
export GMFAdjective, gmfAdjective, AdjectiveStem, AdjectiveRule
export GMFAdverb, gmfAdverb

export GMFUninflected, gmfUninflected, UninflectedStem, UninflectedRule

export IrregularRule
export IrregularNounStem
export IrregularAdjectiveStem
export IrregularVerbStem
export IrregularInfinitiveStem
export IrregularParticipleStem

export GreekLexeme
export lemmatadict, lemmalabel, lsjcollection

export resolvestring, knormal 
export generate, analysis_string

export principalparts
export decline, declension_md
export ptcpldeclension_md, ptcplsynopsis_md,  participleslashline
export three_ending_adj_md
export pronoun_md
export synopsis, synopsis_md
export conjugation_md, imperativeconjugation_md
export verb_conjugation_md
export lexicon_noun_md

#export writecsv

export urn, formurn, ruleurn

export KanonesStringParser, kanonesStringParser
#export DFParser, dfParser
# export TabulaeStringParser, tabulaeStringParser
export orthography

export InflectionCategory

include("normal.jl")
include("kanonesio.jl")
include("dataset/dataset.jl")
include("dataset/fileslayout.jl")
include("dataset/filesdataset.jl")
include("dataset/compoundstems.jl")
include("dataset/stemreaders.jl")
include("dataset/infltypes.jl")

include("utils/utils.jl")
include("utils/workflow.jl")

include("lexemes/lexeme.jl")
include("lexemes/lexica.jl")

include("citable_rules/rules.jl")
include("citable_stems/stems.jl")
include("citable_forms/forms.jl")

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

include("citable_rules/irregularrules.jl")

include("citable_forms/finiteverbs.jl")
include("citable_rules/finiteverbrules.jl")
include("citable_stems/regularverbstems.jl")
include("citable_stems/irregularfiniteverbstems.jl")
include("citable_stems/irregularparticiplestems.jl")
include("citable_stems/compoundverbs.jl")
include("citable_stems/irregularcompounds.jl")

# regular stems are drawn from finite verb stems
include("citable_forms/infinitives.jl")
include("citable_rules/infinitiverules.jl")
include("citable_stems/irregularinfinitivestems.jl")

include("citable_forms/participles.jl")
include("citable_rules/participlerules.jl")

include("citable_forms/verbaladjectives.jl")
include("citable_rules/verbaladjectiverules.jl")

include("citable_forms/nouns.jl")
include("citable_rules/nounrules.jl")
include("citable_stems/regularnounstems.jl")
include("citable_stems/irregularnounstems.jl")

include("citable_forms/adjectives.jl")
include("citable_rules/adjectiverules.jl")
include("citable_stems/regularadjectivestems.jl")
include("citable_stems/irregularadjectivestems.jl")

include("citable_forms/adverbs.jl")
#include("citable_rules/adverbsrules.jl")

include("citable_forms/pronouns.jl")
include("citable_stems/pronounstems.jl")
include("citable_rules/pronounrules.jl")

include("citable_forms/uninflected.jl")
include("citable_rules/uninflectedrules.jl")
include("citable_stems/uninflectedstems.jl")

include("generate/generate.jl")
include("generate/generatenoun.jl")
include("generate/generateadj.jl")
include("generate/generatefiniteverb.jl")
include("generate/generateverbaladj.jl")
include("generate/verbparts.jl")
include("generate/generateinfinitive.jl")
include("generate/generateptcpl.jl")
include("generate/generatepronoun.jl")
include("generate/generateuninflected.jl")
include("generate/generateirregular.jl")
include("generate/debug.jl")

include("parser/parser.jl")
include("parser/stringparser.jl")
#include("parser/dfparser.jl")
include("parser/perfilebuilder.jl")


include("forapps/adjdeclensions.jl")
include("forapps/noundeclensions.jl")
include("forapps/pronoundeclensions.jl")
include("forapps/ptcpldeclensions.jl")
include("forapps/synopses.jl")
include("forapps/conjugations.jl")
include("forapps/conjugations_arrays.jl")
include("forapps/conjugation_deponents.jl")
include("forapps/nonfinite_md.jl")
include("forapps/fullverb_md.jl")
include("forapps/princparts.jl")
include("forapps/ptcplsynopses.jl")
include("forapps/analyses.jl")
include("forapps/infinitives.jl")



include("dfparser/survey.jl")

include("inflectionclassmetadata/inflectionclass.jl")

include("orthography/literarygreek.jl")


end # module