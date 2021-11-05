@testset "Test converting NounRule to abbreviated URN for form" begin
    rule = NounRule(CitableParserBuilder.RuleUrn("nouninfl.os_ou19"), "os_ou", "α", "neuter", "accusative", "singular")
    form = Kanones.ruleurn(rule)
    expected = RuleUrn("morphforms.2010003400")
    @test  form == expected
end


@testset "Build parser and parse noun forms" begin
    
    d = tempdir()
    repo = dirname(pwd())

    kd = Kanones.Dataset([repo * "/datasets/core-infl/"])
    fst =  repo * "/fst/"
    FstBuilder.buildparser(kd,fst, d * "/testcompile/")
    
    parser = d * "/testcompile/greek.a"
    
    ##analyzed = parsetoken(parser, "γνωμαις")
    #println(analyzed)
    #FstBuilder.applyparser(parser, stripped)
end