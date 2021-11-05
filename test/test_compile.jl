
@testset "Compile parser for core dataset" begin
    d = tempdir()
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])

    fst =  joinpath(repo, "fst")
    FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))
    
    expected = joinpath(d, "testcompile", "greek.a")
    @test isfile(expected)

    rm(joinpath(d , "testcompile"), recursive=true)
end
