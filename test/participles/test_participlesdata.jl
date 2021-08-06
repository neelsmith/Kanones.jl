@testset "Read rules for infinitives from delimited text" begin
    cex = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpclparser = Kanones.ParticipleRuleParser("participles")
    rulerow = Kanones.readrulerow(ptpclparser, cex)

    rulerow.ruleid |> abbreviation == "ptcplinfl.wpres11p"

    @test rulerow.inflectionclass == "w_regular"
    @test rulerow.ending == "όμενον"
    @test rulerow.ptense == "present"
    @test rulerow.pvoice == "middle"
    @test rulerow.pgender == "neuter"
    @test rulerow.pcase == "nominative"
    @test rulerow.pnumber == "singular"
end