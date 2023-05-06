@testset "Test IO with delimited text" begin
    vadjio = Kanones.VerbalAdjectiveIO("adjectives")
    delimited = "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular|"
    rule = Kanones.readrulerow(vadjio, delimited)
    # must read from delimited
    @test rule isa VerbalAdjectiveRule
    # must write to delimited
   @test cex(rule) == "vadjinfl.wreg1|Verbal adjective inflection rule: ending -τέον in class w_regular can be neuter nominative singular.|τέον|w_regular|forms.6010003100"
end

@testset "Test data accessors" begin
    vadjio = Kanones.VerbalAdjectiveIO("adjectives")
    delimited = "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular|"
    rule = Kanones.readrulerow(vadjio, delimited)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("vadjinfl.wreg1")
    @test ruleu == expectedurn


    dict = Dict("vadjinfl" => "urn:cite2:kanones:vadjinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:vadjinfl.v1:wreg1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionClass(rule) == "w_regular"
    @test ending(rule) == "τέον"

    # morphological data
    formabbr = formurn(rule)
    expectedabbr = FormUrn("forms.6010003100")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "6010003100"
    @test formcode == expectedcode
end
