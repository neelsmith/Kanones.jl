# Run this from repository root, e.g. with
# 
#    julia --project=paradigms/ paradigms/makepdf.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using CitableObject
using Kanones


makedocs(
    format = Documenter.LaTeX(platform="tectonic"),
    # Everything below this line should be identical to `makejl`

    
    
    )

