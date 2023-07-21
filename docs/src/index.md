
```@setup intro
repo = pwd() |> dirname |> dirname 
```

# Kanones

> ☛ Build customized morphological parsers for ancient Greek


- all data managed in delimited-text tables you can modify or add to with any text editor
- rigorously defined orthography.  Example parsers include standard orthography of printed editions of literary Greek, and a parser for epigraphic Greek in the alphabet used by Athens before 403 BCE.
- implemented entirely in the Julia language (no other technical prerequisites): 
    - platform independent
    - fast:  a parser built with Kanones on consumer-grade hardware can typically parse a token in 1-9 milliseconds.
    - code library can be used from command line, in scripts, in web apps, directly in an editor like Visual Studio Code


## Quick example

## Building a parser

Load a dataset, and build a parser from it.  All the examples in this documentation use [the `literarygreek-rules` dataset](https://github.com/neelsmith/Kanones.jl/tree/main/datasets/literarygreek-rules) found in the `datasets` directory of the Kanones github repository.

```@example intro
using Kanones, CitableParserBuilder
srcdir = joinpath(repo, "datasets", "literarygreek-rules") 
kds = dataset([srcdir])
p = stringParser(kds)
p isa StringParser
```


## Interactive parsing

Parse a string: in this case, there is only one result.

```@example intro
s = "ἀνθρώπῳ"
parses = parsetoken(s, p)
```

Extract a `GreekMorphologicalForm` from each analysis, and apply the `label` function to each:

```@example intro
parses .|> greekForm .|> label
```

