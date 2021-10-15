@testset "Read rules for infinitives from delimited text" begin
    cex = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjparser = Kanones.VerbalAdjectiveRuleParser("verbal adjective")
    rulerow = Kanones.readrulerow(vadjparser, cex)
    rulerow.ruleid |> string == "vadjinfl.econtr1"

    @test rulerow.inflectionclass == "ew_contract"
    @test rulerow.ending == "ητέον"
    @test rulerow.vagender == "neuter"
    @test rulerow.vacase == "nominative"
    @test rulerow.vanumber == "singular"
end