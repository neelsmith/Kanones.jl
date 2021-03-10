
@testset "Build parser and get SFST output" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    @test isfile(parser)

    fstout = Kanones.applyparser(parser, "και")
    lines = split(fstout, "\n")
    @test lines[1] == "> και"
    expecteddata = "<u>uninflectedstems.uninf2</u><u>lsj.n51951</u>και<uninflected><conjunction><div><conjunction><uninflected><u>litgreek.indeclinable2</u>"
    @test lines[2] == expecteddata
    rm(d * "/testcompile/", recursive=true)
end


@testset "Build parser and get Analysis object" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "και")
    println(analyzed)
end



@testset "Build parser and handle bad output to parser" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "silly")
    @test isnothing(analyzed)
end