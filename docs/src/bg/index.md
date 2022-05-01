# Background: analysis by synthesis

One possible functional definition of *morphological analysis*, or parsing, is:

!!! note "Morphological analysis (parsing)"

    Given a token (a string value), generate pairings of a vocabulary item (*lexeme*) and a *morphological form*.


*Morphological synthesis* is the inverse operation:  given a lexeme and a form, generate a surface token.

It is usually assumed that these two operations are directly reversible: analysis is thought of as "undoing" the process of synthesis.  This is literally true when, as is frequently the case, natural language parsers are implemented with finite state transducers.

In polytonic Greek, however, the surface token includes movable accents.  The correct orthography of the token results from a complex ineraction of the morphological system, phonological systems, and the accent system.  While this process can be implemented computationally to *generate* surface tokens, it is not stateless, and consequently cannot be simply reversed to analyze a token.  Kanones therefore takes a different approach to morphological analysis: *analysis by synthesis*.


## Kanones' solution
 
Kanones' solution could be summarized as:


1. Generate all possible forms
2. "Parsing" becomes a lookup operation
3. A "parser" becomes the set of all possible tokens associated with all possible analyses for that token



Result in 2022: technologically minimal and fast for use; easily implemented from plain-text data sources that a classicist can modify or add to.

## Distinctive features of Kanones' analyses

Kanones uses model of `CitableParserBuilder` module

- four components:
    1. lexeme
    2. form
    3. stem
    4. rule
- all elements other than string tokens identified by URN
