# Morphological properties


## Overview

Of the four data sets Kanones uses (vocabulary, forms, stems and rules), only one is not editable: forms.  The set of possible forms defines a morphology as "Greek".


Morphological forms (next page) are defined by unique sets of the morphological properties (that is, subtypes of `GreekMorphologicalProperty`) listed here.


```@example props
using Kanones
person = GMPPerson(3)
```

All properties work with the `label` and `code` functions.`

```@example props
label(person)
```

```@example props
code(person)
```

## Properties

The full set of properties is: person, number, tense, mood, voice, gender, case, degree and uninflected part of speech.


Properties may be constructed directly from numeric codes, or from the string value returned by its `label` function by using an  constructor function with identical name to the type but with initial lowercase `gmp`.

Person: three values labelled `first`, `second`, `third`.


```@example props
gmpPerson(3) == gmpPerson("third")
```

Number: three values labelled `singular`, `dual`, `plural`.

```@example props
gmpNumber(3) == gmpNumber("plural")
```

Tense: six values labelled `present`, `imperfect`, `aorist`, `perfect`, `pluperfect` and `future`.

```@example props
gmpTense(3) == gmpTense("aorist")
```


Mood: four values labelled `indicative`, `subjunctive`, `optative`, `imperative`.


```@example props
gmpMood(1) == gmpMood("indicative")
```


Voice: three values labelled `active`, `middle`, `passive`.

```@example props
gmpVoice(2) == gmpVoice("middle")
```


Gender: three values labelled `masculine`, `feminine`, `neuter`.


```@example props
gmpGender(2) == gmpGender("feminine")
```



Case: five values labelled `nominative`, `genitive`, `dative`, `accusative`, `vocative`.

```@example props
gmpCase(2) == gmpCase("genitive")
```


Degree: three values labelled `positive`, `comparative`, `superlative`.

```@example props
gmpDegree(2) == gmpDegree("comparative")
```

Uninflected part of speech: six values labelled `conjunction`,
    `preposition`, `particle`, `adverb`, `numeral`, `interjection`
   

```@example props
gmpUninflectedType(2) == gmpUninflectedType("preposition")
```

