# Second-declension nouns




## Masculine

Stem entries:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ανθρωπος = LexemeUrn("lsj.n8909")


Markdown.parse(md_declension(ανθρωπος, kds))
```



## Neuter

Stem entries:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n29828|lsj.n29828|δωρ|neuter|os_ou|recessive|
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
δωρον = LexemeUrn("lsj.n29828")


Markdown.parse(md_declension(δωρον, kds))
```
