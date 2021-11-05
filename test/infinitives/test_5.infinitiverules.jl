@testset "Test citable trait for InfinitiveRule" begin
    cexsrc = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rule = Kanones.readrulerow(infinparser, cexsrc)
    @test label(rule) == "Infinitive inflection rule: ending -ειν in class w_regular can be present active."
    @test urn(rule) == RuleUrn("infinfl.wreg1")
    @test cex(rule) == "infinfl.wreg1|Infinitive inflection rule: ending -ειν in class w_regular can be present active."

    dict = Dict(
       "infinfl" => "urn:cite2:kanones:infinfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:infinfl.v1:wreg1")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:infinfl.v1:wreg1|Infinitive inflection rule: ending -ειν in class w_regular can be present active."
end