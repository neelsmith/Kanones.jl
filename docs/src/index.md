
```@setup intro
repo = pwd() |> dirname |> dirname 
```


# Kanones

> ☛ Build customized morphological parsers for ancient Greek


- all data managed in delimited-text tables you can modify or add to with any text editor
- rigorously defined orthography.  Example parsers include standard orthography of printed editions of literary Greek, and a parser for epigraphic Greek in the alphabet used by Athens before 403 BCE.
- implemented entirely in the Julia language (no other technical prerequisites): 
    - platform independent
    - *fast*
    - code library can be used from command line, in scripts, in web apps, directly in an editor like Visual Studio Code


## Quick example: interactive building and parsing

Load a dataset, and build a parser from it.

```@example intro
using Kanones, CitableParserBuilder, Markdown
srcdir = joinpath(repo, "datasets", "lg-core") 
kds = Kanones.dataset([srcdir])
p = stringParser(kds)
p isa StringParser
```

Parse a string: there's are two results in this case.

```@example intro
s = "ἀνθρώπῳ"
parses = parsetoken(s, p)
length(parses)
```

Label the results:

```@example intro
parses .|> gmfNoun .|> label
```


## Contents

1. Background: a synthesis-first approach to parsing NL morphology
2. User's guide:  the four datasets Kanones uses
3. Reference: stem classes and paradigms
4. Reference: API documentation
