
@testset "Compile parser for core dataset" begin
    d = tempdir()
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")

    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    FstBuilder.buildparser(kd,fst, fullpath)
    
    expected = joinpath(d, "testcompile", "greek.a")
    @test isfile(expected)

    rm(joinpath(d , "testcompile"), recursive=true)
end
