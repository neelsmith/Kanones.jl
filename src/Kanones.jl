module Kanones

using CitableParserBuilder: AnalyzedToken
using CitableParserBuilder: CitableByCite2Urn
using CitableParserBuilder: CitableParser
using CitableParserBuilder: LexemeUrn, StemUrn, FormUrn, RuleUrn, AbbreviatedUrn, expand
using CitableParserBuilder: Rule, Stem, Analysis
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
using CSV, HTTP
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

export GreekMorphologicalForm

export GMFFiniteVerb, VerbStem, FiniteVerbRule
export InfinitiveForm, InfinitiveRule
export VerbalAdjectiveForm, VerbalAdjectiveRule
export ParticipleForm, ParticipleRule

export NounForm, NounStem, NounRule
export PronounForm, PronounStem, PronounRule
export AdjectiveForm, AdjectiveStem, AdjectiveRule

export UninflectedForm, UninflectedStem, UninflectedRule


export IrregularRule
export IrregularNounForm, IrregularNounStem
export IrregularVerbForm, IrregularVerbStem
export IrregularInfinitiveForm, IrregularInfinitiveStem

export Lexeme

export generate
export decline, mddeclension

export urn, ruleurn

include("parse.jl")
include("listparsing.jl")
include("utils.jl")

include("dataset.jl")
include("kanonesio.jl")

include("analyzer/analysis.jl")

include("generator/generate.jl")
include("generator/uninflectedgen.jl")
include("generator/nounsgen.jl")

include("lexeme.jl")
include("lsj/labels.jl")


include("morphology/forms.jl")

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

include("morphology/formvalues.jl")
include("morphology/forapps.jl")
include("morphology/kanonesformurns.jl")
include("morphology/irregularmorphology.jl")

include("citable_rules/irregulars.jl")

include("citable_forms/finiteverbs.jl")
include("citable_stems/verbs.jl")
include("citable_stems/irregularverbs.jl")
include("citable_rules/finiteverbs.jl")

# regular stems are drawn from finite verb stems
include("citable_forms/infinitives.jl")
include("citable_stems/irregularinfinitives.jl")
include("citable_rules/infinitives.jl")

include("citable_forms/participles.jl")
include("citable_rules/participles.jl")

include("citable_forms/verbaladjectives.jl")
include("citable_rules/verbaladjectives.jl")

include("citable_forms/nouns.jl")
include("citable_stems/regularnouns.jl")
include("citable_stems/irregularnouns.jl")
include("citable_rules/nouns.jl")

include("citable_forms/adjectives.jl")
include("citable_rules/adjectives.jl")
include("citable_stems/regularadjectives.jl")
include("citable_stems/irregularadjectives.jl")

include("citable_forms/pronouns.jl")
include("citable_stems/pronouns.jl")
include("citable_rules/pronouns.jl")


include("citable_forms/uninflected.jl")
include("citable_stems/uninflected.jl")
include("citable_rules/uninflected.jl")



"Submodule to read a Kanones Dataset and build SFST parser."
module FstBuilder
    import ..Kanones
    using Glob, Unicode
    using CitableObject
    using CitableParserBuilder
    using Documenter, DocStringExtensions
    using Orthography, PolytonicGreek, AtticGreek
    
    export buildparser

    include("builder/unicodefst.jl")
    include("builder/config.jl")
    include("builder/compiler.jl")
    include("builder/fstcomposer.jl")
    include("builder/acceptorsquashers.jl")
    
    # Specific analytical types ("parts of speech")
    include("builder/uninflectedfst.jl")
    include("builder/nounsfst.jl")
    include("builder/pronounsfst.jl")
    include("builder/adjectivesfst.jl")
    include("builder/irregularadjsfst.jl")
    include("builder/irregularnounsfst.jl")
    include("builder/irregularverbsfst.jl")
    include("builder/irregularinfinitivesfst.jl")
    include("builder/irregularrulesfst.jl")

    include("builder/finiteverbsfst.jl")
    include("builder/infinitivesfst.jl")
    include("builder/participlesfst.jl")
    include("builder/verbaladjectivesfst.jl")
end

end # module