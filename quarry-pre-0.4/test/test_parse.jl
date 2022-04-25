
@testset ExtendedTestSet "Build parser and get SFST output" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl")])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)
    @test isfile(parser.sfstpath)

    fstout = Kanones.applyparser("και", parser)
    lines = split(fstout, "\n")
    @test lines[1] == "> και"
    expecteddata = "<u>uninflectedstems.n51951</u><u>lsj.n51951</u>και<uninflected><conjunction><div><conjunction><uninflected><u>litgreek.indeclinable2</u>"
    @test lines[2] == expecteddata

    rm(joinpath(d, "testcompile"), recursive=true)
end


@testset ExtendedTestSet "Build parser and get Analysis object" begin
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

    psg = CitablePassage(CtsUrn("urn:cts:greekLit:tlg4036.tlg023.normed:Homer.title.1"), "Καὶ")
    psgs = [psg]
    psgparses =  Kanones.parsepassagelist(psgs, parser)
    tinycorpus = CitableTextCorpus(psgs)
    corpusparses =  parsecorpus(tinycorpus, parser)
    @test psgparses[1].analyses[1] == corpusparses[1].analyses[1]
    #doc = documents(tinycorpus)[1]
    #docparses = parsedocument(doc, parser)
    #@test psgparses[1].analyses[1] == docparses[1].analyses[1]


end

@testset ExtendedTestSet "Build parser and handle bad output to parser" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets", "core-infl")])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)
    analyzed = parsetoken( "silly", parser)
    @test isempty(analyzed)
end

@testset ExtendedTestSet "Build parser and test form of resulting analysis" begin
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([joinpath(repo, "datasets","core-infl")])
    fst =  joinpath(repo, "fst")
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser = FstBuilder.buildparser(kd,fst, fullpath)

    analyzed = parsetoken( "γνώμαις", parser)
    @test length(analyzed) == 1
    @test isa(analyzed[1], Analysis)

end