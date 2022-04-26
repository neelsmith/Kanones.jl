@testset ExtendedTestSet "Read rules for infinitives from delimited text" begin
    cexsrc = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rule = Kanones.readrulerow(infinparser, cexsrc)
    rule.ruleid |> string == "infinfl.wreg1"

    @test rule.inflectionclass == "w_regular"
    @test rule.ending == "ειν"
    @test rule.tense == GMPTense(1)
    @test rule.voice == GMPVoice(1)
end

# No need to test *regular* stems:  infinitives use same regular stem as finite verbs, where
# those are tested.


@testset ExtendedTestSet "Read stems for irregular infinitives from delimited text" begin
    cexsrc = "irreginf.irreginfln26447a|lsj.n26447|διδόναι|present|active|irregularinfinitive"
    irreginfio = Kanones.IrregularInfinitiveIO("irregular infinitives")
    stem = Kanones.readstemrow(irreginfio, cexsrc)

    @test  stem.stemid  == StemUrn("irreginf.irreginfln26447a") 
    @test stem.lexid == LexemeUrn("lsj.n26447") 
    @test stem.form == nfkc("διδόναι")
    @test stem.tense == GMPTense(1)
    @test stem.voice == GMPVoice(1)
end