
## Perfect system

### Perfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("active"), κελευω, kds))
```




*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("perfect"), gmpVoice("passive"), κελευω, kds))
```


- **perfect imperative**: TBA


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")
vadj = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
)
vadjforms = generate(κελευω, formurn(vadj), kds)

inf_act = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("active")
)
inf_actforms = generate(κελευω, formurn(inf_act), kds)

inf_pass = GMFInfinitive(
    gmpTense("perfect"), gmpVoice("passive")
)
inf_passforms = generate(κελευω, formurn(inf_pass), kds)
mdlines = [
    "- **active infinitive**: $(inf_actforms[1])",
    "- **middle & passive infinitive**: $(inf_passforms[1])",
    "- **active participle**: TBA",
    "- **middle & passive participle**: TBA"
Markdown.parse(join(mdlines,"\n"))
```

### Pluperfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("active"), κελευω, kds))
```



*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("pluperfect"), gmpVoice("passive"), κελευω, kds))
```