@testset "Test IO with delimited text" begin
    delimited = "proninfl.pronouns1|article"
    rule = fromcex(delimited, PronounRule)
    # must read from delimited
    @test rule isa PronounRule
    # must write to delimited
   @test cex(rule) == "proninfl.pronouns1|article"
   @test fromcex(cex(rule), PronounRule) == rule
end


@testset "Test data accessors" begin
    delimited = "proninfl.pronouns1|article"
    rule = fromcex(delimited, PronounRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("proninfl.pronouns1")
    @test ruleu == expectedurn

    dict = Dict("proninfl" => "urn:cite2:kanones:proninfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:proninfl.v1:pronouns1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "article"
    @test isempty(ending(rule))
end
