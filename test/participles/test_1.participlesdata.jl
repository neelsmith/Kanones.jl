@testset "Read rules for participle tokens from delimited text" begin
    cexsrc = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpcplio = Kanones.ParticipleIO("participles")
    rule = Kanones.readrulerow(ptpcplio, cexsrc)

    rule.ruleid |> string == "ptcplinfl.wpres11p"

    @test rule.inflectionclass == "w_regular"
    @test rule.ending == "όμενον"
    @test rule.ptense == "present"
    @test rule.pvoice == "middle"
    @test rule.pgender == "neuter"
    @test rule.pcase == "nominative"
    @test rule.pnumber == "singular"
end