@testset "Test resulting values in verb analysis" begin
    d = tempdir()
    repo = dirname(pwd())
#=
    kd = Kanones.Dataset([repo * "/datasets/synoptic/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "κελευσει")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "κελευσει"


    analyzed = parsetoken(parser, "γιγνεται")
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γιγνεται"


    analyzed = parsetoken(parser, "δεικνυσι")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "δεικνυσι"

    analyzed = parsetoken(parser, "δειξεται")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "δειξεται"

    analyzed = parsetoken(parser, "δεδειχε")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "δεδειχε"

    analyzed = parsetoken(parser, "δειχθησεται")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "δειχθησεται"

    analyzed = parsetoken(parser, "γενησοιτο")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γενησοιτο"

    analyzed = parsetoken(parser, "γενοιτο")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γενοιτο"

    analyzed = parsetoken(parser, "γεγονε")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γεγονε"

    analyzed = parsetoken(parser, "γεγενηται")
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γεγενηται"

    analyzed = parsetoken(parser, "γενηθησεται")
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "γενηθησεται"


    analyzed = parsetoken(parser, "ποιειται")
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "ποιειται"


    analyzed = parsetoken(parser, "πραττεται")
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "πραττεται"

    analyzed = parsetoken(parser, "πεπρακται")
    @test length(analyzed) == 2
    @test isa(analyzed[1], Analysis)
    @test analyzed[1].token == "πεπρακται"
    =#



    repo = dirname(pwd())
    kd = Kanones.Dataset([  repo * "/datasets/debug/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst,repo* "/parsers/debugkanones/")
    parser =  repo * "/parsers/debugkanones/greek.a"
    analyzed = parsetoken(parser, "ἐκελευε")
    @test_broken length(analyzed) == 1
end