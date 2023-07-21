```@setup transcode
repo = repo = pwd() |> dirname |> dirname |> dirname
```
# Kanones' analyses

`Kanones.jl` implements the model of the `CitableParserBuilder` module.  Parsing functions (like `parsetoken`) return a Vector of `Analysis` objects.  In addition to a lexeme and a form, each `Analysis` also includes a *stem* and an inflectional *rule*. Conceptually, the stem and rule provide the rationale for an analysis: the stem explains why a specific lexeme was chosen, and the inflectional rule explains how the token was formed by applying a particular inflectional pattern to the stem.  When generating tokens, pairing a stem and a rule provides enough information to identify a lexeme and a form and to compose a token.  Kanones can actually produce a full `Analysis` object when *generating* tokens as well as when parsing them. 

Kanones further associates an implementation of an `Orthography` with each parser. You can use Kanones to build parsers that are tailored not only to specific features of language (vocabulary or inflectional patterns specific to a particular corpus or dialect), but also to specific orthographic systems and the phonology they represent. The Kanones github repository, for example, includes stems and rules in two completely different orthographies: the standard orthography of printed literary Greek, and the orthography of inscriptions of Athens prior to 403 BCE. 

In Kanones, each of the four components of an `Analysis` are `Cite2Urn` values. The identifiers for lexemes and morphological forms are potentially applicable to any parser you build with Kanones; stems and rules for the same lexeme and form may differ if you are parsing texts using different orthographies. The fact that you can meaningfully use references to lexems and forms drawn from parsers in different orthographies means that you can even analyze a token in one orthography, and generate the corresponding token for the same lexeme and form in another orthography.

### Example: transcoding content

First, we build a parser with the conventional orthography of modern printed editions of literary texts.

```@example transcode
using Kanones, CitableParserBuilder
using PolytonicGreek
lgfiles = joinpath(repo, "datasets", "literarygreek-rules")
lg = dataset(lgfiles)
lgparser = stringParser(lg)
```

Next, we build a parser with an orthography for the Attic alphabet used before 403 BCE.

```@example transcode
using AtticGreek
atticfiles = joinpath(repo,"datasets","attic")
attic = dataset(atticfiles)
atticparser = stringParser(attic)
```

Now we can analyze a token written in standard orthography.
```@example transcode
analysis = parsetoken("βουλῆς",lgparser)[1]
```

Kanones has `lexeme` and `formurn` functions to retrieve those elements of an analysis.  With those in hand, we can now generate
the corresponding token using the parser for Attic orthography.

```
vocab = lexeme(analysis)
form = formurn(analysis)
generate(vocab,form,attic)
```

