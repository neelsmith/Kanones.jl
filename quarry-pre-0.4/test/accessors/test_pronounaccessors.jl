@testset ExtendedTestSet "Test accessing pronoun form properties" begin
    pronoun = GMFPronoun(gmpGender("feminine"), gmpCase("dative"), gmpNumber("singular"))
    @test gmpGender(pronoun) == GMPGender(2)
    @test gmpCase(pronoun) == GMPCase(3)
    @test gmpNumber(pronoun) == GMPNumber(1)
end

@testset ExtendedTestSet "Test accessing pronoun stem properties" begin
    cexsrc = "pronoun.n71882a|lsj.n71882|ὁ|masculine|nominative|singular|article"
    pronounsio = Kanones.PronounIO("nouns")
    stem = Kanones.readstemrow(pronounsio, cexsrc)
    @test gmpGender(stem) == GMPGender(1)
    @test gmpCase(stem) == GMPCase(1)
    @test gmpNumber(stem) == GMPNumber(1)

end
