@testset "Test IO with delimited text" begin
    infio = Kanones.InfinitiveIO("infs")
    delimited = "infinfl.wreg1|w_regular|ειν|present|active"
    rule = Kanones.readrulerow(infio, delimited)
    # must read from delimited
    @test rule isa InfinitiveRule
    # must write to delimited
   @test cex(rule) == "infinfl.wreg1|Infinitive inflection rule: ending -ειν in class w_regular can be present active.|ειν|w_regular|forms.4001010000"
end


@testset "Test data accessors" begin
    infio = Kanones.InfinitiveIO("infs")
    delimited = "infinfl.wreg1|w_regular|ειν|present|active"
    rule = Kanones.readrulerow(infio, delimited)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("infinfl.wreg1")
    @test ruleu == expectedurn


    dict = Dict("infinfl" => "urn:cite2:kanones:infinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:infinfl.v1:wreg1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionClass(rule) == "w_regular"
    @test ending(rule) == "ειν"

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.4001010000")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "4001010000"
    @test formcode == expectedcode
end
