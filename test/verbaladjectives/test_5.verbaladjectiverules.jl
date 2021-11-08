@testset "Test citable trait for VerbalAdjectiveRule" begin
    cexsrc = "vadjinfl.econtr1|ew_contract|ητέον|neuter|nominative|singular|"
    vadjio = Kanones.VerbalAdjectiveIO("verbal adjective")
    rule = Kanones.readrulerow(vadjio, cexsrc)

    @test label(rule) == "Verbal adjective inflection rule: ending -ητέον in class ew_contract can be neuter nominative singular."
    @test urn(rule) == RuleUrn("vadjinfl.econtr1")
    @test cex(rule) == "vadjinfl.econtr1|Verbal adjective inflection rule: ending -ητέον in class ew_contract can be neuter nominative singular."

    dict = Dict(
       "vadjinfl" => "urn:cite2:kanones:vadjinfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:vadjinfl.v1:econtr1")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:vadjinfl.v1:econtr1|Verbal adjective inflection rule: ending -ητέον in class ew_contract can be neuter nominative singular."

end