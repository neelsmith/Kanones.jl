@testset "Test resulting token in uninflected analysis" begin
    d = tempdir()
    
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/synoptic/"]; ortho = literaryGreek())
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "καί")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "και"

end