@testset "Read rules for infinitives from delimited text" begin
    cex = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveRuleParser("infinitives")
    rulerow = Kanones.readrulerow(infinparser, cex)
    rulerow.ruleid |> string == "infinfl.wreg1"

    @test rulerow.inflectionclass == "w_regular"
    @test rulerow.ending == "ειν"
    @test rulerow.tense == "present"
    @test rulerow.voice == "active"
end