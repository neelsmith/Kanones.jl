
@testset "Read rules for irregulars tokens from delimited text" begin
    cex = "litgreek.irregular1|irregularnoun"
    uninfl = Kanones.IrregularRuleParser("irregular rules")
    rulerow = Kanones.readrulerow(uninfl, cex)
    @test rulerow.inflectionclass == "irregularnoun"
    expectedrule = RuleUrn("litgreek.irregular1")
    @test rulerow.ruleid == expectedrule
end