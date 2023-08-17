# Reading delimited text files


## Instantiating a dataset

- root directory
- orthography

(See previous pages on the diretory layout of stem and rule types in a `FilesDataset`.)

This is enough for the `stemsarray` and `rulesarray` functions to collect all stem and rule data from the file system of a `FilesDataset`.

## Stems and Rules

There are five stem types that are subtypes of `KanonesStemType`.

There are nine rules types that are subtypes of `KanonesRuleType`.

Each stem type implements the `readstemrow` function; each rule type implements `readrulerow`.  These functions read a single delimited-text line and construct a stem or row of their type.