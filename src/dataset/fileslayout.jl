RULES_DIRECTORIES = [
    "uninflected",
    "irregulars",
    "nouns",
    "pronouns",
    "finiteverbs",
    "infinitives",
    "participles",
    "verbaladjectives",
    "adjectives"
]


RULES_TYPES_DICT = Dict(
        [
        "uninflected" => UninflectedRule,
        "irregulars" => IrregularRule,
        "nouns" => NounRule,
        "pronouns" => PronounRule,
        "adjectives" => AdjectiveRule,
        "finiteverbs" => FiniteVerbRule,
        "infinitives" => InfinitiveRule,
        "participles" => ParticipleRule,
        "verbaladjectives" => VerbalAdjectiveRule
        ]
    )

    # => IrregularRule,
    FORMS_RULES_DICT    = Dict(
        GMFUninflected => UninflectedRule,
        GMFNoun => NounRule,
        GMFPronoun => PronounRule,
        GMFAdjective => AdjectiveRule,
        GMFFiniteVerb => FiniteVerbRule,
        GMFInfinitive => InfinitiveRule,
        GMFParticiple => ParticipleRule,
        GMFVerbalAdjective => VerbalAdjectiveRule
    )

STEMS_DIRECTORIES = [
        "adjectives",
        "nouns",
        "pronouns",
        "uninflected",
        "verbs-simplex", 
]    

STEMS_IO_DICT = Dict(
        [
       # "adjectives" => AdjectiveIO("adjective"),
       # "nouns" => NounIO("noun"),
       # "pronouns" => PronounIO("pronoun"),
        "uninflected" => UninflectedIO("uninflected"),
       # "verbs-simplex" => VerbIO("verb")
        ]
    )


IRREGULAR_STEM_DIRECTORIES = [
        "nouns",
        "verbs",
        "infinitives",
        "adjectives",
        "participles"
    ]    

IRREGULAR_IO_DICT = Dict(
        [
        "nouns" => IrregularNounIO("noun"),
        "verbs" => IrregularVerbIO("finite verb"),
        "infinitives" => IrregularInfinitiveIO("infinitive"),
        "adjectives" => IrregularAdjectiveIO("adjectives"),
        "participles" => IrregularParticipleIO("adjectives")
        ]
    )    


REGISTRY_DIRECTORIES = [
        "lexemes",
        "rules",
        "stems"
    ]    