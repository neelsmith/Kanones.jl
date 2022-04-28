
# Julia language API documentation


```@contents
Pages = ["apis.md"]
Depth = 3
```
## Morphology


```@docs
GreekMorphologicalProperty
GMPVoice
gmpVoice
GMPMood
gmpMood
GMPTense
gmpTense
GMPPerson
gmpPerson
GMPNumber
gmpNumber
GMPGender
gmpGender
GMPCase
gmpCase
GMPDegree
gmpDegree
GMPUninflectedType
gmpUninflectedType
code

GreekMorphologicalForm
KanonesStem
KanonesRule
greekForm
GMFFiniteVerb
gmfFiniteVerb
VerbStem
FiniteVerbRule
GMFInfinitive
gmfInfinitive
InfinitiveRule
GMFVerbalAdjective
gmfVerbalAdjective
VerbalAdjectiveRule
GMFParticiple
gmfParticiple
ParticipleRule

GMFNoun
gmfNoun
NounStem
NounRule
GMFPronoun
gmfPronoun
PronounStem
PronounRule
GMFAdjective
gmfAdjective
AdjectiveStem
AdjectiveRule

GMFUninflected
gmfUninflected
UninflectedStem
UninflectedRule

IrregularRule
IrregularNounStem
IrregularVerbStem
IrregularInfinitiveStem

GreekLexeme
```


```@docs
generate
decline
md_declension
formurn
```


### Functions


Exported: 

```@docs
dataset
rulesarray
stemsarray
```

Internals:

```@docs
Kanones.readstemrow
Kanones.readrulerow
Kanones.id
Kanones.lexeme
Kanones.abbrformurn
```


## Analysis

### Exported functions

```@docs
parsetoken
parsewordlist
parsedocument
parsecorpus
```

### Functions used internally in parsing via a FST

```@docs
Kanones.stemsforlex
Kanones.fstinflpath
Kanones.echopath
Kanones.functionforcategory
Kanones.parsefst
Kanones.applyparser
```

## Generation


Exported:

```@docs
generate
```

Internal:
```@docs
Kanones.generateuninflected
Kanones.generatenoun
```

## `Kanones.FstBuilder`

The functions of the `FstBuilder` submodule compose expressions in SFST-PL, the language of the Stuttgart FST toolkit.

```@docs
Kanones.FstBuilder.buildparser
Kanones.FstBuilder.buildlexicon
Kanones.FstBuilder.buildinflection
Kanones.FstBuilder.buildfinalfst
Kanones.FstBuilder.buildmakefile
Kanones.FstBuilder.compilefst
Kanones.FstBuilder.buildacceptor
Kanones.FstBuilder.uninflsquasher
Kanones.FstBuilder.nounsquasher
Kanones.FstBuilder.installalphabet
Kanones.FstBuilder.installsymbols
Kanones.FstBuilder.symbolsfst
Kanones.FstBuilder.fstok
Kanones.FstBuilder.cmdok
Kanones.FstBuilder.fst
Kanones.FstBuilder.addsmooth
Kanones.FstBuilder.addrough
Kanones.FstBuilder.greekfromfst
Kanones.FstBuilder.fstgreek
```
