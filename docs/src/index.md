# Kanones.jl

*Build corpus-specific parsers for ancient Greek texts in a specified orthography*.

Kanones.jl lets you build morphological parsers for ancient Greek.  It works with three central concepts: 

1. An explicitly defined **orthography**.
2. A morphological **dataset** (stems and inflectional rules) managed in plain-text tables.
3. **Analyses** recorded with URNs identifying lexemes, forms and the entries in the dataset leading the analysis.


Because Kanones.jl cleanly separates orthography and morphology, you can compile parsers for standard literary Greek, epichoric Greek alphabets, or Greek with manuscript symbols, for example.  Because it manages stems and inflectional rules in plain-text tables, an editor or Greek student can easily tailor a parser to a specific corpus by adding or deleting entries.  Because analyses are expressed with URNs, Kanones.jl's analytical tools can profile a corpus, and even compare lexical and morphological features across corpora in different orthographies. 


## Shortest possible example


!!! note
    The example builds a parser using a sample dataset included in the Kanones.jl git repository.  See the user's manual for a fuller explanation .

```@setup eg
using Kanones
using Kanones.FstBuilder
using CitableParserBuilder
reporoot = pwd() |> dirname |> dirname
target = reporoot * "/parsers/demo/"
```



### Orthography and morphological dataset

Load morphological data and definition of the dataset's orthography into a `Kanones.Dataset` structure.

```@example eg
dataset = reporoot * "/datasets/synoptic/"
kd = Kanones.Dataset(dataset)
```


### Compile a parser

- identify a directory with the core FST files from the Kanones.jl repository
- identify a target directory where you want to compile a parser
- compile a parser. The binary FST parser will be named `greek.a`


```@example eg
fstsrc = reporoot *  "/fst/"
parser = buildparser(kd, fstsrc, target)
basename(parser)
```


### Parse a token: THIS IS WRONG.

Use the parser to parse a token.  The resulting `Analysis` object includes URN values for the form, the lexeme, the stem entry in the dataset's list of stems, and the rule entry in the dataset's list of rules.


```@example eg
parsetoken(parser, "γνώμην")
```
