# Kanones: guide to editing lexica

> ☛ Add your own vocabulary to a Greek morphological parser.

## Motivation and background

[Kanones](https://neelsmith.github.io/Kanones.jl/stable/) is a system for building morphological parsers from simple delimited-text tables defining vocabulary stems and inflectional rules. While Kanones allows you to build parsers following the orthography of your choosing (e.g., ancient Greek in the alphabet used by Athens prior to 403 BCE), the largest available digital corpora of ancient Greek more or less follow the practice of standard print editions of literary Greek. The Kanones repository includes an extensive (and growing) set of inflectional rules  that provide a solid basis for parsing standard literary Greek.  For stem tables, the [LSJMining](https://neelsmith.github.io/LSJMining.jl/) package is a Julia package that can extract morphological information Giuseppe Celano's Unicode Greek version of the Perseus project's digital [Liddell-Scott-Jones lexicon](https://github.com/gcelano/LSJ_GreekUnicode) (LSJ).  Precomputed analyses for all possible forms created by combining the stems quarried from LSJ with Kanones' inflectional rules for literary Greek are available as a (large!) `csv` file from the Homer Multitext project [here](https://www.homermultitext.org/morphology/morphology-current.csv).



Inevitably, when you parse almost any corpus of a certain size, you encounter vocabulary that does not appear in LSJ (proper names, for example).   It is straightforward to create a supplementary dataset of stems that can be combined with the precomputed analyses from Homer Multitext project to analyze your corpus comprehensively.

## Adding your own vocabulary to a parser

> ### How  Kanones works TBA
>
> - stems + rules are combined based on an *inflectional class*
> - this site documents the inflectional classes used in Kanones' rules for standard literary Greek


> ### What you do TBA
>
>
> layout of your delimited-text files


```
mydata
└── stems-tables
    ├── adjectives
    ├── nouns
    ├── verbs-compound
    └── verbs-simplex
```


>
> use kanones-manager to combine  your data with pre-existing data set. https://neelsmith.github.io/kanones-manager/




!!! note "Other resources"

    - Kanones [technical documentation](https://github.com/neelsmith/Kanones.jl)
    - the [kanones-manager notebook](https://neelsmith.github.io/kanones-manager/)



## Guide to inflectional types and paradigms


Pages on this site document and illustrate the usage of Kanones' inflectional type.  Each page includes:

- an example of an entry in a table of stems
- an automatically composed paradigm illustrating the forms generated from that stem record

In the paradigms, a dash `-` indicates that the morphological form does not exist (e.g, for a finite verb, an impossible combination of tense and mood, such as "imperfect subjunctive").  Empty cells indicate forms that are morphologically possible but are either:

- poorly attested (e.g., verbs in the perfect or optative subjunctive), or 
- entirely unattested (such as active voice forms of deponent verbs)

## Reference: inflectional types and paradigms by part of speech

```@contents
Pages = [
    "nouns/index.md",
    "adjectives/index.md",
    "verbs/index.md"
]
Depth = 1
```



```@eval
using Pkg, Markdown
version = Pkg.installed()["Kanones"]

msg = """
!!! note "Kanones version: $(version)"

    All paradigms on this site were automatically generated with Kanones, version **$(version)**.
"""

Markdown.parse(msg)
```


!!! note "Coverage"

    This section of the documentation is ultimately intended to include an example for every inflectional class in the datasets included in the datasets of the Kanones github repository.




