# Compiling and parsing

Build a parser with the `buildparser` function.


See [Managing Kanones datasets](@ref)


```@setup parserexample
repo = pwd() |> dirname |> dirname  |> dirname
target = tempdir() * "/demoparser2/"
if isdir(target)
    rm(target, force=true, recursive=true)
    mkdir(target)
else 
    mkdir(target)
end
```

```@example parserexample
using Kanones, Kanones.FstBuilder

core_inflection = joinpath(repo, "datasets", "core-infl")
core_vocab = joinpath(repo, "datasets", "core-vocab")
kd = dataset([core_inflection, core_vocab])

fstsrc = joinpath(repo, "fst")
parser = buildparser(kd, fstsrc, target)
basename(parser.sfstpath)
```
