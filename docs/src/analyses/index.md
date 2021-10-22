# Work with morphological analyses


- Kanones.jl offers functions for working with analyses.
- Kanones.jl supports converting the output of an SFST  parser built with Kanones.jl to an object model.  


## An example


### Parse a token

```@setup analysisexample 
using Kanones
using Kanones.FstBuilder
using CitableParserBuilder
reporoot = pwd() |> dirname |> dirname |> dirname
target = reporoot * "/parsers/demo/"
datadirectory = reporoot * "/datasets/core-infl/"
kd = dataset([datadirectory])
fstsrc = reporoot *  "/fst/"
parser = buildparser(kd, fstsrc, target)
```

Build a parser, as we did in the example on the previous page.

```@example analysisexample
basename(parser.sfstpath)
```

Parsing a token returns a (possibly empty) Vector of analyses.

```@example analysisexample
analyses = parsetoken("κελεύσει", parser)
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

You can use the `labelform` function to get a human-readable label for a form.


```@example analysisexample
Kanones.labelform(a1.form.objectid)
```

### Working with analyses

Get a morphform for the analysis.  You can give `morphform` just about anything you can think of (`Cite2Urn`, `FormUrn`, string, for example).  Here, we'll just get it directly from the `Analysis`.



```@example analysisexample
mform = Kanones.morphform(a1)
```


We can check the type of form, and get appropriate information for that type.

```@example analysisexample
tensedata = if isa(mform, FiniteVerbForm)
        (mform.vtense)
else
        nothing
end
tensedata
```
```@example analysisexample
analyses2 = parsetoken("δωρα", parser)
a2 = analyses2[1]
form2 = Kanones.morphform(a2)
genderdata = if isa(form2, NounForm)
        (form2.ngender)
else
        nothing
end
genderdata
```

### URNs

`FormUrn`s and `LexemeUrn`s are both subtypes of the `CitableParserBuilder`'s `AbbreviatedUrn` type.
You can expand any `AbbreviatedUrn` using a diction mapping collection abbreviations to full `Cite2Urn`s for the collection.

```@example analysisexample
using CitableParserBuilder
registry = Dict(
        "morphforms" => "urn:cite2:kanones:morphforms.v1:"
)
expanded = expand(a1.form, registry)
```


 