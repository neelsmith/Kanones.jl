
Vocabulary from Lysias to use for test development:

### Function words

- the article
- pronouns: ὅδε, οὗτος
- √ indeclinable particles and prepositions

### Verbs

| Verb | Kanones stem type(s) |
| --- | --- |
| κελεύω | `w_regular` |
| γίγνομαι | |
| ποιέω | |
| δείκνυμι | |
| λαμβάνω | |



### Nouns

| Noun | Kanones class | Kanones accent category |
| --- | --- | --- |
| οἰκία | `a_as` | `stemaccented` |
| θεπάπαιν | `a_as_short` | `recessive` |
| γνώμη | `h_hs` | `recessive` |
| νόμος | `os_ou` | `recessive`|
| πόλις||
| ἀνήρ||
| γυνή||
| ἄνθρωπος| `os_ou` | `recessive` |
| παῖς||
| χρῆμα||
| παιδίον||



## Analysis and generation

1. collect stems and rules from a `Kanones.Dataset`
2. generate(stemid, ruleid) yields an array of matches
3. generate(lexid, ruleid) generates ... ?
4. generate(analysis) uses internal members of structure


Pipeline for validation:

fullcircle = parsetoken(p, t) |> generate 
fullcircle == t

OR

(parsetoken(p, t) |> generate ) == t