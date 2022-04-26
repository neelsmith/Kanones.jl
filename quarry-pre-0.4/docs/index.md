# Kanones.jl

> ☛ *Build corpus-specific parsers for ancient Greek texts in a specified orthography*.

Kanones.jl lets you build morphological parsers for ancient Greek.  It works with three central concepts: 

1. An explicitly defined **orthography**.
2. A morphological **dataset** (stems and inflectional rules) managed in plain-text tables.
3. **Analyses** recorded with URNs identifying lexemes, forms and the entries in the dataset leading the analysis.


Because Kanones.jl cleanly separates orthography and morphology, you can compile parsers for standard literary Greek, epichoric Greek alphabets, or Greek with manuscript symbols, for example.  Because it manages stems and inflectional rules in plain-text tables, an editor or Greek student can easily tailor a parser to a specific corpus by adding or deleting entries.  Because analyses are expressed with URNs, Kanones.jl's analytical tools can profile a corpus, and even compare lexical and morphological features across corpora in different orthographies. 


## More backgound

Read more about the rationale and approach to parsing a historical language in "Morphological Analysis of Historical Languages" (*Bulletin of the Institute for Classical Studies* 59-2, 2016, 89-102).


## Shortest possible example

Behind the scenes, Kanones builds a finite state transducer using the [Stuttgart Finite State Transducer](https://github.com/santhoshtr/sfst) (see more details about [prerequisites](https://neelsmith.github.io/Kanones.jl/stable/prereqs/)). The Julia package provides support for validating your source data, compiling and querying the transducer, and analyzing the results of parsing.



!!! note
    The example builds a parser using a sample dataset included in the Kanones.jl git repository.  The following pages of the user's manual explain the organization of Kanones datasets more fully.





```@setup eg
using Kanones
using Kanones.FstBuilder
using CitableParserBuilder
reporoot = pwd() |> dirname |> dirname
target = reporoot * "/parsers/demo/"
```

### Orthography and morphological dataset

Start by loading morphological data and the definition of the dataset's orthography into a `Kanones.Dataset` structure.  If the orthography is not explicitly given, it defaults to `LiteraryGreekOrthography` from the `PolytonicGreek` package (as here).

```@example eg
core_inflection = joinpath(reporoot, "datasets", "core-infl")
core_vocab = joinpath(reporoot, "datasets", "core-vocab")
kd = dataset([core_inflection, core_vocab])
typeof(kd)
```
```@example eg
typeof(kd.orthography)
```



### Compile a parser

In addition to the `Kanones.Dataset` you have created, identify a directory with the core FST files (normally, this will be the `fst` directory in a copy the `Kanones.jl` github repository), and a target directory where you want to compile the transducer.  The file in that directory with the binary FST parser will be named `greek.a`.


```@example eg
fstsrc = joinpath(reporoot,  "fst")
parser = buildparser(kd, fstsrc, target)
basename(parser.sfstpath)
```

### Parse a token

Parsing an individual token returns a (possibly empty) Vector of `Analysis` objects.  In this example, only one analysis is possible for the token  "γνώμαις".

```@example eg
parses = parsetoken( "γνώμαις", parser)
parse = parses[1]
```



### Reading an analysis

Each `Analysis` object includes identifying URNs for a *form* and a *lexeme*. Numerous functions (documented in the following pages) are available when you convert the generic form to a `GreekForm`.

```@example eg
morph_form = greekForm(parse.form)
label(morph_form)
```

If you have a dictionary of Liddell-Scott-Jones identifiers handy, you can convert the generic lexeme to a `GreekLexeme`, and label it with a lemma.  This example loads the LSJ dictionary that is included in the Kanones repository.


```@example eg
greeklex = GreekLexeme(parse.lexeme)
lsjfile = joinpath(reporoot, "lsj", "lsj-lemmata.cex")
lsj = Kanones.lsjdict(lsjfile)
label(greeklex, lexicon  = lsj)
```