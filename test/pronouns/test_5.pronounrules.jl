@testset "Test citable trait for PronounRule" begin
    cexsrc = "pronounrules.pronouns1|article"
    pronounio = Kanones.PronounIO("pronouns")
    rule = Kanones.readrulerow(pronounio, cexsrc)

    @test label(rule) == "Pronoun inflection rule: type of stem pronounrules.pronouns1 is article"

    @test urn(rule) == RuleUrn("pronounrules.pronouns1")
    @test cex(rule) == "pronounrules.pronouns1|Pronoun inflection rule: type of stem pronounrules.pronouns1 is article"

    dict = Dict(
       "pronounrules" => "urn:cite2:kanones:pronounrules.v1:"
       )
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:kanones:pronounrules.v1:pronouns1")
    @test cex(rule; registry = dict) == "urn:cite2:kanones:pronounrules.v1:pronouns1|Pronoun inflection rule: type of stem pronounrules.pronouns1 is article"

end

@testset "Test parsing a RuleUrn from a PronounStem" begin
    cexsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounio = Kanones.PronounIO("pronouns")
    stem = Kanones.readstemrow(pronounio, cexsrc)

    @test ruleurn(stem) == RuleUrn("morphforms.9010001100")
end