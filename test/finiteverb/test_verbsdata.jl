
@testset "Read rules for verb tokens from delimited text" begin
    #Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice

    cex = "verbinfl.wreg3rd1|w_regular|ει|3rd|singular|present|indicative|active"
    verbparser = Kanones.VerbParser("verbs")
    rulerow = Kanones.readrulerow(verbparser, cex)
    @test rulerow.ruleid |> abbreviation == "verbinfl.wreg3rd1"
    @test rulerow.stemclass == "w_regular"
    @test rulerow.ending == "ει"
    @test rulerow.vperson == "3rd"
    @test rulerow.vnumber == "singular"
    @test rulerow.vtense == "present"
    @test rulerow.vmood == "indicative"
    @test rulerow.vvoice == "active"
end