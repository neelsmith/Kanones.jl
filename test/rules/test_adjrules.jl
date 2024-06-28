@testset "Test IO with delimited text for adjectives" begin
    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, delimited)
    # must read from delimited
    @test rule isa AdjectiveRule
    # must write to delimited
   @test Unicode.normalize(cex(rule)) == Unicode.normalize("adjinfl.osaon1|Adjective inflection rule: ending -ος in class os_a_on can be masculine nominative singular positive.|ος|os_a_on|forms.7010001110")
end

@testset "Test data accessors for adjectives" begin
    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, delimited)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("adjinfl.osaon1")
    @test ruleu == expectedurn


    dict = Dict("adjinfl" => "urn:cite2:kanones:adjinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:adjinfl.v1:osaon1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "os_a_on"
    @test ending(rule) == Unicode.normalize("ος")

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.7010001110")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "7010001110"
    @test formcode == expectedcode
end


@testset "Test CITE interfaces on adjective rules" begin
    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, delimited)

    @test citable(rule)
    @test label(rule) == "Adjective inflection rule: ending -ος in class os_a_on can be masculine nominative singular positive."
    @test urn(rule) == RuleUrn("adjinfl.osaon1")

    dict = Dict("adjinfl" => "urn:cite2:kanones:adjinfl.v1:")
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:adjinfl.v1:osaon1")
   

    @test cexserializable(rule)

    delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
    rule2 = fromcex(delimited, AdjectiveRule)
    @test rule == rule2


end