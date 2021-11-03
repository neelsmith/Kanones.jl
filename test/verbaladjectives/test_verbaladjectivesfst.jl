@testset "Format fst rules for participle forms" begin
    cex = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjparser = Kanones.VerbalAdjectiveRuleParser("verbal adjective")
    rulerow = Kanones.readrulerow(vadjparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<ew_contract><verbaladjective>ητεον<neuter><nominative><singular><u>vadjinfl\\.econtr1</u>"
    @test FstBuilder.fst(rulerow) == expected
end