# Regular -μι verbs

Inflectional class: `numi`

Example verb:  δείκνυμι

```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n23658|lsj.n23658|δεικ|numi|
```




```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

δεικνυμι = LexemeUrn("lsj.n23658")

Markdown.parse(md_proofconjugation(δεικνυμι, kds))
```

