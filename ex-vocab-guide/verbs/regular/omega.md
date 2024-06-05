# Regular -ω verb: simplex form


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n56496|lsj.n56496|κελευ|w_regular|
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

κελευω = LexemeUrn("lsj.n56496")

Markdown.parse(md_proofconjugation(κελευω, kds))
```

