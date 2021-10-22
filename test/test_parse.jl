
@testset "Build parser and get SFST output" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl")])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d , "testcompile"))
    @test isfile(parser.sfstpath)

    fstout = Kanones.applyparser("και", parser)
    lines = split(fstout, "\n")
    @test lines[1] == "> και"
    expecteddata = "<u>uninflectedstems.n51951</u><u>lsj.n51951</u>και<uninflected><conjunction><div><conjunction><uninflected><u>litgreek.indeclinable2</u>"
    @test lines[2] == expecteddata

    rm(joinpath(d, "testcompile"), recursive=true)
end


@testset "Build parser and get Analysis object" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl")])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))
    analysislist = parsetoken( "και", parser)

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


    ucanalysis = Kanones.parsetoken("Και", parser)
    @test ucanalysis == analysislist

end

@testset "Build parser and handle bad output to parser" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl")])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))
    analyzed = parsetoken( "silly", parser)
    @test isempty(analyzed)
end

@testset "Build parser and test form of resulting analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets","core-infl")])
    fst =  joinpath(repo, "fst")
    parser = FstBuilder.buildparser(kd,fst, joinpath(d, "testcompile"))
    analyzed = parsetoken( "γνώμαις", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)

end