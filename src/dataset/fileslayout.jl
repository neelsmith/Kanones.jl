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

RULES_IO_DICT = Dict(
        [
        "uninflected" => UninflectedIO("uninflected"),
        "irregulars" => IrregularRuleParser("irregulars"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounIO("noun"),
        "adjectives" => AdjectiveIO("adjectives"),
        "finiteverbs" => VerbIO("verb"),
        "infinitives" => InfinitiveIO("infinitives"),
        "participles" => ParticipleIO("participles"),
        "verbaladjectives" => VerbalAdjectiveIO("verbal adjectives"),
        ]
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
        "adjectives" => AdjectiveIO("adjective"),
        "nouns" => NounIO("noun"),
        "pronouns" => PronounIO("pronoun"),
        "uninflected" => UninflectedIO("uninflected"),
        "verbs-simplex" => VerbIO("verb")
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