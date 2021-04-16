
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
    expecteddata = "<u>uninflectedstems.n51951</u><u>lsj.n51951</u>και<uninflected><conjunction><div><conjunction><uninflected><u>litgreek.indeclinable2</u>"
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
    analysislist = parsetoken(parser, "και")

    analyzed = analysislist[1]

    expectedlex = LexemeUrn("lsj.n51951")
    @test analyzed.lexeme.collection == expectedlex.collection
    @test analyzed.lexeme.objectid == expectedlex.objectid

    expectedform = FormUrn("morphforms.1000000001")
    @test analyzed.form.collection == expectedform.collection
    @test analyzed.form.objectid == expectedform.objectid


    expectedstem = StemUrn("uninflectedstems.n51951")
    @test analyzed.stem.collection == expectedstem.collection
    @test analyzed.stem.objectid == expectedstem.objectid


    expectedrule = RuleUrn("litgreek.indeclinable2")
    @test analyzed.rule.collection == expectedrule.collection
    @test analyzed.rule.objectid == expectedrule.objectid

end

@testset "Build parser and handle bad output to parser" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "silly")
    @test isempty(analyzed)
end



@testset "Build parser and test form of resulting analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset(repo * "/datasets/synoptic/")
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")

    parser = d * "/testcompile/greek.a"
    analyzed = parsetoken(parser, "γνώμαις")
    @test isa(analyzed[1], Analysis)

end