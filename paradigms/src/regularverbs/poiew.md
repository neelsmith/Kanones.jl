# An epsilon contract verb of the `ew_contract` class:  ποιέω


## Stem record

```
Rule|LexicalEntity|Stem|StemClass|Augmented
verbstems.n84234|lsj.n84234|ποι|ew_contract|
```



```@eval
repo = pwd() |> dirname |> dirname |> dirname 

using Kanones, CitableParserBuilder, Markdown
src1 = joinpath(repo, "datasets", "literarygreek-rules") 
src2 = joinpath(repo, "datasets", "lsj-vocab") 
kds = Kanones.FilesDataset([src1, src2])

ποιεω  = LexemeUrn("lsj.n84234")
verb_conjugation_md(ποιεω, kds) |> Markdown.parse
```
