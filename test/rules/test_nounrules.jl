@testset "Test IO with delimited text" begin
    delimited = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular|"
    nounio = Kanones.NounIO("IO for nouns")
    rule = Kanones.readrulerow(nounio, delimited)
    # must read from delimited
    @test rule isa NounRule
    # must write to delimited
   @test cex(rule) == "nouninfl.os_ou1|Noun inflection rule: ending -ος in class os_ou can be masculine nominative singular.|ος|os_ou|forms.2010001100"
end


@testset "Test data accessors" begin
    delimited = "nouninfl.os_ou1|os_ou|ος|masculine|nominative|singular|"
    nounio = Kanones.NounIO("IO for nouns")
    rule = Kanones.readrulerow(nounio, delimited)

    # must get id
    ruleu = ruleurn(rule)
    expectedurn = RuleUrn("nouninfl.os_ou1")
    @test ruleu == expectedurn

    # must get infltype and ending
    @test inflectionClass(rule) == "os_ou"
    @test ending(rule) == "ος"

    # morphological data
    formabbr = formurn(rule)
    expectedabbr = FormUrn("forms.2010001100")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "2010001100"
    @test formcode == expectedcode
end
