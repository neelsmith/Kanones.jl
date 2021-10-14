@testset "Test resulting values in participle analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"
    parser = FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    #parser = d * "/testcompile/greek.a"
    analyzed = parsetoken("κελευόμενον", parser)
    @test length(analyzed) == 6
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#κελευομενον"

end