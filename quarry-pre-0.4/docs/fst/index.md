# Internals of building and using a finite state transducer

!!! note
    In order to use Kanones.jl, it is not necessary to understand the internal logic that the FST follows in parsing morphology

The final parsing transducer is actually created by a chain of smaller transducers. In broad outline, they do the following:

- combine all lexical entries ("stems") with all inflectional rules (that is, generate the cross product of stems and rules)
- pass to a transducer that accepts only pairings of stems and rules belonging to the same stemtype (defined in `symbols/stemtypes.fst`)
- categorize all symbols as either "surface" symbols, or "analytical" symbols, and allow only one category to pass through

The transducers that do this work are organized in the following directories:


## FST symbols

A finite state transducer transforms symbols between a generated, or surface, form and an analysis.

The vocabulary of symbols  is defined in the file `symbols.fst` located in the root directory of the build. This file in turn uses include statements to draw together symbol definitions from five files in the adjacent `symbols` directory. Together, these define the complete set of symbols recognized by the FST, so any transducer has access to the full symbol set by including `symbols.fst`.

### Organization of definitions in the symbols directory

Within the symbols directory, definitions are organized as follows:

- `alphabet.fst`: defines the symbols used to encode text strings in this orthography.  This is generated automatically from an implementation of `GreekOrthograpy`.
- `markup.fst`: special symbols for separating stem from inflectional component in the morphological database, and marking the beginning and ends of URN values in the data.
- `morphsymbols.fst`: defines symbols for analytical values (such as “gender”, “case” and “number” for nouns).
- `phonology.fst`: defines all legal symbols in the FST other than the morphological categories defined in stemtypes.fst
- `stemtypes.fst`: defines symbols in the FST for morphological categories for stems.
