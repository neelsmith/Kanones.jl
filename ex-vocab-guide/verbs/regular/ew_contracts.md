# Regular verbs:  -εω contracts


Inflection class: `ew_contract`

Example verb:  ποιέω


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n84234|lsj.n84234|ποι|ew_contract|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

ποιεω = LexemeUrn("lsj.n84234")

Markdown.parse(md_proofconjugation(ποιεω, kds))
```