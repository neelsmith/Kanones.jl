@testset "Read rules for infinitives from delimited text" begin
    cex = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rulerow = Kanones.readrulerow(infinparser, cex)
    rulerow.ruleid |> string == "infinfl.wreg1"

    @test rulerow.inflectionclass == "w_regular"
    @test rulerow.ending == "ειν"
    @test rulerow.tense == "present"
    @test rulerow.voice == "active"
end

# No need to test *regular* stems:  infinitives use same regular stem as finite verbs, where
# those are tested.


@testset "Read stems for irregular infinitives from delimited text" begin
    cexsrc = "irreginf.irreginfln26447a|lsj.n26447|διδόναι|present|active|irregularinfinitive"
    irreginfio = Kanones.IrregularInfinitiveIO("irregular infinitives")
    stem = Kanones.readstemrow(irreginfio, cexsrc)

    @test  stem.stemid  == StemUrn("irreginf.irreginfln26447a") 
    @test stem.lexid == LexemeUrn("lsj.n26447") 
    @test stem.form == nfkc("διδόναι")
    @test stem.tense == "present"
    @teset stem.voice == "active"
end