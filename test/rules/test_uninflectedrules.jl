@testset "Test IO with delimited text" begin
    delimited = "uninfl.uninfl2|conjunction"
    uninflio = Kanones.UninflectedIO("IO for uninfls")
    rule = Kanones.readrulerow(uninflio, delimited)
    # must read from delimited
    @test rule isa UninflectedRule
    # must write to delimited
   @test cex(rule) == "uninfl.uninfl2|Uninflected rule: uninfl.uninfl2 indicates a conjunction.|conjunction"
end

#=
@testset "Test data accessors" begin
    delimited = "proninfl.pronouns1|article"
    pronio = Kanones.PronounIO("IO for pronouns")
    rule = Kanones.readrulerow(pronio, delimited)

    # must get id
    ruleu = ruleurn(rule)
    expectedurn = RuleUrn("proninfl.pronouns1")
    @test ruleu == expectedurn

    dict = Dict("proninfl" => "urn:cite2:kanones:proninfl.v1:")
    expectedcite2 = Cite2Urn("urn:cite2:kanones:proninfl.v1:pronouns1")
    @test urn(rule) == expectedurn
    @test urn(rule, registry = dict) == expectedcite2

    # must get infltype and ending
    @test inflectionClass(rule) == "article"
    @test isempty(ending(rule))
end

=#