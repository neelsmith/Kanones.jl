# Regular verbs in -ιζω 


Inflection class: `izw`

Example verb:  νομίζω


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n70958|lsj.n70958|νομι|izw|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

νομιζω = LexemeUrn("lsj.n70958")

Markdown.parse(md_proofconjugation(νομιζω, kds))
```
