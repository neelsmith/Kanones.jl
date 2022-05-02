# Datasets

For the four collection Kanones needs:


## Forms collection

- a collection of all possible morphological forms is precompiled as part of the GH repo.  These are the only forms Kanones can work with: you cannot change these.

## Collection of lexemes


- a large collection of Greek lexemes is included in two collections: `lsjx` is a collection of candidate lexemes generated from LSJ articles; `lsj` is a subset of those that have been verified to be a lexeme.

## Inflectional rules 

- for standard literary Greek, `datasets/literarygreek-rules` should be all you need for Attic.  You can add to these if you want to e.g. expand coverage of literary dialects. Best practice: maintain additions in separate files, and please submit pull request to add them to Kanones' gh repo!
- for Attic alphabet pre 403 BCE, sample rules in `datasets/attic`.


## Stems

In practice, this is the dataset you're most likely to edit.

Identifying lexemes:

- check LSJ from folio2.furman.edu; use its ID value if you find your item. Otherwise, register your own namespace, create a new id in that namespace
- use separate files to group things easily.  Eg., proper names in a particular text or corpus that do not appear in LSJ