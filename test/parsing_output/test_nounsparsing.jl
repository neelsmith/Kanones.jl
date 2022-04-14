@testset "Test resulting values in noun analysis" begin
    d = tempdir()
    repo = dirname(pwd())
    infl = joinpath(repo, "datasets", "core-infl")
    vocab = joinpath(repo, "datasets", "core-vocab")
    kd = Kanones.Dataset([infl, vocab])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)

    analyzed = parsetoken( "γνώμαις", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γνωμαις"
end


@testset "Test resulting values in irregular noun analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl"),
    joinpath(repo, "datasets", "core-vocab")])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)

    analyzed = parsetoken( "γυνή", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == nfkc("γυνη")
end