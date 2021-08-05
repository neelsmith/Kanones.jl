@testset "Test resulting values in infintive analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/synoptic/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "κελεύεσθαι")
    @test_broken length(analyzed) == 2
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "κελευεσθαι"

end