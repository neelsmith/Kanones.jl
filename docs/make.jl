# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")' 
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
       
        "Background" => "bg/index.md",
        "User's guide" => Any[
            "Identification with URNs" => "urns.md",
           "Morphological properties" => "properties.md",
           "Morphological forms" => "forms.md",
           "Inflectional rules" => "rules.md",
           "Vocabulary items" => "lexicon.md",
           "Lexical stems" => "stems.md",
           "Utilities" => "utilities.md"
           # "Managing Kanones datasets" => "datasets/index.md",
            
            #"Working with analytical data" => "analyses/index.md",
            #"Programmer's notes on implementation" => "implementation/overview.md", 
            #"Unit tests" => "implementation/units.md"
           
        ],
      
        "Reference: stem types and paradigms" => Any[
            "Contents" => "stemtypes/index.md",
            "Nouns" => "stemtypes/nouns/index.md",
            "Regular nouns: first declension" => "stemtypes/nouns/decl1.md",
            "Regular nouns: second declension" => "stemtypes/nouns/decl2.md",
            "Regular nouns: third declension" => "stemtypes/nouns/decl3.md",
           #"Irregular nouns" => "stemtypes/nouns/irregulars.md",
           #"Uninflected types" => "stemtypes/uninflected.md",
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