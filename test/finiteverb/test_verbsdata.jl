
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


@testset "Read stems for noun tokens from delimited text"  begin    
    #Rule|LexicalEntity|StemClass|Stem|

    cex = "verbstems.n56496|lexent.n56496|κελευ|w_regular|"
    verbparser = Kanones.VerbParser("verbs")
    stemrow = Kanones.readstemrow(verbparser, cex)
    @test stemrow.stemid == "verbstems.n56496"
    @test stemrow.lexid == LexemeUrn("lexent.n56496")
    @test stemrow.stem == "κελευ"
    @test stemrow.stemclass == "verbstems.w_regular"

end
