# Combining stem and inflection for regular formations

Invidual analytical requirements have specific rquirements for combining stems and inflectional patterns.

## Substantives

For nouns, pronouns and adjectives, just  `stemstring(stem) * ending(rule)`


!!! warning "Adverbs"
    Adverbs are not yet implemented.



## Verbs

The function `regularverbclass` is true if it is possible to form all principal parts from a single stem.
For these classes, the function `principalpart` then composes a principal part for a stem + rule combination.