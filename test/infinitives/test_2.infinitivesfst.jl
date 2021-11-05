@testset "Format fst rules for infinitive tokens" begin
    cex = "infinfl.wreg1|w_regular|ειν|present|active"
    infinparser = Kanones.InfinitiveIO("infinitives")
    rulerow = Kanones.readrulerow(infinparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<w_regular><infinitive>ειν<present><active><u>infinfl\\.wreg1</u>"
    @test FstBuilder.fst(rulerow) == expected
end

# Regular verb stems are tested under finite verbs

@testset "Format fst lexicon for irregular infinitive stems" begin
    cexsrc = "irreginf.irreginfln26447a|lsj.n26447|διδόναι|present|active|irregularinfinitive"
    irreginfio = Kanones.IrregularInfinitiveIO("irregular infinitives")
    stem = Kanones.readstemrow(irreginfio, cexsrc)
    expected = "<u>irreginf\\.irreginfln26447a</u><u>lsj\\.n26447</u>διδοναι<irregular><irregularinfinitive><present><active>"
    @test FstBuilder.fst(stem) == expected
end