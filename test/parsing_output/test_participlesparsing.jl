@testset "Test resulting values in participle analysis" begin
    d = tempdir()
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d,  "testcompile"))

    #parser = d * "/testcompile/greek.a"
    analyzed = parsetoken("κελευόμενον", parser)
    @test length(analyzed) == 6
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#κελευομενον"

end