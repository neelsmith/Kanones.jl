# Adjectives using first- and  second-declension endings



## Positive degree only

Stem entries:

```
StemUrn|LexicalEntity|Stem|InflClass|Accent|
adjstems.n52332|lsj.n52332|κακ|os_h_on_pos|inflectionaccented|
```

Paradigms generated from these entries:



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κακος = LexemeUrn("lsj.n52332")


Markdown.parse(md_3endingadj(κακος, gmpDegree("positive"), kds))
```
