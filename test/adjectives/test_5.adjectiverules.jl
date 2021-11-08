@testset "Test citable trait for AdjectiveRule" begin
    cexsrc = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, cexsrc)

    @test label(rule) == "Adjective inflection rule: ending -ος in class os_h_on_pos can be masculine nominative singular positive."
    @test urn(rule) == RuleUrn("adjinfl.oshon_pos1")
    @test cex(rule) == "adjinfl.oshon_pos1|Adjective inflection rule: ending -ος in class os_h_on_pos can be masculine nominative singular positive."

    dict = Dict(
       "adjinfl" => "urn:cite2:kanones:adjinfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:adjinfl.v1:oshon_pos1")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:adjinfl.v1:oshon_pos1|Adjective inflection rule: ending -ος in class os_h_on_pos can be masculine nominative singular positive."

end