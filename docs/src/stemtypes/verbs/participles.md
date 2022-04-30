# Participles



Stem entries:

-ω regular

```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n56496|lsj.n56496|κελευ|w_regular|
```

Paradigms generated from these entries:


## Present tense


*Middle & passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_ptcpldeclension(κελευω, gmpTense("present"), gmpVoice("middle"), kds))
```
