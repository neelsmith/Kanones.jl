# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
#using PolytonicGreek
using CitableObject
using Kanones


makedocs(
    sitename="Kanones.jl",
    pages = [
        "Home" => "index.md",
       
        "Background" => Any[
            "Analysis by synthesis" => "bg/index.md",
            "Kanones' analyses" => "bg/analysis.md",
            "Data sets" => "bg/datasets.md"
        ],
        "User's guide" => Any[
            "Identification with URNs" => "urns.md",
            "Vocabulary items (lexemes)" => "lexicon.md",
            "Lexical stems" => "stems.md",
            "Inflectional rules" => "rules.md",
            "Working with morphological data" => "morph.md",
            "Morphological forms" => "forms.md",
           "Morphological properties" => "properties.md",
         
           
           
     
           "Utilities" => "utilities.md"
          
           
        ],
      
        "Reference: stem types and paradigms in the `literarygreek-rules` dataset" => Any[
            "Stem types and paradigms" => "stemtypes/index.md",
            "Noun stems" => Any[ 
                "stemtypes/nouns/index.md",
                "Regular nouns: first declension" => "stemtypes/nouns/decl1.md",
                "Regular nouns: second declension" => "stemtypes/nouns/decl2.md",
                "Regular nouns: third declension" => "stemtypes/nouns/decl3.md",
                "Irregular nouns" => "stemtypes/nouns/irreg.md"
            ],
            "Adjective stems" => Any[
                "Adjective stems and paradigms" => "stemtypes/adjectives/index.md",
                "Adjectives of the first and second declensions" => "stemtypes/adjectives/first-second.md",
                "Adjectives of the third declensions" => "stemtypes/adjectives/third.md"
            ],
        
            "Verbal stems" => Any[
                "stemtypes/verbs/index.md",
                "Regular verbs: -ω conjugation"  => "stemtypes/verbs/omega.md",
                "Regular verbs: -μι conjugation"  => "stemtypes/verbs/mi.md",
                "Regular verbs: -εω contracts"  => "stemtypes/verbs/ew_contracts.md",
                "Regular verbs: -αω contracts"  => "stemtypes/verbs/aw_contracts.md",
                "Regular verbs: -οω contracts"  => "stemtypes/verbs/ow_contracts.md",
                "Regular verbs in -ιζω"  => "stemtypes/verbs/izw.md",
                "Attic futures" => "stemtypes/verbs/atticfut.md",
                "Second aorists" => "stemtypes/verbs/secondaor.md",
                "Principal parts" => "stemtypes/verbs/princparts.md",
                "Irregular verb forms" => "stemtypes/verbs/irregulars.md",
                
            ],
            "Pronouns" => "stemtypes/pronouns/index.md",

            "Uninflected types" => "stemtypes/uninflected.md",
            "Participles" => Any[
                "Participle paradigms" => "stemtypes/participles/index.md",
                "Participles of regular -ω verbs" => "stemtypes/participles/omega.md",
                "Participles of -εω contracts"  => "stemtypes/participles/ew_contracts.md",
                "Participles of -αω contracts"  => "stemtypes/participles/aw_contracts.md",
                "Participles of -οω contracts"  => "stemtypes/participles/ow_contracts.md",
                "Participles of -μι verbs" => "stemtypes/participles/mi.md",
                "Participles of verbs in -ιζω"  => "stemtypes/verbs/izw.md",
                "Second aorist participles" => "stemtypes/participles/secondaor.md",
            ]
        ],   

        "Reference: vocabulary in the `lsj` dataset" => Any[
            "vocab/index.md",
            "δίδωμι" => "vocab/irregular/didomi.md"
        ],
        "Reference: API documentation" => Any[
            "Julia API documentation" =>  "apis/apis.md",
            "Morphological properties and forms" => "apis/morph.md"
        ]
    
     
    ],
    )

deploydocs(
        repo = "github.com/neelsmith/Kanones.jl.git",
)