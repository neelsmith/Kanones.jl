@testset "Test resulting token in uninflected analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/", literaryGreek())
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "καί")
    @test isa(analyzed, Analysis)
    @test analyzed.token == "και"

end