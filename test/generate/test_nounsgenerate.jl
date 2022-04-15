@testset ExtendedTestSet "Test converting NounRule to abbreviated URN for form" begin
    rule = NounRule(CitableParserBuilder.RuleUrn("nouninfl.os_ou19"), "os_ou", "α", gmpGender("neuter"), gmpCase("accusative"), gmpNumber("singular"))
    form = Kanones.formurn(rule)
    expected = FormUrn("morphforms.2010003400")
    @test  form == expected
end


@testset ExtendedTestSet "Build parser, and generated parsed noun forms" begin
    d = tempdir()
    repo = dirname(pwd())
    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"
    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    parser  = FstBuilder.buildparser(kd,fst, fullpath)
    s = "γνώμας"
    analyzed = parsetoken(s, parser)
    
    lex = analyzed[1].lexeme
    mform = analyzed[1].form
    fromform = generate(mform, lex, kd)
    @test length(fromform) == 1
    @test fromform[1] == nfkc(s)

    fromanalysis = generate(analyzed[1], kd)
    @test fromanalysis == fromform

end