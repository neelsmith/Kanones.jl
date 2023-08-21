# A pure vowel verb of `w_regular` class:  κινδυνεύω


## Stem record

```
Rule|LexicalEntity|Stem|StemClass|Augmented
verbstems.n57456|lsj.n57456|κινδυνευ|w_regular|
```

```@eval
repo = pwd() |> dirname |> dirname |> dirname 

using Kanones, CitableParserBuilder, Markdown
src1 = joinpath(repo, "datasets", "literarygreek-rules") 
src2 = joinpath(repo, "datasets", "lsj-vocab") 
kds = Kanones.FilesDataset([src1, src2])

κινδυνευω = LexemeUrn("lsj.n57456")
verb_conjugation_md(κινδυνευω, kds) |> Markdown.parse
```