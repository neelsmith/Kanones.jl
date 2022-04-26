# Second-declension nouns


Stem entries:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|
nounstems.n29828|lsj.n29828|δωρ|neuter|os_ou|recessive|
nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|
```

Paradigms generated from these entries:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
ανθρωπος = LexemeUrn("lsj.n8909")


Markdown.parse(mddeclension(ανθρωπος, kds))
```


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
δωρον = LexemeUrn("lsj.n29828")


Markdown.parse(mddeclension(δωρον, kds))
```
