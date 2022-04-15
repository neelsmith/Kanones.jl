# Work with morphological analyses


- `Kanones` supports converting the output of an SFST  parser built with `Kanones` to an object model. 
- `Kanones` offers functions for working with analyses.
 


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

Each analysis has a modified form of the token, plus four objects with special types of Cite2URNs. The modified form removes all accents, and explicitly marks morpheme boundaries in verb forms (using the `#` character).

```@example analysisexample  
a1 = analyses[1]
a1.token
```

The two most important URNs are the *lexeme* and the *form*.

```@example analysisexample
a1.lexeme
```

You can convert this to a `GreekLexeme`, and use it together with a dictionary of Liddell-Short-Jones lemmata for more readable labelling.  (The `Kanones.jl` github repository includes a dictionary of LSJ lemmata in the `lsj` directory, as illustrated in this example.)

```@example analysisexample
lsjfile = joinpath(reporoot, "lsj", "lsj-lemmata.cex")
lsj = Kanones.lsjdict(lsjfile)

greeklex = GreekLexeme(a1.lexeme)
label(greeklex, lexicon  = lsj)
```


Use the `greekForm` function to create a rich object model of the morphological form (a subtype of `GreekMorphologicalForm`).


```@example analysisexample
a1.form
```

```@example analysisexample
mform = greekForm(a1.form)
label(mform)
```
 


### Working with analyses




We can check the type of form, and get appropriate information for that type.

```@example analysisexample
tensedata = if isa(mform, GMFFiniteVerb)
        (mform.vtense)
else
        nothing
end
tensedata
```
```@example analysisexample
analyses2 = parsetoken("δωρα", parser)
a2 = analyses2[1]
form2 = greekForm(a2.form)
genderdata = if isa(form2, GMFNoun)
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
