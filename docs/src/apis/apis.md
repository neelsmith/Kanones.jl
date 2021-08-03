
# Julia language API documentation


```@contents
Pages = ["apis.md"]
Depth = 3
```
## Morphology

### Structures

```@docs
MorphologicalForm
Kanones.UninflectedForm
Kanones.NounForm
Kanones.FiniteVerbForm
```


### Functions

```@docs
Kanones.urn
Kanones.cex
Kanones.morphform
Kanones.abbrurn
Kanones.formscex
Kanones.pospairs
Kanones.uninflectedpairs
Kanones.casepairs
Kanones.personpairs
Kanones.numberpairs
Kanones.voicepairs
Kanones.tensepairs
Kanones.moodpairs
Kanones.valuedict
Kanones.labeldict
Kanones.nounform
Kanones.nounabbrurn
Kanones.nounscex
Kanones.uninflectedform
Kanones.uninflectedabbrurn
Kanones.uninflectedcex
Kanones.finiteverbabbrurn
Kanones.labelform
```

## Datasets

### Structures

```@docs
Kanones.Dataset
Kanones.KanonesIO
Kanones.NounParser
Kanones.NounStem
Kanones.NounRule
Kanones.UninflectedParser
Kanones.UninflectedStem
Kanones.UninflectedRule
Kanones.VerbParser
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
```

### Functions used internally in parsing via a FST

```@docs
Kanones.stemsforlex
Kanones.fstinflpath
Kanones.echopath
Kanones.functionfollowsform
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