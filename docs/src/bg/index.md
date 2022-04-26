# Background: analysis by synthesis


!!! note "Morphological analysis (parsing)"

    Given a token (a string value), generate pairings of a vocabulary item (*lexeme*) and a morphological form.

Symmetrical operation: synthesis.  Given a form and a lexeme, generate surface token.

Normally assumed that analysis and synthesis are reversible.

This is not true in Greek. Interaction of morphological systems, phonological systems, and movable accent are not stateless.


## Kanones' solution

1. Generate all possible forms
2. "Parsing" becomes a lookup operation
3. A "parser" becomes the set of all possible tokens associated with all possible analyses for that token

Result in 2022: technologically minimal and fast for use; easily implemented from plain-text data sources that a classicist can modify or add to.

## Analysis

Kanones uses model of `CitableParserBuilder` module

- four components:
    1. lexeme
    2. form
    3. stem
    4. rule
- all elements other than string tokens identified by URN
