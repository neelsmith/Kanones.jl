module Kanones

using CitableParserBuilder
import CitableParserBuilder: parsetoken
import CitableParserBuilder: parsewordlist
import CitableParserBuilder: parsecorpus
import CitableParserBuilder: parsedocument
import CitableParserBuilder: CanParseCitable

export KanonesParser
export parsetoken, parsewordlist

using CitableCorpus
using CitableObject
using Orthography, PolytonicGreek, AtticGreek
using Unicode, Glob, DelimitedFiles
using CSV, HTTP
using Documenter, DocStringExtensions

import CitableBase: CitableTrait
import CitableBase: urn
import CitableBase: label
import CitableBase: cex

export urn, label, cex

export dataset
export rulesarray, stemsarray
export UninflectedForm, UninflectedStem, UninflectedRule
export NounForm, NounStem, NounRule
export AdjectiveForm
export FiniteVerbForm, VerbStem

export IrregularRule
export IrregularNounForm, IrregularNounStem
export IrregularVerbForm, IrregularVerbStem
export IrregularInfinitiveForm, IrregularInfinitiveStem


export MorphologicalForm

export generate
export decline, mddeclension

export urn, abbrurn

include("parse.jl")
include("listparsing.jl")
include("utils.jl")

include("datasets/dataset.jl")
include("datasets/kanonesio.jl")
include("datasets/uninflecteddata.jl")
include("datasets/nounsdata.jl")
include("datasets/pronounsdata.jl")
include("datasets/irregularnounsdata.jl")
include("datasets/irregularverbsdata.jl")
include("datasets/irregularinfinitivedata.jl")
include("datasets/irregularrules.jl")
include("datasets/finiteverbsdata.jl")
include("datasets/infinitivedata.jl")
include("datasets/participledata.jl")
include("datasets/verbaladjectivedata.jl")
include("datasets/adjectivesdata.jl")

include("analyzer/analysis.jl")

include("generator/generate.jl")
include("generator/uninflectedgen.jl")
include("generator/nounsgen.jl")

include("lsj/labels.jl")

# Conversion Form objects <-> URN values
include("morphology/forms.jl")
include("morphology/formvalues.jl")
include("morphology/forapps.jl")
include("morphology/kanonesformurns.jl")


include("morphology/irregularmorphology.jl")
include("morphology/uninflectedmorphology.jl")
include("morphology/nounmorphology.jl")
include("morphology/pronounmorphology.jl")
include("morphology/adjectivemorphology.jl")
include("morphology/finiteverbmorphology.jl")
include("morphology/infinitivemorphology.jl")
include("morphology/participlemorphology.jl")
include("morphology/verbaladjectivemorphology.jl")

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