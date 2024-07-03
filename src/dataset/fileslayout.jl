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
FORMS_RULES_DICT = Dict(
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

STEMS_TYPES_DICT = Dict(
    "adjectives" => AdjectiveStem,
        "nouns" => NounStem,
        "pronouns" => PronounStem,
        "uninflected" => UninflectedStem,
        "verbs-simplex" => VerbStem, 
)

IRREGULAR_STEM_DIRECTORIES = [
        "nouns",
        "verbs",
        "infinitives",
        "adjectives",
        "participles"
    ]    

IRREGULAR_TYPES_DICT = Dict(
        "nouns" => IrregularNounStem,
        "verbs" => IrregularVerbStem,
        "infinitives" => IrregularInfinitiveStem,
        "adjectives" => IrregularAdjectiveStem,
        "participles" => IrregularParticipleStem
    )

REGISTRY_DIRECTORIES = [
        "lexemes",
        "rules",
        "stems"
    ]    