
@testset ExtendedTestSet "Test accessing adjective form properties" begin
    adj = GMFAdjective(gmpGender("feminine"), gmpCase("dative"), gmpNumber("singular"), gmpDegree("positive"))
    @test gmpGender(adj) == GMPGender(2)
    @test gmpCase(adj) == GMPCase(3)
    @test gmpNumber(adj) == GMPNumber(1)
    @test gmpDegree(adj) == GMPDegree(1)
end

@testset ExtendedTestSet "Test accessing adjective rule properties" begin
    cexsrc = "adjinfl.oshon_pos1|os_h_on_pos|ος|masculine|nominative|singular|positive|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    rule = Kanones.readrulerow(adjectiveio, cexsrc)
    @test gmpGender(rule) == GMPGender(1)
    @test gmpCase(rule) == GMPCase(1)
    @test gmpNumber(rule) == GMPNumber(1)
    @test gmpDegree(rule) == GMPDegree(1)
end

@testset ExtendedTestSet "Test accessing irregular adjective stem properties" begin
    cexsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irregadjio = Kanones.IrregularAdjectiveIO("irregular adjs r/w")
    stem = Kanones.readstemrow(irregadjio, cexsrc)
    @test gmpGender(stem) == GMPGender(1)
    @test gmpCase(stem) == GMPCase(1)
    @test gmpNumber(stem) == GMPNumber(1)
    @test gmpDegree(stem) == GMPDegree(1)
end
