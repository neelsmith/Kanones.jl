# Background

- morphological analysis is most frequently achieved with FSTs
- morphology of accented Greek is not reversible with FSTs due to complex interactions of morphology and mutable accent
- Kanones uses the "analysis by synthesis" algorithm first developed by Kosman and Smith in the early 1980s.

## Analysis by synthesis

- morphology of Greek *can* be analyzed with FSTs if accent is not considered
- accent *can* be algorithmically added to a lexical token *if* morphology is already known

So to analyze a token:

1. generate a normalized accented form
    - drop accents added from enclitics
    - convert barytone to oxytone
2. generate a form with all accents stripped
3. analyze the accent-free form using a FST.  The result is an Array of 0 or more analyses that are considered hypotheses.
4. For each hypothesis, add the appropriate accent to the unaccented string, and compare to the normalized accented form created in step 1.  If they match, the hypothetical analysis is valid.
