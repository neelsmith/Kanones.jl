@testset "Test resulting values in verb analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl"), joinpath(repo, "datasets", "core-vocab")])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)

    analyzed = parsetoken("κελευσει", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#κελευσει"


    analyzed = parsetoken("γιγνεται", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#γιγνεται"


    analyzed = parsetoken("δεικνυσι", parser)
    @test_broken length(analyzed) == 1
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "#δεικνυσι"

    analyzed = parsetoken("δειξεται", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#δειξεται"

    analyzed = parsetoken("δεδειχε", parser)
    @test_broken length(analyzed) == 1
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "#δεδειχε"

    analyzed = parsetoken("δειχθησεται", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#δειχθησεται"

    analyzed = parsetoken("γενησοιτο", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#γενησοιτο"

    analyzed = parsetoken("γενοιτο", parser)
    @test_broken length(analyzed) == 1
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "#γενοιτο"

    analyzed = parsetoken("γεγονε", parser)
    @test_broken length(analyzed) == 1
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "γεγονε"

    analyzed = parsetoken("γεγενηται", parser )
    @test_broken length(analyzed) == 2
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "γεγενηται"

    analyzed = parsetoken("γενηθησεται", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#γενηθησεται"


    analyzed = parsetoken("ποιειται", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#ποιειται"


    analyzed = parsetoken("πραττεται", parser)
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "#πραττεται"

    analyzed = parsetoken("πεπρακται", parser )
    @test_broken length(analyzed) == 2
    @test_broken isa(analyzed[1], Analysis)
    @test_broken analyzed[1].token == "πεπρακται"

    analyzed = parsetoken("ἐκελευε", parser )
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    #@test_broken analyzed[1].token == "ἐκελευε"
end