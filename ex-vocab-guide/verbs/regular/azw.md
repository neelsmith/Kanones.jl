# Regular verbs in -άζω 


Inflection class: `azw`

Example verb:  ἀγοράζω

```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n762|lsj.n762|ἀγορα|azw|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

αγοραζω = LexemeUrn("lsj.n762")

Markdown.parse(md_proofconjugation(αγοραζω, kds))
```
