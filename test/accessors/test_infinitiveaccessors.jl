@testset "Test accessing infinitive form properties" begin
    inf = GMFInfinitive( gmpTense("present"), gmpVoice("active"))
    @test gmpTense(inf) == GMPTense(1)
    @test gmpVoice(inf) == GMPVoice(1)
end

@testset "Test accessing irregular infinitive stem properties" begin
    cexsrc = "irreginf.irreginfln26447a|lsj.n26447|διδόναι|present|active|irregularinfinitive"
    irreginfio = Kanones.IrregularInfinitiveIO("irregular infinitives")
    stem = Kanones.readstemrow(irreginfio, cexsrc)
    @test gmpTense(stem) == GMPTense(1)
    @test gmpVoice(stem) == GMPVoice(1)
end

@testset "Test accessing infinitive rule properties" begin
    cexsrc = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rule = Kanones.readrulerow(infinparser, cexsrc)
    @test gmpTense(rule) == GMPTense(1)
    @test gmpVoice(rule) == GMPVoice(1)
end
