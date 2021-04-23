
@testset "Test resulting values in noun analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/synoptic/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "γνώμαις")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γνωμαις"

end


@testset "Test resulting values in irregular noun analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/synoptic/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "γυνή")
    
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == nfkc("γυνη")

end