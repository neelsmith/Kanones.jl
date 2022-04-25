@testset ExtendedTestSet "Test citable trait for AdjectiveStem" begin
    cexsrc = "adjstems.n52840a|lsj.n52840|καλ|os_h_on_pos|inflectionaccented|"
    adjectiveio = Kanones.AdjectiveIO("adjectives")
    stem = Kanones.readstemrow(adjectiveio, cexsrc)

    @test label(stem) == "Adjective stem καλ- (type os_h_on_pos)"
    @test urn(stem) == StemUrn("adjstems.n52840a")
    @test cex(stem) == "adjstems.n52840a|Adjective stem καλ- (type os_h_on_pos)"

    dict = Dict(
       "adjstems" => "urn:cite2:kanones:adjstems.v1:"
       )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:adjstems.v1:n52840a")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:adjstems.v1:n52840a|Adjective stem καλ- (type os_h_on_pos)"

end

@testset ExtendedTestSet "Test citable trait for IrregularAdjectiveStem" begin
    cexsrc = "irregadj.n79904a|lsj.n79904|πᾶς|masculine|nominative|singular|positive|irregularadjective"
    irregadjio = Kanones.IrregularAdjectiveIO("irregular adjs r/w")
    stem = Kanones.readstemrow(irregadjio, cexsrc)
    @test label(stem) == "Irregular adjective form πᾶς (masculine nominative singular positive)"
    @test urn(stem) == StemUrn("irregadj.n79904a")
    @test cex(stem) == "irregadj.n79904a|Irregular adjective form πᾶς (masculine nominative singular positive)"
    dict = Dict(
        "irregadj" => "urn:cite2:kanones:irregadj.v1:"
        )
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:kanones:irregadj.v1:n79904a")
    @test cex(stem; registry = dict) == "urn:cite2:kanones:irregadj.v1:n79904a|Irregular adjective form πᾶς (masculine nominative singular positive)"
end