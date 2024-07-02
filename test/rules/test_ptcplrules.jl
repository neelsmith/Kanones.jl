@testset "Test IO with delimited text" begin
    delimited = "ptcplinfl.wpres1|w_regular|όμενος|present|middle|masculine|nominative|singular|"
    rule = fromcex(delimited, ParticipleRule)
    # must read from delimited
    @test rule isa ParticipleRule
    # must write to delimited
   @test cex(rule) == "ptcplinfl.wpres1|w_regular|όμενος|present|middle|masculine|nominative|singular"
   @test fromcex(cex(rule), ParticipleRule) == rule
end


@testset "Test data accessors" begin
    delimited = "ptcplinfl.wpres1|w_regular|όμενος|present|middle|masculine|nominative|singular|"
    rule = fromcex(delimited, ParticipleRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("ptcplinfl.wpres1")
    @test ruleu == expectedurn


    dict = Dict("ptcplinfl" => "urn:cite2:kanones:ptcplinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:ptcplinfl.v1:wpres1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "w_regular"
    @test ending(rule) == "όμενος"

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.5011021100")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "5011021100"
    @test formcode == expectedcode
end

