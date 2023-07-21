# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/makepdf.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using CitableObject
using Kanones


makedocs(
    format = Documenter.LaTeX(platform="tectonic"),
    sitename="Kanones.jl",
    authors="Neel Smith",
    pages = [
        "The Kanones system for building morphological parsers" => "index.md",
       
        "Background" => Any[
            "Analysis by synthesis" => "bg/index.md",
            "Kanones' analyses" => "bg/analysis.md",
            
        ],
        "User's guide" => Any[
            "Data sets" => "bg/datasets.md",
            "Identification with URNs" => "urns.md",
            "Vocabulary items (lexemes)" => "lexicon.md",
            "Lexical stems" => "stems.md",
            "Inflectional rules" => "rules.md",
            "Working with morphological data" => "morph.md",
            "Morphological forms" => "forms.md",
            "Morphological properties" => "properties.md",     
            "Utilities" => "utilities.md"
           
        ],

        
        "Implementation: generating forms" => Any[
            "Generating a form" => "implementation/generating.md",
            "Combining stem and inflection" => "implementation/wordformation.md",
            "Accenting the final string" => "implementation/accent.md",
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
