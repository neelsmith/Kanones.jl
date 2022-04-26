# Utilities

```@setup utils
repo = pwd() |> dirname |> dirname
```


## Set up

Start by loading a Kanones dataset.  We'll use the `lg-core` data in the `datasets` subdirectory of the Kanones github repository.

```@example utils
using Kanones
sourcedata = joinpath(repo, "datasets", "lg-core")
kdata = dataset([sourcedata])
kdata isa Kanones.Dataset
```

## Decline a noun

Decline a noun that you have identified with its `LexemeUrn`.

```@example utils
using CitableParserBuilder
ανθρωπος = LexemeUrn("lsj.n8909")
decline(ανθρωπος, kdata)
```

