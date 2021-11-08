
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
    cexsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    @test stem.stemid == StemUrn("verbstems.n56496")
    @test stem.lexid == LexemeUrn("lsj.n56496")
    @test stem.stem == "κελευ"
    @test stem.stemclass == "w_regular"

end

@testset "Read stems for irregular verb tokens from delimited text"  begin  
    cexsrc = "irregverb.n110639a|lsj.n110639|φησί|third|singular|present|indicative|active|irregularverb"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    @test_broken stem.stemclass == "irregular"
end