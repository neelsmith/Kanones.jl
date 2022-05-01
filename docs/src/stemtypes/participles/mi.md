# Participles of regular  -μι verbs

Participles of regular -ω and regular -μι verbs differ only in the present tense.



Inflectional class: `numi`



## Present tense

*Active voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_ptcpldeclension(δεικνυμι, gmpTense("present"), gmpVoice("active"), kds))
```


*Middle & passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_ptcpldeclension(δεικνυμι, gmpTense("present"), gmpVoice("middle"), kds))
```


