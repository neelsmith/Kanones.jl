# The `w_regular` class

## Stem record

```
Rule|LexicalEntity|Stem|StemClass|Augmented
verbstems.n16051|lsj.n16051|ἀρχ|w_regular|
```

```@eval
repo = pwd() |> dirname |> dirname |> dirname 

using Kanones, CitableParserBuilder, Markdown
src1 = joinpath(repo, "datasets", "literarygreek-rules") 
src2 = joinpath(repo, "datasets", "lsj-vocab") 
kds = Kanones.FilesDataset([src1, src2])

αρχω = LexemeUrn("lsj.n16051")
verb_conjugation_md(αρχω, kds) |> Markdown.parse
```