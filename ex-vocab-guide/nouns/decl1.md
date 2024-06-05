# First-declension nouns


## Feminine in  -η

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n20600|lsj.n20600|βουλ|feminine|h_hs|inflectionaccented|
nounstems.n22502|lsj.n22502|γνωμ|feminine|h_hs|recessive|
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
βουλη = LexemeUrn("lsj.n20600")


Markdown.parse(md_declension(βουλη, kds))
```

## Feminine in -α

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n48369|lsj.n48369|θεραπαιν|feminine|a_as_short|recessive|
nounstems.n72287|lsj.n72287|οἰκι|feminine|a_as|stemaccented|
```


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
οικια = LexemeUrn("lsj.n72287")


Markdown.parse(md_declension(οικια, kds))
```

## Masculne in -ης, -ου


```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n84511|lsj.n84511|πολιτ|masculine|hs_ou|stemaccented|
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo,  "Kanones.jl", "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
πολιτης = LexemeUrn("lsj.n84511")


Markdown.parse(md_declension(πολιτης, kds))
```