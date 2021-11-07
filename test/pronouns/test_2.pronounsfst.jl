@testset "Format fst lexicon for pronoun stems" begin
    cexsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounio = Kanones.PronounIO("pronouns")
    stemrow = Kanones.readstemrow(pronounio, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>pronoun\\.n71882a</u><u>lsj\\.n71882</u>ὁ<pronoun><masculine><nominative><singular><article>"
    @test FstBuilder.fst(stemrow) == expected
end


@testset "Format fst rules for pronoun tokens" begin
    cexsrc = "pronounrules.pronouns1|article"
    pronounio = Kanones.PronounIO("pronouns")
    rulerow = Kanones.readrulerow(pronounio, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    #expected = "<h_hs><noun>ης<feminine><genitive><singular><u>nouninfl\\.h\\_hs2</u>"
    expected = "<article><pronoun><u>pronounrules\\.pronouns1</u>"
    @test FstBuilder.fst(rulerow) == expected
end
