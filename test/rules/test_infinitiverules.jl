@testset "Test IO with delimited text for infinitives" begin
    delimited = "infinfl.wreg1|w_regular|ειν|present|active"
    rule = fromcex(delimited, InfinitiveRule)
    # must read from delimited
    @test rule isa InfinitiveRule
    # must write to delimited
   @test cex(rule) == Unicode.normalize("infinfl.wreg1|w_regular|ειν|present|active")

   @test fromcex(cex(rule), InfinitiveRule) == rule
end



@testset "Test data accessors for infinitives" begin
   
    delimited = "infinfl.wreg1|w_regular|ειν|present|active"
    rule = fromcex(delimited, InfinitiveRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("infinfl.wreg1")
    @test ruleu == expectedurn


    dict = Dict("infinfl" => "urn:cite2:kanones:infinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:infinfl.v1:wreg1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "w_regular"
    @test ending(rule) == "ειν"

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.4001010000")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "4001010000"
    @test formcode == expectedcode
end
