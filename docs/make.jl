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
        "Manual" => Any[
            "Guide" => "datasets/index.md",
           
        ],
        "FST" => Any[
            "Public" =>  "fst/index.md",
           
        ],
        
    ],
    )
