# Regular verbs:  -οω contracts


Inflection class: `ow_contract`

Example verb:  δηλόω


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n24342|lsj.n24342|δηλ|ow_contract|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

δηλοω = LexemeUrn("lsj.n24342")

Markdown.parse(md_proofconjugation(δηλοω, kds))
```