
# Kanones' analyses

Kanones implements the model of the `CitableParserBuilder` module.  Parsing functions (like `parsetoken`) return a Vector of `Analysis` objects.  In addition to a lexeme and a form, each analysis also includes a *stem* and an inflectional *rule*. Conceptually, the stem and rule provide the rationale for an analysis: the stem explains why a specific lexeme was chosen, and the inflectional rule explains how the token was formed by applying a particular inflectional pattern to the stem.  When generating tokens, pairing a stem and a rule provides enough information to identify a lexeme and a form and to compose a token.  Kanones can actually produce a full `Analysis` object when generating tokens!

This model makes it possible to use the same set of lexemes and the same set of morphological forms with *different* sets of stems and rules.  The Kanones github repoitory include




## Kanones' collections

- four components:
    1. lexeme
    2. form
    3. stem
    4. rule
- all elements other than string tokens identified by URN
