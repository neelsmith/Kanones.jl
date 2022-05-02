# Managing Kanones datasets



- You manage rules and stems in delimited-text files
- Kanones has a required directory structure for data files

See the reference section for information on predefined stem types.

### Directory organization

Kanones checks for `.cex` files in the following subdirectories of a data source:

```
├── irregular-stems
│   ├── adjectives
│   ├── adverbs
│   ├── finiteverbs
│   ├── infinitives
│   ├── nouns
│   ├── participles
│   └── pronouns
├── rules-tables
│   ├── adjectives
│   ├── adverbs
│   ├── finiteverbs
│   ├── infinitives
│   ├── nouns
│   ├── participles
│   └── uninflected
├── stems-tables
│   ├── adjectives
│   ├── nouns
│   ├── uninflected
│   ├── verbs-compound
│   └── verbs-simplex
└── urnregistry
    ├── lexemes
    ├── rules
    └── stems
```    


## Loading a dataset

Use the `dataset` function to create a `Kanones.FilesDataset`.


Pass in a list of full paths to one or more directories laid out according to Kanones conventions, and optionally an orthography.  The default orthogrpahy is `LiteraryGreekOthography`.

```@setup kd
repo = pwd() |> dirname |> dirname  |> dirname

```

```@example kd
src1 = joinpath(repo, "datasets", "core-infl")
src2 = joinpath(repo, "datasets", "core-vocab")
datasrcs = [src1, src2]

using Kanones
kdata = dataset(datasrcs)
typeof(kdata)
```


