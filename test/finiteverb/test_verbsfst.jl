@testset "Format fst rules for verb tokens" begin
    cex = "verbinfl.wreg3rd1|w_regular|ει|3rd|singular|present|indicative|active"
    verbparser = Kanones.VerbParser("verbs")
    rulerow = Kanones.readrulerow(verbparser, cex)
    expected = "<w_regular><finiteverb>ει<3rd><singular><present><indicative><active><u>verbinfl\\.wreg3rd1</u>"

    
    @test FstBuilder.fst(rulerow, literaryGreek()) == expected
end


@testset "Format fst lexicon for verb stems" begin
    cex = "verbstems.n56496|lexent.n56496|κελευ|w_regular|"
    verbparser = Kanones.VerbParser("verbs")
    stemrow = Kanones.readstemrow(verbparser, cex)
    expected = "<u>verbstems\\.n56496</u><u>lexent\\.n56496</u>κελευ<finiteverb><w_regular>"
    @test FstBuilder.fst(rulerow, literaryGreek()) == expected
end