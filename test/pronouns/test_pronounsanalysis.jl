
@testset "Test resulting values in pronoun analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo , "datasets", "core-infl")])
    fst =  repo * "/fst/"
    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))

    analyzed = parsetoken( "τοῦ", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "του"

end
