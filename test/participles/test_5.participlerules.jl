@testset "Test citable trait for ParticipleRule" begin
    cexsrc = "ptcplinfl.wpres11p|w_regular|όμενον|present|middle|neuter|nominative|singular|"
    ptpcplio = Kanones.ParticipleIO("participles")
    rule = Kanones.readrulerow(ptpcplio, cexsrc)

    @test label(rule) == "Participle inflection rule: ending -όμενον in class w_regular can be present middle neuter nominative singular."
    @test urn(rule) == RuleUrn("ptcplinfl.wpres11p")
    @test cex(rule) == "ptcplinfl.wpres11p|Participle inflection rule: ending -όμενον in class w_regular can be present middle neuter nominative singular."

    dict = Dict(
       "ptcplinfl" => "urn:cite2:kanones:ptcplinfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:ptcplinfl.v1:wpres11p")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:ptcplinfl.v1:wpres11p|Participle inflection rule: ending -όμενον in class w_regular can be present middle neuter nominative singular."

end