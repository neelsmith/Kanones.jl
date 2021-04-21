# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
#using PolytonicGreek
using CitableObject
using Kanones, Kanones.FstBuilder


makedocs(
    sitename="Kanones.jl",
    pages = [
        "Home" => "index.md",
        "Background" => "bg/index.md",
        "Manual" => Any[
            "Prerequisites" => "prereqs.md",
            "Managing Kanones datasets" => "datasets/index.md",
            "Compiling and parsing" => "parsing/index.md",
            "Working with analytical data" => "analyses/index.md"
           
        ],
        "Reference: stem types" => Any[
            "Contents" => "stemtypes/index.md",
            "Nouns" => "stemtypes/nouns/nounstems.md",
            "Irregular nouns" => "stemtypes/nouns/irregulars.md",
            "Uninflected types" => "stemtypes/uninflected.md",
        ],
        "Reference: code" => Any[
            "Julia API documentation" =>  "apis/apis.md",
            "FST" =>  "fst/index.md",
            
        ],
        
    ],
    )
