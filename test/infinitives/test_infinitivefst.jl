@testset "Format fst rules for infinitve forms" begin
    cex = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveRuleParser("infinitives")
    rulerow = Kanones.readrulerow(infinparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<w_regular><infinitive>ειν<present><active><u><u>infinfl\\.wreg1</u></u>"
    @test FstBuilder.fst(rulerow, literaryGreek()) == expected
end