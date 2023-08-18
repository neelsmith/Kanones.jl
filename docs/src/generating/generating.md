# Implementation:  overview of generating a form


The `generate` function has multiple methods (see API for details).  We'll follow, from the top down, the process of generating a token for a given lexeme (identified by a `LexemeUrn`) and morphological form (identified by a `FormUrn`), using a given Kanones dataset.


## Following the dispatch trail


### Find stem and rule pairs

The generating algorithm first selects from the cross product of stems and rules in the dataset all stem/rule combinations matching the requested lexeme and form.  Stems are subtypes of the abstract `KanonesStem`; rules are subtypes of the abstract `KanonesRule`.

!!! info "Matching requested forms"
    Kanones datasets store form information for regular formations in the rules tables of the data set. Irregular formations identify forms in the stems tables for irregulars.  Thus when the type of the rule is `IrregularRule` , `generate` tests whether the form of the *stem* matches the requested form; otherwise, it tests on the form of the *rule*.  This is straightforward since subtypes of both `KanonesStem` and of `KanonesRule` implement the `formurn` function.


### Dispatch to appropriate subtypes of stem and rule

The next step is to invoke `generate` using the stem and rule pair as parameters. We have advanced the problem from the abstraction of a lexeme and form to the concrete problem of generating a token using a specific stem and specific rule.

This method of `generate` further dispatches based on the type of the stem and rule.  For regular formations, each of Kanones' analytical types ("parts of speech", described [here](../../../forms/)) has a method of `generate` to handle a corresponding pair of rule and stem types:

| Analytical type | Stem type | Rule type |
| --- | --- | --- |
| `GMFNoun` | `NounStem` | `NounRule` |
| `GMFPronoun` | `PronounStem` | `PronounRule` |
| `GMFAdjective` | `AdjectiveStem` | `AdjectiveRule` |
| `GMFAdverb` | `AdjectiveStem` | `AdverbRule` |
| `GMFFiniteVerb` | `VerbStem` | `FiniteVerbRule` |
| `GMFInfinitive` | `VerbStem` | `InfinitiveRule` |
| `GMFParticiple` | `VerbStem` | `ParticipleRule` |
| `GMFVerbalAdjective` | `VerbStem` | `VerbalAdjectiveRule` |
| `GMFUninflected` | `UninflectedStem` | `UninflectedRule` |

For irregular forms, `generate` dispatches to a single function for the `IrregularRule` type and any `StemType`.

### Irregular forms


!!! danger "Add note here"
    Need to add a note on how irregular forms are returned.

### Regular forms: concatenating stem and inflection

Conceptually, we want combine the string data included in stems and rules, and found with the `stemstring` and `ending` functions.  Essentially, regular forms can now be found by concatenating them:

    stemstring(stem) * ending(rule)

However, there are numerous specific details that need to be considered, such as phonological changes required by Greek string concatenation, or addition of augment or reduplication for verb forms.  These are documented in more detail in the following pages.

### Regular forms: applying accent

The final step is to apply the appropriate accent to the concatenated string.  Accenting Greek words depends on:

- phonological considerations (such as vowel quantity)
- lexical considerations (such as derivation of verb forms from compounds) 
- morphological considerations (such as the basic principle that finite verb forms have recessive accent, while substantives have persistent accent)

The details of this process are documented in the following pages.

