using Pkg
Pkg.activate("..")

using Kanones
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using PolytonicGreek, Orthography
using Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
