# Morphological forms

Form types are subtypes of `GreekMorphologicalForm`, and are defined by a group of morphological properties.

## Substantives

There are three types of substantive form.  They are instantiated from three rule types and three stem types.

`GMFNoun`: has `GMPGender`, `GMPCase`, `GMPNumber`.  Note that gender is *inherent* (see user's guide on stem records)


`GMFPronoun`: has `GMPGender`, `GMPCase`, `GMPNumber` but in contrast to `GMFNoun`, gender can vary.


`GMFAdjective`: has `GMPGender`, `GMPCase`, `GMPNumber` and `GMPDegree`.


## Adverbs

`GMFAdverb` has `GMPDegree`.  Distinct rule type combined with stems for adjective.

## Verbal forms

Verb stems combine with distinct rule types for:


`GMFFiniteVerb`: `GMPPerson`, `GMPNumber`, `GMPTense`, `GMPMood`, `GMPVoice`

`GMFInfinitive`:  `GMPTense`, `GMPVoice`

`GMFParticiple`:  `GMPTense`, `GMPVoice`, `GMPGender`, `GMPCase`, `GMPNumber`

`GMFVerbalAdjecive`: `GMPGender`, `GMPCase`, `GMPNumber`; no degree; unlike nouns and pronouns, derived from a verbal stem.


## Uninflected forms

`GMFUninflected` have `GMPUninflectedType`.  Distinct rule type and stem type.