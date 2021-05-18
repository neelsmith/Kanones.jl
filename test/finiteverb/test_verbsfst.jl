@testset "Format fst rules for verb tokens" begin
    cex = "verbinfl.wreg3rd1|w_regular|ει|3rd|singular|present|indicative|active"
    verbparser = Kanones.VerbParser("verbs")
    rulerow = Kanones.readrulerow(verbparser, cex)
    expected = "<w_regular><finiteverb>ει<3rd><singular><present><indicative><active><u>verbinfl\\.wreg3rd1</u>"

    
    @test FstBuilder.fst(rulerow, literaryGreek()) == expected
end


@testset "Format fst lexicon for verb stems" begin
    #=

    cex = "nounstems.n22502|lexent.n22502|γνωμ|masculine|h_hs|recessive|"
    nounparser = Kanones.NounParser("nouns")
    stemrow = Kanones.readstemrow(nounparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>nounstems\\.n22502</u><u>lexent\\.n22502</u>γνωμ<noun><masculine><h_hs>"
    @test FstBuilder.fst(stemrow, literaryGreek()) == expected
    =#
end