# Third-declension nouns

## Vowel stems

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n41858|lsj.n41858|ἐπ|neuter|os_ous|recessive|
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
επος = LexemeUrn("lsj.n41858")


Markdown.parse(md_declension(επος, kds))
```
