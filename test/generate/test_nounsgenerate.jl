@testset "Test converting NounRule to abbreviated URN for form" begin
    rule = NounRule(CitableParserBuilder.RuleUrn("nouninfl.os_ou19"), "os_ou", "α", gmpGender("neuter"), gmpCase("accusative"), gmpNumber("singular"))
    form = Kanones.ruleurn(rule)
    expected = RuleUrn("morphforms.2010003400")
    @test  form == expected
end


@testset "Build parser and parse noun forms" begin
    
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"


    fullpath = joinpath(d, "testcompile")
    if isdir(fullpath)
        rm(fullpath; recursive = true)
    end
    FstBuilder.buildparser(kd,fst, fullpath)

    
    parser = d * "/testcompile/greek.a"
    
    ##analyzed = parsetoken(parser, "γνωμαις")
    #println(analyzed)
    #FstBuilder.applyparser(parser, stripped)
end