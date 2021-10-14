@testset "Test resulting token in uninflected analysis" begin
    d = tempdir()
    
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"]; ortho = literaryGreek())
    fst =  joinpath(repo, "fst")
    

    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))
    analyzed = parsetoken("καί", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "και"
    #rm(d; recursive = true)

end