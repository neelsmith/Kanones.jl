@testset "Test accessing noun form properties" begin
    noun = GMFNoun(gmpGender("feminine"), gmpCase("dative"), gmpNumber("singular"))
    @test gmpGender(noun) == GMPGender(2)
    @test gmpCase(noun) == GMPCase(3)
    @test gmpNumber(noun) == GMPNumber(1)
end

@testset "Test accessing noun stem properties" begin
    cexsrc = "nounstems.n22502|lexent.n22502|γνωμ|feminine|h_hs|recessive|"
    nounsio = Kanones.NounIO("nouns")
    stem = Kanones.readstemrow(nounsio, cexsrc)
    @test gmpGender(stem) == GMPGender(2)
    @test isnothing(gmpCase(stem))
    @test isnothing(gmpNumber(stem))
end

@testset "Test accessing noun rule properties" begin
    cexsrc = "nouninfl.h_hs2|h_hs|ης|feminine|genitive|singular|recessive"
    nounparser = Kanones.NounIO("nouns")
    rule = Kanones.readrulerow(nounparser, cexsrc)
    @test gmpGender(rule) == GMPGender(2)
    @test gmpCase(rule) == GMPCase(2)
    @test gmpNumber(rule) == GMPNumber(1)
end

@testset "Test accessing irregular noun stem properties" begin
    cexsrc = "irregnoun.irregn23069a|lsj.n23069|γυνή|feminine|nominative|singular|irregularnoun"
    irregnounio = Kanones.IrregularNounIO("irregular nouns")
    stem = Kanones.readstemrow(irregnounio, cexsrc)
    @test gmpGender(stem) == GMPGender(2)
    @test gmpCase(stem) == GMPCase(1)
    @test gmpNumber(stem) == GMPNumber(1)
end