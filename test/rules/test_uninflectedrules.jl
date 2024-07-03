@testset "Test IO with delimited text for uninflected forms" begin
    delimited = "uninfl.uninfl2|conjunction"
    rule = fromcex(delimited, UninflectedRule)
    # must read from delimited
    @test rule isa UninflectedRule
    # must write to delimited
   @test cex(rule) == "uninfl.uninfl2|conjunction"

   @test fromcex(cex(rule), UninflectedRule) == rule
end


@testset "Test data accessors for uninflected form" begin
    delimited = "uninfl.uninfl2|conjunction"
    rule = fromcex(delimited, UninflectedRule)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("uninfl.uninfl2")
    @test ruleu == expectedurn

    dict = Dict("uninfl" => "urn:cite2:kanones:uninfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:uninfl.v1:uninfl2")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionclass(rule) == gmpUninflectedType("conjunction")
    #@test isempty(ending(rule))
end

