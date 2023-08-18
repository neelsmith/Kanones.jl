# The `w_regular_dep` class:  πραγματεύω


## Stem record

```
Rule|LexicalEntity|Stem|StemClass|Augmented
verbstems.n86117|lsj.n86117|πραγματευ|w_regular_dep|
```

```@eval
repo = pwd() |> dirname |> dirname |> dirname 

using Kanones, CitableParserBuilder, Markdown
src1 = joinpath(repo, "datasets", "literarygreek-rules") 
src2 = joinpath(repo, "datasets", "lsj-vocab") 
kds = Kanones.FilesDataset([src1, src2])

πραγματευω = LexemeUrn("lsj.n86117")
verb_conjugation_md(πραγματευω, kds) |> Markdown.parse
```

