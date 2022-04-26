@testset "Test IO with delimited text" begin
    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, delimited)
    # must read from delimited
    @test rule isa AdjectiveRule
    # must write to delimited
   @test cex(rule) == "adjinfl.osaon1|Adjective inflection rule: ending -ος in class os_a_on can be masculine nominative singular positive.|ος|os_a_on|forms.7010001110"
end

@testset "Test data accessors" begin
    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, delimited)

    # must get id
    ruleu = ruleurn(rule)
    expectedurn = RuleUrn("adjinfl.osaon1")
    @test ruleu == expectedurn

    # must get infltype and ending
    @test inflectionClass(rule) == "os_a_on"
    @test ending(rule) == "ος"

    # morphological data
    formabbr = formurn(rule)
    expectedabbr = FormUrn("forms.7010001110")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "7010001110"
    @test formcode == expectedcode
end