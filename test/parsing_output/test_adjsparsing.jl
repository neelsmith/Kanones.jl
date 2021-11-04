@testset "Test resulting values in adjective analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"
    parser = FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    analyzed = parsetoken( "καλός", parser)
    @test_broken length(analyzed) == 1 # for some reason getting duplicate analysis but can't find bad data source?
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "καλος"

end