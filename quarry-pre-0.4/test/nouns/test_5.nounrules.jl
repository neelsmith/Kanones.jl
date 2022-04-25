@testset "Test citable trait for NounRule" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounio = Kanones.NounIO("nouns")
    rule =  Kanones.readrulerow(nounio, cexsrc)

    @test label(rule) == "Noun inflection rule: ending -ης in class h_hs can be feminine genitive singular."
    @test urn(rule) == RuleUrn("nouninfl.h_hs2")
    @test cex(rule) == "nouninfl.h_hs2|Noun inflection rule: ending -ης in class h_hs can be feminine genitive singular."

    dict = Dict(
       "nouninfl" => "urn:cite2:kanones:nouninfl.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:nouninfl.v1:h_hs2")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:nouninfl.v1:h_hs2|Noun inflection rule: ending -ης in class h_hs can be feminine genitive singular."

end

@testset "Test parsing a RuleUrn from a NounRule" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounIO("nouns")
    rule = Kanones.readrulerow(nounparser, cexsrc)

    @test ruleurn(rule) == RuleUrn("morphforms.2010002200")
end