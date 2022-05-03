```@setup transcode
repo = repo = pwd() |> dirname |> dirname |> dirname
```
# Kanones' analyses

Kanones implements the model of the `CitableParserBuilder` module.  Parsing functions (like `parsetoken`) return a Vector of `Analysis` objects.  In addition to a lexeme and a form, each `Analysis` also includes a *stem* and an inflectional *rule*. Conceptually, the stem and rule provide the rationale for an analysis: the stem explains why a specific lexeme was chosen, and the inflectional rule explains how the token was formed by applying a particular inflectional pattern to the stem.  When generating tokens, pairing a stem and a rule provides enough information to identify a lexeme and a form and to compose a token.  Kanones can actually produce a full `Analysis` object when *generating* tokens!

This model makes it possible to use the same set of lexemes and the same set of morphological forms with *different* sets of stems and rules.  The Kanones github repository, for example, includes stems and rules in two completely different orthographies: the standard orthography of printed literary Greek, and the orthography of inscriptions of Athens prior to 403 BCE.  Whichever dataset you use, the lexemes and forms are identified with the same URNs, so you can meaningfully mix analyses of tokens in different orthographies. You can even use Kanones' capacity for generating forms to analyze a token in one orthography, and generate the corresponding token for the same lexeme and form in another token.

### Example: transcoding content

```@example transcode
using Kanones, CitableParserBuilder
using PolytonicGreek, AtticGreek
lgfiles = joinpath(repo, "datasets", "literarygreek-rules")
lg = dataset(lgfiles)
lgparser = stringParser(lg)
```

```@example transcode
atticfiles = joinpath(repo,"datasets","attic")
attic = dataset(atticfiles)
atticparser = stringParser(attic)
```

```@example transcode
analysis = parsetoken("βουλῆς",lgparser)[1]
```

## Kanones' collections

- four components:
    1. lexeme
    2. form
    3. stem
    4. rule
- all elements other than string tokens identified by URN
