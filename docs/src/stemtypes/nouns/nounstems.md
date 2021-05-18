# Noun stems


The automatically generated paradigms on this page illustrate nouns accent belonging to various stem types, and with various patterns of persistent accent.  They belong to the dataset defined in the `datasets/synoptic` directory of the Kanones github repository.

In the tables below, the nouns are labelled with the Kanones stem type they belong to.



## First declension types

Literary Greek orthography:

```@eval
using Kanones, CitableParserBuilder, Markdown

βουλη = LexemeUrn("lsj.n20600")
γνωμη = LexemeUrn("lsj.n22502")
θεραπαινα = LexemeUrn("lsj.n48369")
οικια = LexemeUrn("lsj.n72287")
nouns = [γνωμη, βουλη,οικια,θεραπαινα]

repo = pwd() |> dirname |> dirname  |> dirname |> dirname
ds = dataset(repo * "/datasets/synoptic/")
Markdown.parse(mddeclension(nouns, ds))
```

Attic orthography:


```@eval
using Kanones, CitableParserBuilder, Markdown, AtticGreek
bole = LexemeUrn("lsj.n20600")
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
attic = dataset(repo * "/datasets/attic/"; ortho=atticGreek())
Markdown.parse(mddeclension([bole], attic))
```


## Second declension types

Literary Greek orthography:

```@eval
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
using Kanones, CitableParserBuilder, Markdown
kd = dataset(repo * "/datasets/synoptic/")

ανθρωπος = LexemeUrn("lsj.n8909")
δωρον = LexemeUrn("lsj.n29828")

nouns = [ανθρωπος,δωρον ]
Markdown.parse(mddeclension(nouns, kd))
```


Attic Greek orthography:


```@eval
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
using Kanones, CitableParserBuilder, Markdown, AtticGreek
attic = dataset(repo * "/datasets/attic/"; ortho=atticGreek())

ανθρωπος = LexemeUrn("lsj.n8909")

nouns = [ανθρωπος]
Markdown.parse(mddeclension(nouns, attic))
```




## Third declension types


Literary Greek orthography:

```@eval
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
using Kanones, CitableParserBuilder, Markdown
kd = dataset(repo * "/datasets/synoptic/")

πολις = LexemeUrn("lsj.n84494")

nouns = [πολις]

Markdown.parse(mddeclension(nouns, kd))
```
