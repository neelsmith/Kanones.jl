@testset "Test resulting token in uninflected analysis" begin
    d = tempdir()
    
    repo = dirname(pwd())

    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")
    

    compilerdir = joinpath(d, "testcompile")
    parser = FstBuilder.buildparser(kd,fst, compilerdir)
    analyzed = parsetoken("καί", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "και"
    #rm(d; recursive = true)

end