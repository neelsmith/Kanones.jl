# Regular verbs:  -εω contracts


Inflection class: `ew_contract`

Example verb:  ποιέω

```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n84234|lsj.n84234|ποι|ew_contract|
```

Paradigms generated from these entries:

## Present system

### Present tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("active"), ποιεω, kds))
```

*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("passive"), ποιεω, kds))
```

### Imperative

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), ποιεω, kds)
Markdown.parse(tbl)
```


*Middle and passive voices* (identical forms):


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), ποιεω, kds)
Markdown.parse(tbl)
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")
vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
)
vadjforms = generate(ποιεω, formurn(vadj), kds)

inf_act = GMFInfinitive(
    gmpTense("present"), gmpVoice("active")
)
inf_actforms = generate(ποιεω, formurn(inf_act), kds)

inf_pass = GMFInfinitive(
    gmpTense("present"), gmpVoice("passive")
)
inf_passforms = generate(ποιεω, formurn(inf_pass), kds)

actptcpl = participleslashline(ποιεω, gmpTense("present"), gmpVoice("active"), kds)

mpptcpl = participleslashline(ποιεω, gmpTense("present"), gmpVoice("middle"), kds)

mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle & passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle & passive participle**: $(mpptcpl)",
    "- **verbal adjective**: $(vadjforms[1])"]
Markdown.parse(join(mdlines,"\n"))
```

### Imperfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("active"), ποιεω, kds))
```


*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), ποιεω, kds))
```



## Future tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("active"), ποιεω, kds))
```

*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("middle"),ποιεω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("passive"),ποιεω, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")



inf_act = GMFInfinitive(
    gmpTense("future"), gmpVoice("active")
)
inf_actforms = generate(ποιεω, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("future"), gmpVoice("middle")
)
inf_mdlforms = generate(ποιεω, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("future"), gmpVoice("passive")
)
inf_passforms = generate(ποιεω, formurn(inf_pass), kds)


actptcpl = participleslashline(ποιεω, gmpTense("future"), gmpVoice("active"), kds)

midptcpl = participleslashline(ποιεω, gmpTense("future"), gmpVoice("middle"), kds)

passptcpl = participleslashline(ποιεω, gmpTense("future"), gmpVoice("passive"), kds)

mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
]
Markdown.parse(join(mdlines,"\n"))
```




## Aorist tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("active"), ποιεω, kds))
```


*Middle voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("middle"), ποιεω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("passive"), ποιεω, kds))
```




### Imperative 

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), ποιεω, kds)
Markdown.parse(tbl)
```


*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), ποιεω, kds)
Markdown.parse(tbl)
```



*Passive voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), ποιεω, kds)
Markdown.parse(tbl)
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")



inf_act = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("active")
)
inf_actforms = generate(ποιεω, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("middle")
)
inf_mdlforms = generate(ποιεω, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("passive")
)
inf_passforms = generate(ποιεω, formurn(inf_pass), kds)



actptcpl = participleslashline(ποιεω, gmpTense("aorist"), gmpVoice("active"), kds)

midptcpl = participleslashline(ποιεω, gmpTense("aorist"), gmpVoice("middle"), kds)

passptcpl = participleslashline(ποιεω, gmpTense("aorist"), gmpVoice("passive"), kds)


mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle infinitive**: $(inf_mdlforms[1])",
    "- **passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle participle**: $(midptcpl)",
    "- **passive participle**: $(passptcpl)"
]

Markdown.parse(join(mdlines,"\n"))

```




## Perfect system

### Perfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("active"), ποιεω, kds))
```




*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("passive"), ποιεω, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")

actptcpl = participleslashline(ποιεω, gmpTense("perfect"), gmpVoice("active"), kds)

mpptcpl = participleslashline(ποιεω, gmpTense("perfect"), gmpVoice("middle"), kds)


inf_act = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("active")
)
inf_actforms = generate(ποιεω, formurn(inf_act), kds)

mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **active participle**: $(actptcpl)",
    "- **middle & passive participle**: $(mpptcpl)"
]
Markdown.parse(join(mdlines,"\n"))
```

### Pluperfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), ποιεω, kds))
```



*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
ποιεω = LexemeUrn("lsj.n84234")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), ποιεω, kds))
```