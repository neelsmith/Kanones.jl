
@testset "Test resulting token in noun analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "γνώμαις")
    @test isa(analyzed, Analysis)
    @test analyzed.token == "γνωμαις"

end
