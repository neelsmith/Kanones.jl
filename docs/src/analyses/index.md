# Work with morphological analyses


- Kanones.jl offers functions for working with analyses.
- Kanones.jl supports converting the output of an SFST  parser built with Kanones.jl to an object model.  


## Examples

```@setup  analysisexample
repo = pwd() |> dirname |> dirname  |> dirname
target = tempdir() * "/usinganalyses/"
```
Build a parser:

```@example  analysisexample
using Kanones, Kanones.FstBuilder
kd = dataset(repo * "/datasets/synoptic/")
fstsrc = repo * "/fst/"
parser = buildparser(kd, fstsrc, target)
```


```@example  analysisexample

string("Using parser from ", parser)
```