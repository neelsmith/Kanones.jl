# Regular -ω verbs


```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n56496|lsj.n56496|κελευ|w_regular|
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
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("active"), κελευω, kds))
```

*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("passive"), κελευω, kds))
```

### Imperative

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), κελευω, kds)
Markdown.parse(tbl)
```


*Middle and passive voices* (identical forms):


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), κελευω, kds)
Markdown.parse(tbl)
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")
vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
)
vadjforms = generate(κελευω, formurn(vadj), kds)

inf_act = GMFInfinitive(
    gmpTense("present"), gmpVoice("active")
)
inf_actforms = generate(κελευω, formurn(inf_act), kds)

inf_pass = GMFInfinitive(
    gmpTense("present"), gmpVoice("passive")
)
inf_passforms = generate(κελευω, formurn(inf_pass), kds)

actptcpl = participleslashline(κελευω, gmpTense("present"), gmpVoice("active"), kds)

mpptcpl = participleslashline(κελευω, gmpTense("present"), gmpVoice("middle"), kds)

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
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("active"), κελευω, kds))
```


*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), κελευω, kds))
```



## Future tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("active"), κελευω, kds))
```

*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("middle"),κελευω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("passive"),κελευω, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")



inf_act = GMFInfinitive(
    gmpTense("future"), gmpVoice("active")
)
inf_actforms = generate(κελευω, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("future"), gmpVoice("middle")
)
inf_mdlforms = generate(κελευω, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("future"), gmpVoice("passive")
)
inf_passforms = generate(κελευω, formurn(inf_pass), kds)


actptcpl = participleslashline(κελευω, gmpTense("future"), gmpVoice("active"), kds)

midptcpl = participleslashline(κελευω, gmpTense("future"), gmpVoice("middle"), kds)

passptcpl = participleslashline(κελευω, gmpTense("future"), gmpVoice("passive"), kds)

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
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("active"), κελευω, kds))
```


*Middle voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("middle"), κελευω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("passive"), κελευω, kds))
```




### Imperative 

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), κελευω, kds)
Markdown.parse(tbl)
```


*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), κελευω, kds)
Markdown.parse(tbl)
```



*Passive voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), κελευω, kds)
Markdown.parse(tbl)
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")



inf_act = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("active")
)
inf_actforms = generate(κελευω, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("middle")
)
inf_mdlforms = generate(κελευω, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("passive")
)
inf_passforms = generate(κελευω, formurn(inf_pass), kds)



actptcpl = participleslashline(κελευω, gmpTense("aorist"), gmpVoice("active"), kds)

midptcpl = participleslashline(κελευω, gmpTense("aorist"), gmpVoice("middle"), kds)

passptcpl = participleslashline(κελευω, gmpTense("aorist"), gmpVoice("passive"), kds)


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
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("active"), κελευω, kds))
```




*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("passive"), κελευω, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")

actptcpl = participleslashline(κελευω, gmpTense("perfect"), gmpVoice("active"), kds)

mpptcpl = participleslashline(κελευω, gmpTense("perfect"), gmpVoice("middle"), kds)


inf_act = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("active")
)
inf_actforms = generate(κελευω, formurn(inf_act), kds)

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
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), κελευω, kds))
```



*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), κελευω, kds))
```