

## Current coverage



Kanones.jl is being developed with test datasets in three distinct orthographies: standard literary Greek as it appears in printed editions, an extended literary Greek orthography including symbols found in some manuscripts, and an orthography for the archaic and classical Attic alphabet used for public documents in Athens before 403 BCE.


Kanones.jl recognizes nine analytical types, defined by the kind of analysis a parse returns.  The following table tracks coverage so far of analyzing and generating forms for each analytical type in both literary Greek and Attic Greek orthographies. ✔️ indicates a working version of the listed task;  ☑️ means that a standard suite of tests has been applied.


| Analytical type | morphology | analyze literary Greek regular form |  analyze literary Greek irregular form  |  generate literary Greek | generate literary Greek irregular  | analyze Attic regular form | analyze Attic irregular form  | generate Attic |
| --- | --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| uninflected token | part of speech | ☑️  | **N/A** | ✔️  | **N/A** | ✔️ | **N/A** | ✔️ |
| noun | gender, case, number (gender inherent) | ☑️ | ☑️ | ✔️ | ✔️ | ✔️ | ✔️  | ✔️  |
| pronoun | gender, case, number (gender not inherent) |  **N/A** |  ☑️ | | |  **N/A** | | | 
| finite verb | person, number, tense, mood, voice | ☑️ | ☑️  | | | | | |
| infinitive | tense, voice | ☑️ | ☑️  | | | | | |
| participle | tense, voice, gender, case, number |☑️ | **N/A** | | | |   | |
| verbal adjective |  gender, case, number | ☑️  |  **N/A** |  | |   | **N/A** | |
| adjective | gender, case, number, degree |☑️  | ☑️ | | | | | |
| adverb | degree |  |  **N/A** | | | |  **N/A** | |