push!(LOAD_PATH,"../src/")

using Pkg
Pkg.activate("..")

using Documenter, Kanones


makedocs(sitename="Kanones")
