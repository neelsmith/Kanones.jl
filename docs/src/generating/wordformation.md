# Combining stem and inflection for regular formations

Invidual analytical requirements have specific rquirements for combining stems and inflectional patterns.

## Substantives

For nouns, pronouns and adjectives, just  `stemstring(stem) * ending(rule)`


!!! warning "Adverbs"
    Adverbs are not yet implemented.



## Verbs

The function `regularverbclass` is true if it is possible to form all principal parts from a single stem.
For these classes, the function `principalpart` then composes a principal part for a stem + rule combination.  This includes reduplication and augment for tense-mood combinations that require that.

If the stem is *not* sufficient for generating a full set of principal parts, then the functions `takesreduplication` and `takesaugment` are used to determine whether the string recorded for the stem should be further modified using the `reduplicate` and `augment` functions from the `PolytonicGreek` package.

At this point, 