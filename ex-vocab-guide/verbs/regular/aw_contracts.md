# Regular verbs:  -αω contracts

Inflection class: `aw_contract`

Example verb:  τιμάω


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n103972|lsj.n103972|τιμ|aw_contract|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

τιμαω = LexemeUrn("lsj.n103972")

Markdown.parse(md_proofconjugation(τιμαω, kds))
```