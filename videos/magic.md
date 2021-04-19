---
theme: White
---

# The magic of URNs in Kanones

Use morphological datasets in plain-text tables to 

1. parse tokens
2. generate tokens
3. build morphologically aware apps in Julia


---

# `Kanones.Dataset`

- specific to a corpus
- has a specific orthography
- abbreviated URNs for all values


---

# Orthographies

- specified set of characters
- specified set of token classes
- specified semantics for tokenization


---

#  Greek orthography

- syllabification
- accentuation
- sorting


---

# Data in plain-text tables

```
video/
├── irregular-stems
    ├── nouns
    ├── ...
├── rules-tables
    ├── nouns
    ├── ...
├── stems-tables
    ├── nouns
    ├── ...
└── urnregistry
```


---


# Build a dataset

Default orthography is standard literary Greek

```julia
using Kanones, Kanones.FstBuilder

ds = dataset(pwd() * "/datasets/video/")
```


---

# Specify an orthography

```julia
using AtticGreek

attic = atticGreek()
atticds = dataset(pwd() * "/datasets/attic/"; ortho = attic)
```

---


# Finite state transducer

- used to analyze tokens
- built from dataset + FST files
- (future option: load FST files directly from Kanones github repository)

---

# Build a parser

1. a dataset
2. Kanones `fst` files
3. output directory

```julia
lgparser = buildparser(ds, fst, pwd() * "/parsers/litgreek/")
atticparser = buildparser(atticds, fst, pwd() * "/parsers/attic/")
```


---

# Parse a token

The result is an array of 0 or more analyses.

```julia
parses = parsetoken(atticparser, "βολêς")
```

---

# Generate a token

1. analysis
2. dataset

```julia
analysis = parses[1]
generated = generate(analysis,ds)
```

---

# Analyze the generated form


```julia
newtoken = generated[1]
lgparses = parsetoken(lgparser, newtoken)
```

---

# Explore morphology with Julia

- by running scripts
- interactively in VS Code
- in Pluto notebooks
- anywhere else Julia runs


---