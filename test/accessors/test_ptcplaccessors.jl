@testset ExtendedTestSet "Test accessing adjective form properties" begin
    ptcpl = GMFParticiple(gmpTense("present"), gmpVoice("active"), gmpGender("feminine"), gmpCase("dative"), gmpNumber("singular"))
    @test gmpGender(ptcpl) == GMPGender(2)
    @test gmpCase(ptcpl) == GMPCase(3)
    @test gmpNumber(ptcpl) == GMPNumber(1)
    @test gmpTense(ptcpl) == GMPTense(1)
    @test gmpVoice(ptcpl) == GMPVoice(1)
end

@testset ExtendedTestSet "Test accessing adjective rule properties" begin
    cexsrc = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpcplio = Kanones.ParticipleIO("participles")
    rule = Kanones.readrulerow(ptpcplio, cexsrc)
    @test gmpGender(rule) == GMPGender(3)
    @test gmpCase(rule) == GMPCase(1)
    @test gmpNumber(rule) == GMPNumber(1)
    @test gmpTense(rule) == GMPTense(1)
    @test gmpVoice(rule) == GMPVoice(2)
end
