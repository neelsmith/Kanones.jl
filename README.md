# Kanones.jl

A julia package implmenting the kanones system for building Greek morphological parsers.


## Current coverage



Kanones.jl is being developed with test datasets in three distinct orthographies: standard literary Greek as it appears in printed editions, an extended literary Greek orthography including symbols found in some manuscripts, and an orthography for the archaic Attic alphabet used for public documents in Athens before 403 BCE.


Kanones.jl recognizes nine analytical types, characterized by the kind of analysis a parse creates.  The following table tracks coverage so far of analyzing and generating forms for each analytical type in both literary Greek and Attic Greek orthographies.


| Analytical type | morphology | analyze literary Greek |  generate literary Greek | analyze Attic | generate Attic |
| --- | --- | --- | --- | --- |
| uninflected token | part of speech | ✔️  | | | |
| noun | gender, case, number | ✔️ |  | | |
| adjective | gender, case, number, degree | | | | |
| finite verb | person, number, tense, mood, voice | | | | |
| infinitive | tense, voice|| | | |
| participle | tense, voice, gender, case, number | | | | |
| verbal adjective |  gender, case, number || | | |
| adverb | degree |  | | | |
| pronoun | gender, case, number | | | | |