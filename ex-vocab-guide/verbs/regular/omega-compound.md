# Regular -ω verb: compound verb


```
Stem|LexicalEntity|Prefix|Simplex|Note
compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω
```

The following paradigms are generated from this entry.


```@eval
using Kanones, CitableParserBuilder, Markdown
repoparent = pwd() |> dirname |> dirname |> dirname |> dirname |> dirname

kds = joinpath(repoparent, "Kanones.jl", "datasets", "literarygreek-rules") |> dataset

εν_κελευω = LexemeUrn("lsj.n30252")

Markdown.parse(md_proofconjugation(εν_κελευω, kds))
```