@testset ExtendedTestSet "Test citable trait for FiniteVerbRule" begin
    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|third|singular|present|indicative|active"
    verbparser = Kanones.VerbIO("verbs")
    rule = Kanones.readrulerow(verbparser, cexsrc)

    @test label(rule) == "Verb inflection rule: ending -ει in class w_regular can be present indicative active third singular."

    @test urn(rule) == RuleUrn("verbinfl.wreg3rd1")
    @test cex(rule) == "verbinfl.wreg3rd1|Verb inflection rule: ending -ει in class w_regular can be present indicative active third singular."

    dict = Dict(
       "verbinfl" => "urn:cite2:kanones:verbinfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:verbinfl.v1:wreg3rd1")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:verbinfl.v1:wreg3rd1|Verb inflection rule: ending -ει in class w_regular can be present indicative active third singular."

end

@testset ExtendedTestSet "Test parsing a RuleUrn from a FiniteVerbRule" begin
    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|third|singular|present|indicative|active"
    verbparser = Kanones.VerbIO("verbs")
    rule = Kanones.readrulerow(verbparser, cexsrc)
    @test ruleurn(rule) == RuleUrn("$(COLLECTION_ID).3311110000")
end