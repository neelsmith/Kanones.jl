@testset "Format fst rules for noun tokens" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounIO("nouns")
    rulerow = Kanones.readrulerow(nounparser, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<h_hs><noun>ης<feminine><genitive><singular><u>nouninfl\\.h\\_hs2</u>"
    @test FstBuilder.fst(rulerow) == expected
end

@testset "Format fst lexicon for noun stems" begin
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|masculine|h_hs|recessive|"
    nounparser = Kanones.NounIO("nouns")
    stemrow = Kanones.readstemrow(nounparser, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>nounstems\\.n22502</u><u>lexent\\.n22502</u>γνωμ<noun><masculine><h_hs>"
    @test FstBuilder.fst(stemrow) == expected
end


@testset "Format fst lexicon for irregular noun stems" begin
    cex = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    
    parser = Kanones.IrregularNounIO("irregular nouns")
    stemrow = Kanones.readstemrow(parser, cex)

    expected = "<u>irregnoun\\.irregn23069a</u><u>lsj\\.n23069</u>γυνη<irregular><irregularnoun><feminine><nominative><singular>"
    @test FstBuilder.fst(stemrow) == expected
end


