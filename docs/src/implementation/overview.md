# Programmer's notes on implementation

`Kanones` is designed so that corpus-specific datasets can be managed from delimited text files.  Normally, end-users will build a parser directly from these files with the `buildparser` function, and then work with the output of the parser as objects such as `AnalyzedToken`s, or a pairing of a string with an `Analysis`.


This section of the documentation illustrates what `Kanones` does behind the scene to make this happen.


```@setup impleg
repo = pwd() |> dirname |> dirname  |> dirname
```



## Reading delimited data sets from delimited-text files

Data sets, organized as stem files and rule files for each analytical type ("part of speech"), are managed in delimited text files.  When a parser is built, Kanones reads these files and writes source code for an SFST compiler.  


Directories of delimited-text files are managed with a `Kanones.Dataset` using a specified `OrthographicSystem` (default: `LiteraryGreekOrthography`).  This example uses an absolutely minimal dataset in the `datasets/implementation-eg` diretory of this repository: a stem for a single noun, and a single rule. 
(You can browse the two source files on github [here](https://github.com/neelsmith/Kanones.jl/tree/dev/datasets/implementation-eg).)  The noun is the masculine noun ἄνθρωπος (`lsj.n8909`) and the only rule defined is for the formation of its genitive singular form.


```@example impleg
using Kanones, Kanones.FstBuilder
sampledatafiles = joinpath(repo,"datasets","implementation-eg")
kd = dataset([sampledatafiles])
typeof(kd)
```


The `KanonesIO` abstraction defines two functions to read data from delimited text sources (`Kanones.readstemrow` and `Kanones.readrulerow`), and can write data to SFST format with the `fst` function.  Let's see how this works.






### Parsing delimited text to objects with `KanonesIO`

The `readstemrow` and `readrulerow` functions apply appropriate subtypes of the `KanonesIO` abstract type to read each subdirectory of a `Kanones.Dataset`:  `stemsarray` cycles through all the subdirectories of the dataset, and applies  the `readstemrow` function to the file contents of stem tables, while `rulesarray`  applies the `readrulerow` function to the contents of rules tables.  

To read stems and rules data, we use subtypes of the `KanonesIO` abstraction.  In this example, the conventions for a dataset's layout dictate that the contents of the `stems-tables/nouns` directory should contain noun stems, so we'll read those files with a `NounIO`, which is a subtype of `KanonesIO`.

```@example impleg
nounio = Kanones.NounIO("Reader/writer for noun data.")
typeof(nounio) |> supertype
```

Here's the one data line included in our source data for lexicon stems.  When we read the data with `readstemrow`, the result will be a subtype of the `CitableParserBuilder.Stem` abstract type.

```@example impleg
stemdata = "nounstems.n8909|lsj.n8909|ἀνθρωπ|masculine|os_ou|recessive|"
stem = Kanones.readstemrow(nounio, stemdata)
stem |> typeof |> supertype
```

Similarly, when we use the `NounIO` object to read a row of rules data, we get a subtype of `CitableParserBuilder.Rule`. 

```@example impleg
ruledata = "nouninfl.os_ou2|os_ou|ου|masculine|genitive|singular|"
rule = Kanones.readrulerow(nounio, ruledata)
rule |> typeof |> supertype
```
This allows the `stemsarray` and `rulesarray` functions to read *all* stems and rules into arrays of `CitableParserBuilder.Stem` and `CitableParserBuilder.Rule` objects, respectively.


```@example impleg
stems = Kanones.stemsarray(kd)
typeof(stems)
```

In this instance, the single result  will be identical to the single example we previously constructed.


```@example impleg
stems[1] == stem
```

Similarly for rules.

```@example impleg
rules = Kanones.rulesarray(kd)
typeof(rules)
```



```@example impleg
rules[1] == rule
```



### Writing SFST source files

The `Kanones.KanonesFstBuilder.fst` formats `Stem` and `Rule` objects in the SFST language, and works with all the `Kanones`' subtypes of the `Stem` and `Rule` types.  As these examples illustrate, values are translated either to individual symbols (such as `<noun>` or `<masculine>`), or to formatted strings (such as URN values), with appropriate escaping of SFST metacharacters and normalization to Unicode NFKC.


```@example impleg
Kanones.FstBuilder.fst(stem)
```

```@example impleg
Kanones.FstBuilder.fst(rule)
```

When the source files for a parser are composed, the SFST code for stems are combined in SFST's "lexicon" format (one entry per line, and written to `lexicon.fst`. Rules files are combined as source for a single transducer that is the disjunction of all possible inflectional rules, and written to `inflection.fst`.  


The `buildparser` function additionally composes the SFST logic for filtering out only valid combinations of stems + rules in `acceptor.fst`, and the final transducer in `greek.fst`, as well as a make file which it then uses to compile the binary parser.

## Reading the output of an SFST parser

When a `Kanones` parser parses a token, the SFST parser returns line-oriented string data that looks like this:


```@example impleg
rawreply = "> ἀνθρωπου\n<u>nounstems.n8909</u><u>lsj.n8909</u>ἀνθρωπ<noun><masculine><os_ou><div><os_ou><noun>ου<masculine><genitive><singular><u>nouninfl.os_ou2</u>\n"
```

For successful parses, lines beginning with `> ` identify the token being parsed; subsequent lines list one successful parse per line.

```@example impleg
lines = split(rawreply,"\n")
```

Several functions parse data like this by passing non-empty lines with parse output to `Kanones.analysisforline` -- here, the second line of the reply.

```@example impleg
lines[2]
```

Stem and rule components are separated by the FST token `<div>`.  

`Kanones.analysisforline` divides the reply into separate stem and rule components, and extracts the second token of the rule component to determine an analysis type -- here, `<noun>`.

```@example impleg
(stemfst, rulefst) = split(lines[2], "<div>")
rule
```

The equivalent of what happens inside the `Kanones.analysisforline` is:


```@example impleg
nounform = Kanones.nounfromfst("<masculine><genitive><singular>")
```

It uses a dictionary mapping names of analysis types to functions that can parse FST output for that analytical type into a `FormUrn`.  For analyses identifed by `<noun>`, it applies the `Kanones.nounfromfst` function.  These are versatile objects that can be used in many ways.


```@example impleg
label(nounform)
```

```@example impleg
urn(nounform)
```

```@example impleg
cex(nounform)
```

```@example impleg
Kanones.formurn(nounform)
```

## Validating the result: analysis through synthesis

TBA