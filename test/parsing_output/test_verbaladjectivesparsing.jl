@testset "Test resulting values in verbal adjective analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))

    #parser = d * "/testcompile/greek.a"
    analyzed = parsetoken("ποιητέον", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#ποιητεον"

end