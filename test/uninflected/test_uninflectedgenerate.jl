@testset "Test converting form information in UninflectedRule to an abbreviated URN" begin
    rule = UninflectedRule(CitableParserBuilder.RuleUrn("litgreek.indeclinable1"), "particle")    
    expected = FormUrn("morphforms.1000000003")
    @test Kanones.ruleurn(rule) == expected
end


@testset "Test generating fully accented inflected form" begin
    nothing
end