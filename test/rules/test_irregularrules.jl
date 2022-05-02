
@testset "Test IO with delimited text" begin
    delimited = "irreginfl.irregular1|irregularnoun"
    irregruleio = Kanones.IrregularRuleParser("IO for irregular rules")
    rule = Kanones.readrulerow(irregruleio, delimited)
    # must read from delimited
    @test rule isa IrregularRule
    # must write to delimited
   @test cex(rule) == "irreginfl.irregular1|Uninflected rule: irreginfl.irregular1 applies to type irregularnoun.|irregularnoun"
end


@testset "Test data accessors" begin
    delimited = "irreginfl.irregular1|irregularnoun"
    irregruleio = Kanones.IrregularRuleParser("IO for irregular rules")
    rule = Kanones.readrulerow(irregruleio, delimited)

    # must get id
    ruleu = ruleurn(rule)
    expectedurn = RuleUrn("irreginfl.irregular1")
    @test ruleu == expectedurn

    dict = Dict("irreginfl" => "urn:cite2:kanones:irreginfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irreginfl.v1:irregular1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionClass(rule) == "irregularnoun"
    @test isempty(ending(rule))
end
