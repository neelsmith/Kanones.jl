# Model for Form URN values:
# PosPNTMVGCDCat

"""Constants for analytical types ("parts of speech")"""
const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3
const INFINITIVE = 4
const PARTICIPLE = 5
const VERBALADJECTIVE = 6
const ADJECTIVE = 7
const ADVERB = 8
const PRONOUN = 9

"""Constants for analytical types ("parts of speech").

$(SIGNATURES)
"""
const poslabels = Dict(
    UNANALYZED => "unanalyzed",
    UNINFLECTED => "uninflected",
    NOUN => "noun",
    FINITEVERB => "verb-finite",
    INFINITIVE => "infinitive",
    PARTICIPLE => "participle",
    VERBALADJECTIVE => "verbal-adjective",
    ADJECTIVE => "adjective",
    ADVERB => "adverb",
    PRONOUN => "pronoun"
)
