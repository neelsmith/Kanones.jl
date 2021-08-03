# Work with morphological analyses


- Kanones.jl offers functions for working with analyses.
- Kanones.jl supports converting the output of an SFST  parser built with Kanones.jl to an object model.  


## Examples



```@setup  analysisexample
repo = pwd() |> dirname |> dirname  |> dirname
target = tempdir() * "/usinganalyses"
using Kanones, Kanones.FstBuilder
kd = dataset(repo * "/datasets/synoptic/")
fstsrc = repo * "/fst/"
parser = buildparser(kd, fstsrc, target)
```
Build a parser, as we did in the example on the previous page.

```@example
basename(parser)
```


Parsing a token returns a (possibly empty) Vector of analyses.


```@example  analysisexample
analyses = parsetoken(parser, "κελεύσει")
```


Each analysis has a form of the token stripped of accents, plus four objects with special types of Cite2URNs

```@example  analysisexample
a1 = analyses[1]
a1.token
```

The two most important URNs are the *lexeme* and the *form*.


```@example  analysisexample
a1.lexeme
```


```@example  analysisexample
a1.lexeme
```