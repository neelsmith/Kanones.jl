
@testset "Format fst lexicon for adjective stems" begin
    cexsrc = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjio = Kanones.AdjectiveIO("adjectives")
    stem = Kanones.readstemrow(adjio, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>adjstems\\.n52840a</u><u>lsj\\.n52840</u>καλ<adjective><os_h_on_pos>"
    @test FstBuilder.fst(stem) == expected
end

@testset "Format fst rules for adjective tokens" begin
    cexsrc = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, cexsrc)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<os_h_on_pos><adjective>ος<masculine><nominative><singular><positive><u>adjinfl\\.oshon\\_pos1</u>"
    @test FstBuilder.fst(rule) == expected
end


@testset "Format fst lexicon for irregular noun stems" begin
    cexsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irregadjio = Kanones.IrregularAdjectiveIO("irregular adjs r/w")
    stem = Kanones.readstemrow(irregadjio, cexsrc)

    expected = "<u>irregadj\\.n79904a</u><u>lsj\\.n79904</u>πας<irregular><irregularnoun><masculine><nominative><singular><positive>"
    @test FstBuilder.fst(stem) == expected
end

