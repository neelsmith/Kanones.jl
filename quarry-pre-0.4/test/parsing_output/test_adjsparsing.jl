@testset ExtendedTestSet "Test resulting values in adjective analysis" begin
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

    tkn = "καλός"
    analyzed = parsetoken( tkn, parser)
    parse1 = analyzed[1]
    @test isa(parse1, Analysis)
    @test parse1.token == "καλος"
    @test parse1.lexeme == LexemeUrn("lsj.n52840")
    @test parse1.form == FormUrn("$(COLLECTION_ID).7010001110")
    @test parse1.stem == StemUrn("adjstems.n52840a")
    @test parse1.rule == RuleUrn("adjinfl.os_h_on_pos1")
end

@testset ExtendedTestSet "Test parsing irregular adjectives" begin
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
    tkn = "πᾶς"
    analyzed = parsetoken(tkn, parser)
    parse1 = analyzed[1]
    @test isa(parse1, Analysis)
    @test parse1.token == "πας"
    @test parse1.lexeme == LexemeUrn("lsj.n79904")
    @test_broken parse1.form == FormUrn("no.no")
    @test parse1.stem == StemUrn("irregadj.n79904a")
    @test parse1.rule == RuleUrn("litgreek.irregular1")
end