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
kd = dataset(repo * "/datasets/synoptic/")
fstsrc = repo * "/fst/"
parser = buildparser(kd, fstsrc, target)
basename(parser)
```
