


@testset "Format fst lexicon for adjective stems" begin
    cex = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjparser = Kanones.AdjectiveParser("adjectives")
    stemrow = Kanones.readstemrow(adjparser, cex)
    # Note that "." and "_" must be protected in FST string values, but not in symbols.
    expected = "<u>adjstems\\.n52840a</u><u>lsj\\.n52840</u>καλ<adjective><os_h_on_pos>"
    @test FstBuilder.fst(stemrow) == expected
end

