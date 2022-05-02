# Regular -μι verbs

Inflectional class: `numi`

Example verb:  δείκνυμι

```
Rule|LexicalEntity|StemClass|Stem|
verbstems.n23658|lsj.n23658|δεικ|numi|
```



Paradigms generated from these entries:

## Present system

### Present tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("active"), δεικνυμι, kds))
```

*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("passive"), δεικνυμι, kds))
```

### Imperative

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("active"), δεικνυμι, kds)
Markdown.parse(tbl)
```


*Middle and passive voices* (identical forms):


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

tbl = md_imperativeconjugation(gmpTense("present"), gmpVoice("passive"), δεικνυμι, kds)
Markdown.parse(tbl)
```

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")
vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
)
vadjforms = generate(δεικνυμι, formurn(vadj), kds)

inf_act = GMFInfinitive(
    gmpTense("present"), gmpVoice("active")
)
inf_actforms = generate(δεικνυμι, formurn(inf_act), kds)

inf_pass = GMFInfinitive(
    gmpTense("present"), gmpVoice("passive")
)
inf_passforms = generate(δεικνυμι, formurn(inf_pass), kds)

actptcpl = participleslashline(δεικνυμι, gmpTense("present"), gmpVoice("active"), kds)

mpptcpl = participleslashline(δεικνυμι, gmpTense("present"), gmpVoice("middle"), kds)

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
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("active"), δεικνυμι, kds))
```


*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), δεικνυμι, kds))
```



## Future tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("active"), δεικνυμι, kds))
```

*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("middle"),δεικνυμι, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("passive"),δεικνυμι, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")



inf_act = GMFInfinitive(
    gmpTense("future"), gmpVoice("active")
)
inf_actforms = generate(δεικνυμι, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("future"), gmpVoice("middle")
)
inf_mdlforms = generate(δεικνυμι, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("future"), gmpVoice("passive")
)
inf_passforms = generate(δεικνυμι, formurn(inf_pass), kds)


actptcpl = participleslashline(δεικνυμι, gmpTense("future"), gmpVoice("active"), kds)

midptcpl = participleslashline(δεικνυμι, gmpTense("future"), gmpVoice("middle"), kds)

passptcpl = participleslashline(δεικνυμι, gmpTense("future"), gmpVoice("passive"), kds)

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
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("active"), δεικνυμι, kds))
```


*Middle voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("middle"), δεικνυμι, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("passive"), δεικνυμι, kds))
```




### Imperative 

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("active"), δεικνυμι, kds)
Markdown.parse(tbl)
```


*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("middle"), δεικνυμι, kds)
Markdown.parse(tbl)
```



*Passive voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

tbl = md_imperativeconjugation(gmpTense("aorist"), gmpVoice("passive"), δεικνυμι, kds)
Markdown.parse(tbl)
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")



inf_act = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("active")
)
inf_actforms = generate(δεικνυμι, formurn(inf_act), kds)


inf_mdl = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("middle")
)
inf_mdlforms = generate(δεικνυμι, formurn(inf_mdl), kds)


inf_pass = GMFInfinitive(
    gmpTense("aorist"), gmpVoice("passive")
)
inf_passforms = generate(δεικνυμι, formurn(inf_pass), kds)



actptcpl = participleslashline(δεικνυμι, gmpTense("aorist"), gmpVoice("active"), kds)

midptcpl = participleslashline(δεικνυμι, gmpTense("aorist"), gmpVoice("middle"), kds)

passptcpl = participleslashline(δεικνυμι, gmpTense("aorist"), gmpVoice("passive"), kds)


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
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("active"), δεικνυμι, kds))
```




*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("passive"), δεικνυμι, kds))
```



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")

actptcpl = participleslashline(δεικνυμι, gmpTense("perfect"), gmpVoice("active"), kds)

mpptcpl = participleslashline(δεικνυμι, gmpTense("perfect"), gmpVoice("middle"), kds)


inf_act = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("active")
)
inf_actforms = generate(δεικνυμι, formurn(inf_act), kds)

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
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), δεικνυμι, kds))
```



*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.dataset([srcdir])
δεικνυμι = LexemeUrn("lsj.n23658")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), δεικνυμι, kds))
```
