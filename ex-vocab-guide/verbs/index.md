# Verb paradigms and inflectional classes


## Cataloging verb stems in a Kanones dataset

Verb stems are of two types: *simplex*, and *compound*. You catalog simplex verbs in `stems-tables/verbs-simplex`, and compounds in `stems-tables/verbs-compound`.


## Simplex verbs

For *regular* simplex verb stems, you record four pieces of information:

1. a `StemUrn`
2. a `LexemeUrn`
3. the stem (a string value)
4. its inflectional class

κελεύω is an example of a perfectly regular verb:  all its forms can be derived from a single stem entry.  It has the [identifier `n56496` in LSJ](http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n56496), so we will use `lsj.n56496` for its `LexemeUrn`.  Since we only need one stem for this verb, we can use `verbstems.n56496` for the `StemUrn` and be certain that its value will be unique in both the lexeme and stem collections.

κελεύω belongs to the inflectional class `w_regular` ("regular -ω verbs"); the string value for the single stem needed for verbs in this class is formed by dropping -ω from the first singular present indicative active


```
StemUrn|LexemeUrn|Stem|InflectionalClass|
verbstems.n56496|lsj.n56496|κελευ|w_regular|
```


## Compound verbs

In order for Kanones to form augmented and reduplicated forms correctly, we need to record how a compound verb relates to its corresponding simplex form.  We can do this with four pieces of information:

1. a `StemUrn` for the compound stem
1. a `LexemeUrn` of the compound verb
1. the string to prefix to the simplex form
1. the `LexemeUrn` of the simplex verb

In addition, Kanones allows to append arbitrary notes in a fifth column; it is good practice to record here for human readers a recognizable lemma for the compound verb.

For example, ἐγκελεύω is a compound of the prefix ἐν and the simplex verb κελεύω, which we previously cataloged.  Its [identifier in LSJ is `n30252`](http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n30252), so its `LexemeUrn` will be `lsj.n30252`. As we did before, we can use this identifier to create a unique value for the single stem required, which we will call `compounds.n30252`.  We do not need to record a stem string, so that will be taken from the simplex verb. 


!!! warn "Don't forget the simplex stem!"

    Note that the lexeme URN for the simplex verb *must* refer to a verb you have cataloged in the `verbs-simplex` directory. 


Here is a CEX file recording ἐγκελεύω.


```
StemUrn|LexemeUrn|Prefix|SimplexUrn|Notes
compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω
```



## Completely regular verb types

Kanones needs only a single stem entry to generate all forms of verbs in the inflectional classes illustrated in these pages:


```@contents
Pages = [
    "regular/omega.md",
    "regular/omega-compound.md",
    "regular/mi.md",
    "regular/ew_contracts.md",
    "regular/aw_contracts.md",
    "regular/ow_contracts.md",
    "regular/izw.md",
    "regular/azw.md",
    "regular/ttw.md"
]
Depth = 5
```




## Completely regular deponents

Kanones defines corresponding inflectional types for regular deponent verbs.  These inflectional classes also require only a single stem entry for Kanones to generate all forms of the verb, and are cataloged in the same way as other regular verbs.

Example:  the verb πραγματεύομαι has the [identifier n86117 in LSJ](http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n86117).  It belongs to the inflectional class `w_regular_dep` ("regular deponent verbs of the -ω conjugation").  We drop -ομαι from the first singluar present middle (or passive) indicative to find the stem value, and could then catalog it as follows:


```
StemUrn|LexemeUrn|Stem|InflectionalClass|
verbstems.n86117|lsj.n86117|πραγματευ|w_regular_dep
```


Similarly, the compound verb προπραγματεύομαι ("to solve or work out ahead of time," used by Claudius Ptolemy) is cataloged like any other regular compound.  Its [identifier in LSJ is n88379](http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n88379), so its complete entry can be:


```
StemUrn|LexemeUrn|Prefix|SimplexUrn|Notes
compounds.n88379|lsj.n88379|προ|lsj.n86117|προπραγματεύομαι
```



```@contents
Pages = [
    "deponents/omega-deponents.md",
    "deponents/mi-deponents.md",
    "deponents/ew_contracts-deponents.md",
    "deponents/aw_contracts-deponents.md",
    "deponents/ow_contracts-deponents.md",
    "deponents/izw-deponents.md",
    "deponents/azw-deponents.md",
    "deponents/ttw-deponents.md",
    
]
Depth = 5
```


## Regular forms for principal parts

Many verbs have principal parts that cannot be predicted from a single stem entry.  Use these inflectional classes to document verbs with more than one stem (one stem entry applicable inflectional class).


### An example: γίγνομαι

We can illustrate this with the common verb γίγνομαι, ([idenitifer n22209 in LSJ](http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n22209)). Kanones' small test data set catalogs it as follows:


```
StemUrn|LexemeUrn|Stem|InflectionalClass|
verbstems.n22209a|lsj.n22209|γιγν|w_pp1_dep|
verbstems.n22209a2|lsj.n22209|γιν|w_pp1_dep|
verbstems.n22209b|lsj.n22209|γενησ|pp2_dep|
verbstems.n22209c|lsj.n22209|γεν|aor2_dep|
verbstems.n22209d|lsj.n22209|γεγον|pp4|
verbstems.n22209e|lsj.n22209|γεγενη|pp5|
verbstems.n22209f|lsj.n22209|γενηθ|pp6|
```

Note that each stem must have a unique `StemUrn`.  (Here, we create these URNs by adding a disambiguating string to the base of the identifer value.)  Note also that it is possible to have multiple stems for the same inflectional class.  A parser built with these stems will recognize both γίνομαι and γίγνομαι as forms for the first singular present middle or passive indicative.


Consult the linked pages for details on the usage of each inflectional class.

```@contents
Pages = [
    "princparts/pp1.md",
    "princparts/pp2.md",
    "princparts/pp3.md",
    "princparts/pp4.md",
    "princparts/pp5.md",
    "princparts/pp6.md",
    "princparts/atticfut.md",
    "princparts/secondaor.md"    
]
Depth = 5
```