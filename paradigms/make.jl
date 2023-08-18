# Run this from repository root, e.g. with
# 
#    julia --project=paradigms/ paradigms/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="paradigms/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
#using PolytonicGreek
using CitableObject
using Kanones


makedocs(
    sitename="Kanones paradigms",
    authors="Neel Smith",

    pages = [
      
        "Reference: vocabulary in the `lsj` dataset" => Any[
            "index.md",
            "Summary of regularly inflected vocabulary" => "regulars.md",
         
            "Regular verb classes" => Any[
                "A pure vowel verb of `w_regular` class:  κινδυνεύω" => "regularverbs/kinduneuw.md",
                "A consonant verb of the `w_regular` class" => "regularverbs/arxw.md",
                #"The `w_regular_dep` class" => "regularverbs/pragmateuw.md",

                "An epsilon contract verb of the `ew_contract` class:  ποιέω" => "regularverbs/poiew.md",

            ],
           #= "Irregular verbs" => Any[
                #"Overview of irregular nouns" => "vocab/irregularverbs/index.md",
                #"δίδωμι" => "irregularverbs/didomi.md",
                #"τίθημι" => "irregularverbs/tithemi.md",
                #"ἵστημι" => "irregularverbs/histemi.md",
                #"ἵημι" => "irregularverbs/hiemi.md",
                #"εἰμί" => "irregularverbs/eimi-tobe.md",
                #"εἶμι" => "irregularverbs/eimi-togo.md",
                #"οἶδα" => "irregularverbs/oida.md",
            ],
            
            "Irregular nouns" => Any[
                "Overview of irregular nouns" => "irregularnouns/index.md"
            ],
            "Irregular adjectives" => Any[
                "Overview of irregular adjectives" => "irregularadjs/index.md"
            ]
            =#
        ]
    ]
)
