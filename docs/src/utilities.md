# Utilities

```@setup utils
repo = pwd() |> dirname |> dirname
```


## Set up

Start by loading a Kanones dataset.  We'll use the `literarygreek-rules` data in the `datasets` subdirectory of the Kanones github repository.

```@example utils
using Kanones
sourcedata = joinpath(repo, "datasets", "literarygreek-rules")
kdata = dataset([sourcedata])
kdata isa Kanones.FilesDataset
```

## Decline a noun

Decline a noun that you have identified with its `LexemeUrn`.

```@example utils
using CitableParserBuilder
ανθρωπος = LexemeUrn("lsj.n8909")
decline(ανθρωπος, kdata)
```

## Proofread a complete verb conjugation in markdown

1. Compose a complete conjugation of the verb `lex` with rules in the Kanones dataset `kds`,  formatted in markdown:  `md_proofconjugation(lex,kds)`
2. Identical markdown conjugation of `lex`, but write it to file `f` in one step: `mdfile_proofconjugation(lex,kds,f)`

Here is the output of `md_proofconjugation` using `LexemeUrn("lsj.n56496")` (κελεύω) as the lexeme, with the Kanones dataset in `literarygreek-rules`


> *Content below here generated automatically from* 
>
> `srcdir = joinpath(repo, "datasets", "literarygreek-rules")`
> `kds = Kanones.FilesDataset([srcdir])`
> `κελευω = LexemeUrn("lsj.n56496")`
> `md_proofconjugation(κελευω,kds)`



```@eval
using Kanones, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = Kanones.FilesDataset([srcdir])
κελευω = LexemeUrn("lsj.n56496")


Markdown.parse(md_proofconjugation(κελευω,kds))

```