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
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("active"), κελευω, kds))
```

*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("present"), gmpVoice("passive"), κελευω, kds))
```

- **present infinitives**: TBA
- **present participles**: TBA
- **present imperative**: TBA

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")
nom_sg = GMFVerbalAdjective(
    gmpGender("neuter"), gmpCase("nominative"), gmpNumber(1)
)
result = generate(κελευω, formurn(nom_sg), kds)
Markdown.parse("- **verbal adjective**: $(result[1])")
```

### Imperfect tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("active"), κελευω, kds))
```


*Middle and passive voices* (identical forms):

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("imperfect"), gmpVoice("passive"), κελευω, kds))
```

## Future tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("active"), κελευω, kds))
```

*Middle voice*:


```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("middle"),κελευω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("future"), gmpVoice("passive"),κελευω, kds))
```


- **future infinitives**: TBA
- **future participles**: TBA

## Aorist tense

*Active voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("active"), κελευω, kds))
```


*Middle voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("middle"), κελευω, kds))
```


*Passive voice*:

```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_conjugation(gmpTense("aorist"), gmpVoice("passive"), κελευω, kds))
```


- **aorist infinitives**: TBA
- **aorist participles**: TBA
- **aorist imperative**: TBA


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

- **perfect infinitives**: TBA
- **perfect participles**: TBA
- **perfect imperative**: TBA


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