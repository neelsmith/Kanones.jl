
@testset "Read rules for verb tokens from delimited text" begin
    #Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice

    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|3rd|singular|present|indicative|active"
    verbparser = Kanones.VerbIO("verbs")
    rule = Kanones.readrulerow(verbparser, cexsrc)
    @test rule.ruleid |> string == "verbinfl.wreg3rd1"
    @test rule.stemclass == "w_regular"
    @test rule.ending == "ει"
    @test rule.vperson == "3rd"
    @test rule.vnumber == "singular"
    @test rule.vtense == "present"
    @test rule.vmood == "indicative"
    @test rule.vvoice == "active"
end


@testset "Read stems for verb tokens from delimited text"  begin    
    #Rule|LexicalEntity|StemClass|Stem|
    cexsrc = "verbstems.n56496|lexent.n56496|κελευ|w_regular|"
    verbparser = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbparser, cexsrc)
    @test stem.stemid == StemUrn("verbstems.n56496")
    @test stem.lexid == LexemeUrn("lexent.n56496")
    @test stem.stem == "κελευ"
    @test stem.stemclass == "w_regular"

end
