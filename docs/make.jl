push!(LOAD_PATH,"../")
using Pkg
Pkg.activate(".")

using Documenter
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
