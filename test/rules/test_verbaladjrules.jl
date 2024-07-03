@testset "Test IO with delimited text" begin
    delimited = "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular|"
    rule = fromcex(delimited, VerbalAdjectiveRule)
    # must read from delimited
    @test rule isa VerbalAdjectiveRule
    # must write to delimited
   @test cex(rule) == "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular"

   
   @test fromcex(cex(rule), VerbalAdjectiveRule) == rule

end


@testset "Test data accessors" begin
    delimited = "vadjinfl.wreg1|w_regular|τέον|neuter|nominative|singular|"
    rule = fromcex(delimited, VerbalAdjectiveRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("vadjinfl.wreg1")
    @test ruleu == expectedurn


    dict = Dict("vadjinfl" => "urn:cite2:kanones:vadjinfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:vadjinfl.v1:wreg1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == "w_regular"
    @test ending(rule) == "τέον"

    # morphological data
    formabbr = Kanones.formurn(rule)
    expectedabbr = FormUrn("forms.6010003100")
    @test formabbr == expectedabbr

    formcode = code(rule)
    expectedcode = "6010003100"
    @test formcode == expectedcode
end
