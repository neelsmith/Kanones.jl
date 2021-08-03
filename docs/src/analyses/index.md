# Work with morphological analyses


- Kanones.jl offers functions for working with analyses.
- Kanones.jl supports converting the output of an SFST  parser built with Kanones.jl to an object model.  


## An example


### Parse a token

```@setup analysisexample  
repo = pwd() |> dirname |> dirname  |> dirname
```


```@example analysisexample
parser = repo * "/parsers/demo/greek.a"
```
Build a parser, as we did in the example on the previous page.

```@example analysisexample
basename(parser)
```

Parsing a token returns a (possibly empty) Vector of analyses.

```@example analysisexample
using Kanones
parser = repo * "/parsers/demo/greek.a"
analyses = parsetoken(parser, "κελεύσει")
```



### Analyses

Each analysis has a form of the token stripped of accents, plus four objects with special types of Cite2URNs

```@example analysisexample  
a1 = analyses[1]
a1.token
```

The two most important URNs are the *lexeme* and the *form*.

```@example analysisexample
a1.lexeme
```

```@example analysisexample
a1.form
```

Test what kind of form it is.

Then get appropriate information for that type of form.

```@example analysisexample
using CitableParserBuilder
registry = Dict(
        "morphforms" => "urn:cite2:kanones:morphforms.v1:"
)
expanded = expand(a1.form, registry)
```

Label it like this

```@example analysisexample
Kanones.labelform(a1.form.objectid)
```