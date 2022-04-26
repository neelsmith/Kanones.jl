@testset "Test citable trait for UninflectedRule" begin
    cexsrc = "uninflectedrules.indeclinable2|conjunction"
    uninfl = Kanones.UninflectedIO("uninflected")
    rule = Kanones.readrulerow(uninfl, cexsrc)

    @test label(rule) == "Uninflected rule: uninflectedrules.indeclinable2 indicates a conjunction."
    @test urn(rule) == RuleUrn("uninflectedrules.indeclinable2")
    @test cex(rule) == "uninflectedrules.indeclinable2|Uninflected rule: uninflectedrules.indeclinable2 indicates a conjunction."

    dict = Dict(
       "uninflectedrules" => "urn:cite2:kanones:uninflectedrules.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:uninflectedrules.v1:indeclinable2")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:uninflectedrules.v1:indeclinable2|Uninflected rule: uninflectedrules.indeclinable2 indicates a conjunction."

end

@testset "Test parsing a RuleUrn from an UninflectedStem" begin
    cexsrc = "uninflectedstems.uninf2|lsj.n51951|καί|conjunction|"
    uninfl = Kanones.UninflectedIO("uninflected")
    stem = Kanones.readstemrow(uninfl, cexsrc)

    @test ruleurn(stem) == RuleUrn("$(COLLECTION_ID).1000000001")
end