@testset "Test IO with delimited text for nouns" begin
   
    delimited = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular"
    rule = fromcex(delimited, NounRule)
    # must read from delimited
    @test rule isa NounRule
    # must write to delimited
   @test cex(rule) == "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular"
end


@testset "Test data accessors for nouns" begin
    delimited = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular"
    rule = fromcex(delimited, NounRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("nouninfl.os_ou1")
    @test ruleu == expectedurn

    dict = Dict("nouninfl" => "urn:cite2:kanones:nouninfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:nouninfl.v1:os_ou1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "os_ou"
    @test ending(rule) == "ος"

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.2010001100")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "2010001100"
    @test formcode == expectedcode
end
