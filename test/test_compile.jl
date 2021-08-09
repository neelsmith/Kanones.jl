
@testset "Compile parser for core-infl dataset" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    expected = d * "/testcompile/greek.a"
    @test isfile(expected)

    rm(d * "/testcompile/", recursive=true)
end
