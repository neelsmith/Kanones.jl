@testset "Test IO with delimited text" begin
    delimited = "uninfl.uninfl2|conjunction"
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    rule = Kanones.readrulerow(uninflio, delimited)
    # must read from delimited
    @test rule isa UninflectedRule
    # must write to delimited
   @test cex(rule) == "uninfl.uninfl2|Uninflected rule: uninfl.uninfl2 indicates a conjunction.|conjunction"
end


@testset "Test data accessors" begin
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    delimited = "uninfl.uninfl2|conjunction"
    rule = Kanones.readrulerow(uninflio, delimited)

    # must get id
    ruleu = Kanones.ruleurn(rule)
    expectedurn = RuleUrn("uninfl.uninfl2")
    @test ruleu == expectedurn

    dict = Dict("uninfl" => "urn:cite2:kanones:uninfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:uninfl.v1:uninfl2")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test_broken inflectionclass(rule) == gmpUninflectedType("conjunction")
    #@test isempty(ending(rule))
end

