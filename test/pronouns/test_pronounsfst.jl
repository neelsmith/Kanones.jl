@testset "Format fst lexicon for pronoun stems" begin
    cex = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounparser = Kanones.PronounParser("pronouns")
    stemrow = Kanones.readstemrow(pronounparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>pronoun\\.n71882a</u><u>lsj\\.n71882</u>ὁ<pronoun><masculine><nominative><singular><article>"
    @test FstBuilder.fst(stemrow, literaryGreek()) == expected
end


@testset "Format fst rules for pronoun tokens" begin
    cex = "litgreek.pronouns1|article"
    pronounparser = Kanones.PronounParser("pronouns")
    rulerow = Kanones.readrulerow(pronounparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    #expected = "<h_hs><noun>ης<feminine><genitive><singular><u>nouninfl\\.h\\_hs2</u>"
    expected = "<article><pronoun><u>litgreek\\.pronouns1</u>"
    @test FstBuilder.fst(rulerow, literaryGreek()) == expected
end
