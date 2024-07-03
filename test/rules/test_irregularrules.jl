
@testset "Test IO with delimited text for irregular forms" begin
    delimited = "irreginfl.irregular1|irregularnoun"
    rule = fromcex(delimited, IrregularRule)
    # must read from delimited
    @test rule isa IrregularRule
    # must write to delimited
   @test cex(rule) == Unicode.normalize("irreginfl.irregular1|irregularnoun")
end


@testset "Test data accessors for irregular forms" begin
    delimited = "irreginfl.irregular1|irregularnoun"
    rule = fromcex(delimited, IrregularRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("irreginfl.irregular1")
    @test ruleu == expectedurn

    dict = Dict("irreginfl" => "urn:cite2:kanones:irreginfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:irreginfl.v1:irregular1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "irregularnoun"
    @test isempty(ending(rule))
end
