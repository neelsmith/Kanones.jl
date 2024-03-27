    pages = [
        "The Kanones system for building morphological parsers" => "index.md",
       
        "Background" => Any[
            "Analysis by synthesis" => "bg/index.md",
            "Kanones' analyses" => "bg/analysis.md",
            
        ],

        "User's guide to Kanones data" => Any[
            "Data sets" => "bg/datasets.md",
            "Identification with URNs" => "urns.md",
            "Files dataset" => "filesds.md",
            "Vocabulary items (lexemes)" => "lexicon.md",
            "Lexical stems" => "stems.md",
            "Inflectional rules" => "rules.md",
        ],

        "Using morphological objects in Julia" => Any[
            "Morphological forms" => "forms.md",
            "Morphological properties" => "properties.md",     
            "Utilities" => "utilities.md"
        ],
        
        "Implementation: building a dataset" => Any[
            "Reading delimited files" => "building/buildingds.md",
            "Profliling a data set" => "building/profiles.md",

        ], 

        "Implementation: generating forms" => Any[
            "Generating a form" => "generating/generating.md",
            "Combining stem and inflection" => "generating/wordformation.md",
            "Accenting the final string" => "generating/accent.md",
        ],
        
       #=
        "Reference: vocabulary in the `lsj` dataset" => Any[
            "vocab/index.md",
            "Summary of regularly inflected vocabulary" => "vocab/regulars.md",
            "Irregular verbs" => Any[
                "Overview of irregular nouns" => "vocab/irregularverbs/index.md",
                "δίδωμι" => "vocab/irregularverbs/didomi.md",
                "τίθημι" => "vocab/irregularverbs/tithemi.md",
                "ἵστημι" => "vocab/irregularverbs/histemi.md",
                "ἵημι" => "vocab/irregularverbs/hiemi.md",
                "εἰμί" => "vocab/irregularverbs/eimi-tobe.md",
                "εἶμι" => "vocab/irregularverbs/eimi-togo.md",
                "οἶδα" => "vocab/irregularverbs/oida.md",
            ],
            "Irregular nouns" => Any[
                "Overview of irregular nouns" => "vocab/irregularnouns/index.md"
            ],
            "Irregular adjectives" => Any[
                "Overview of irregular adjectives" => "vocab/irregularadjs/index.md"
            ]
        ],
     =#  
        "Reference: API documentation" => Any[
            "Julia API documentation" =>  "apis/apis.md",
            "Morphological properties and forms" => "apis/morph.md"
        ]
    ]
    )
