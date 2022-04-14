
@testset "Read rules for verb tokens from delimited text" begin
    #Rule|StemClass|Ending|Person|Number|Tense|Mood|Voice

    cexsrc = "verbinfl.wreg3rd1|w_regular|ει|third|singular|present|indicative|active"
    verbparser = Kanones.VerbIO("verbs")
    rule = Kanones.readrulerow(verbparser, cexsrc)
    #@test rule == FiniteVerbRule(RuleUrn("verbinfl.wreg3rd1"), "w_regular", "ει", GMPPerson(3), GMPNumber(1), GMPTense(1), GMPMood(1), GMPVoice(1))
    @test isa(rule, FiniteVerbRule)
    @test rule.stemclass == "w_regular"
    @test rule.ending == "ει"
    @test rule.vperson == GMPPerson(3)
    @test rule.vnumber == GMPNumber(1)
    @test rule.vtense == GMPTense(1)
    @test rule.vmood == GMPMood(1)
    @test rule.vvoice == GMPVoice(1)
end


@testset ExtendedTestSet "Read stems for verb tokens from delimited text"  begin    
    #Rule|LexicalEntity|StemClass|Stem|
    cexsrc = "verbstems.n56496|lsj.n56496|κελευ|w_regular|"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    @test stem.stemid == StemUrn("verbstems.n56496")
    @test stem.lexid == LexemeUrn("lsj.n56496")
    @test stem.stem == "κελευ"
    @test stem.stemclass == "w_regular"

end

@testset ExtendedTestSet "Read stems for irregular verb tokens from delimited text"  begin  
    cexsrc = "irregverb.n110639a|lsj.n110639|φησί|third|singular|present|indicative|active|irregularverb"
    verbio = Kanones.VerbIO("verbs")
    stem = Kanones.readstemrow(verbio, cexsrc)
    @test stem.stemid == StemUrn("irregverb.n110639a")
    @test stem.lexid == LexemeUrn("lsj.n110639")
    @test stem.stem == "φησί"
    @test_broken stem.stemclass == "irregular"
end