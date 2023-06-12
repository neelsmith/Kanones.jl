module Kanones

using CSV, DataFrames
using HTTP, Downloads

using CitableParserBuilder
import CitableParserBuilder: formurn
import CitableParserBuilder: parsetoken
import CitableParserBuilder: parselist
import CitableParserBuilder: parsecorpus
#import CitableParserBuilder: parsedocument
import CitableParserBuilder: CanParseCitable
import CitableParserBuilder: lexemes



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

export label

export dataset
export rulesarray, stemsarray, registry, compoundsarray
export inflectionclass
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

export GreekLexeme

export knormal
export generate, analysis_string
export decline, md_declension
export md_ptcpldeclension, participleslashline
export md_3endingadj
export synopsis, md_synopsis
export md_conjugation, md_imperativeconjugation
export md_proofconjugation_deponent, mdfile_proofconjugation_deponent
export md_proofconjugation, mdfile_proofconjugation


export writecsv

export urn, formurn, ruleurn

export StringParser, stringParser
export DFParser, dfParser

include("normal.jl")
include("kanonesio.jl")
include("dataset/dataset.jl")
include("dataset/fileslayout.jl")
include("dataset/filesdataset.jl")
include("dataset/compoundstems.jl")
include("dataset/stemreaders.jl")
include("dataset/infltypes.jl")
include("utils.jl")

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

include("forapps/adjdeclensions.jl")
include("forapps/noundeclensions.jl")
include("forapps/ptcpldeclensions.jl")
include("forapps/synopses.jl")
include("forapps/conjugations.jl")
include("forapps/conjugations_arrays.jl")
include("forapps/conjugation_deponents.jl")
include("forapps/analyses.jl")

include("parser/parser.jl")
include("parser/stringparser.jl")
include("parser/dfparser.jl")
include("parser/perfilebuilder.jl")

include("dfparser/survey.jl")



end # module