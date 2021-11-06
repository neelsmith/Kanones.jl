@testset "Format fst rules for participial forms" begin
    cex = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpclparser = Kanones.ParticipleIO("participles")
    rulerow = Kanones.readrulerow(ptpclparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<w_regular><participle>ομενον<present><middle><neuter><nominative><singular><u>ptcplinfl\\.wpres11p</u>"
    @test FstBuilder.fst(rulerow) == expected
end