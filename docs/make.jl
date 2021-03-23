push!(LOAD_PATH,"../)

#import Pkg 
#Pkg.add("CitableParserBuilder")
#Pkg.add("CitableObject")

using Documenter
using CitableObject
using Kanones, Kanones.FstBuilder


makedocs(sitename="Kanones.jl Documentatoin")
