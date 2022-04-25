@testset ExtendedTestSet "Read rules for participle tokens from delimited text" begin
    cexsrc = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpcplio = Kanones.ParticipleIO("participles")
    rule = Kanones.readrulerow(ptpcplio, cexsrc)

    rule.ruleid |> string == "ptcplinfl.wpres11p"

    @test rule.inflectionclass == "w_regular"
    @test rule.ending == "όμενον"
    @test rule.ptense == GMPTense(1)
    @test rule.pvoice == GMPVoice(2)
    @test rule.pgender == GMPGender(3)
    @test rule.pcase == GMPCase(1)
    @test rule.pnumber == GMPNumber(1)
end